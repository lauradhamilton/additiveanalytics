copy medicare_costs(npi
,last_name
,first_name
,mi
,credentials
,gender
,entity_code
,address_line_1
,address_line_2
,city
,zip
,state
,country
,provider_type
,medicare_participation_indicator
,place_of_service
,hcpcs_code
,hcpcs_description
,services_provided_count
,beneficiaries_count
,distinct_services_per_beneficiary_count
,average_medicare_allowed_amount
,stdev_medicare_allowed_amount
,average_submitted_charge_amount
,stdev_submitted_charge_amount
,average_medicare_payment_amount
,stdev_medicare_payment_amount)
from '/home/laura/Downloads/Medicare-Physician-and-Other-Supplier-PUF-CY2012.txt'
delimiter E'\t'
CSV HEADER
