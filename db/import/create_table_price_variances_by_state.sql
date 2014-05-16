create table price_variances_by_state as
select
distinct(state)
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
group by 1
order by 1