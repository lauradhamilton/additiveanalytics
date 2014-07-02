select
p.patient_id
,p.gender
,p.first_name
,p.last_name
,p.email
,p.phone_number
,p.work_phone
,p.cell_phone
from patients p
where not exists
	(select 1 from immunizations i
	where i.patient_id = p.patient_id
		and display_date >
			-- Start looking for flu vaccinations on July 1
			-- Flu vaccines should start to become available in late July
			-- Count any vaccinations prior to July 1 as belonging to the previous flu season
			case
				when date_part('month', current_date) >= 7
					then date_trunc('year', current_date) + interval '6 months'
				when date_part('month', current_date) < 7
					then date_trunc('year', current_date - interval '1 year') + interval '6 months'
				end
	and i.code = 90658)
