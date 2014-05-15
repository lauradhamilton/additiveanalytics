drop table if exists medicare_cost_summaries;

select
last_name as provider_name
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
,sum(services_provided_count) as procedures_count
,round(avg(average_medicare_allowed_amount),2) as average_cost
into medicare_cost_summaries
from medicare_costs
where entity_code = 'O'
and hcpcs_code in ('29881','29880','29827','29848','50590','29823','28296','67040','19301'
,'52648','49650','19125','L8619','29828')
group by 1,2,3
order by 5 desc
