drop table if exists medicare_cost_summaries;

create table medicare_cost_summaries (
id integer PRIMARY KEY
,provider_name varchar(255)
,state varchar(255)
,procedure_type text
,procedures_count integer
,average_cost numeric
);

drop sequence if exists medicare_cost_summaries_id_seq;

CREATE SEQUENCE medicare_cost_summaries_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE medicare_cost_summaries_id_seq
  OWNER TO rails_app;

insert into medicare_cost_summaries
select
nextval('medicare_cost_summaries_id_seq') as id
,last_name as provider_name
,state
,case hcpcs_code
        when '29881' then 'Knee surgery'
        when '29880' then 'Knee surgery'
        when '29827' then 'Rotator cuff repair'
        when '29848' then 'Wrist surgery'
        when '50590' then 'Kidney stone removal'
        when '29823' then 'Shoulder surgery'
        when '28296' then 'Bunion correction'
        when '67040' then 'Laser treatment of retina'
        when '19301' then 'Mastectomy'
        when '52648' then 'Prostate surgery'
        when '49650' then 'Hernia repair'
        when '19125' then 'Breast lesion removal'
        when 'L8619' then 'Cochlear implant'
        when '29828' then 'Bicep surgery'
        else null end as procedure_type
,round(sum(services_provided_count)) as procedures_count
 --I found two rows with a fractional prodedure count, ending in 0.5
 --Dunno why but I'm gonna round them away
,round(avg(average_medicare_allowed_amount),2) as average_cost
from medicare_costs
where entity_code = 'O'
and hcpcs_code in ('29881','29880','29827','29848','50590','29823','28296','67040','19301'
,'52648','49650','19125','L8619','29828')
group by 2,3,4
order by 6 desc;

