drop table if exists price_variances_by_states;

create table price_variances_by_states(
id integer PRIMARY KEY
,state varchar(255)
,diff_versus_nationwide_average numeric
);

drop sequence if exists price_variances_by_states_id_seq;

CREATE SEQUENCE price_variances_by_states_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE price_variances_by_states_id_seq
  OWNER TO rails_app;

insert into price_variances_by_states
select
nextval('price_variances_by_states_id_seq') as id
,state
,round(avg(percent_diff_vs_average*100),1) as diff_versus_nationwide_average
from(
select
state
,mcs.procedure_type
,average_cost
,nationwide_average
,average_cost/nationwide_average - 1 as percent_diff_vs_average
from medicare_cost_summaries mcs
inner join nationwide_cost_averages ncs on ncs.procedure_type = mcs.procedure_type) as t
group by 2
order by 2
