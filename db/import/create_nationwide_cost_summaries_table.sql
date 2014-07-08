drop table if exists nationwide_cost_averages;

create table nationwide_cost_averages as
select
distinct(procedure_type)
,round(avg(average_cost),2) as nationwide_average
from medicare_cost_summaries
group by 1
order by 1;