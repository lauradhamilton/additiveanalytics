require 'rails'

class Patient < ActiveRecord::Base
  has_many :immunizations, primary_key: 'patient_id'
  has_many :immunization_tasks, primary_key: 'patient_id'

  # Don't save empty strings. Store them as null values in the db.
  nilify_blanks

  def patient_name
    first_name + ' ' + last_name
  end

  def self.find_patients_to_import
    changed_patients_hash = JSON[AllscriptsIntegration.get_changed_patients][0]['getchangedpatientsinfo']
    changed_patients_array = []
    changed_patients_hash.each do |patient|
      changed_patients_array.push patient['patientid'].to_i
    end
    changed_patients_array
  end

  def self.import_all_patients
    all_patients = Patient.find_patients_to_import
    all_patients.each do |patient_id|
      import_patient(patient_id)
    end
  end

  def self.import_patient(patient_id)
    patient = AllscriptsIntegration.get_patient(patient_id)
    new_patient_hash = JSON[patient][0]['getpatientinfo'][0]
    new_patient = Patient.new

    new_patient.patient_id = patient_id
    new_patient.age = new_patient_hash['age']
    new_patient.gender = new_patient_hash['gender']
    new_patient.marital_status = new_patient_hash['MaritalStatus']
    # Why the fuck are there 3 different conventions for returning names???
    new_patient.first_name = new_patient_hash['Firstname']
    new_patient.middle_name = new_patient_hash['middlename']
    new_patient.last_name = new_patient_hash['LastName']
    new_patient.suffix = new_patient_hash['Suffix']
    new_patient.occupation = new_patient_hash['Occupation']
    new_patient.employer = new_patient_hash['Employer']
    new_patient.phone_number = new_patient_hash['PhoneNumber']
    new_patient.work_phone = new_patient_hash['WorkPhone']
    new_patient.cell_phone = new_patient_hash['CellPhone']
    new_patient.address_line_1 = new_patient_hash['AddressLine1']
    new_patient.address_line_2 = new_patient_hash['AddressLine2']
    new_patient.city = new_patient_hash['City']
    new_patient.state = new_patient_hash['State']
    new_patient.zip = new_patient_hash['Zip']
    new_patient.email = new_patient_hash['Email']
    new_patient.date_of_birth = new_patient_hash['dateofbirth']
    new_patient.physician_phone = new_patient_hash['PhysPhone']
    new_patient.physician_first_name = new_patient_hash['PhysFirstName']
    new_patient.physician_last_name = new_patient_hash['PhysLastName']
    new_patient.physician_username = new_patient_hash['PhysUserName']
    new_patient.base64image = new_patient_hash['base64image']
    new_patient.primary_insurance = new_patient_hash['PrimaryInsurance']
    new_patient.language = new_patient_hash['Language']
    new_patient.race = new_patient_hash['Race']
    new_patient.ethnicity = new_patient_hash['Ethnicity']
    new_patient.ssn = new_patient_hash['ssn']
    new_patient.mrn = new_patient_hash['mrn']
    new_patient.picture_of_patient = new_patient_hash['patientpix']
    new_patient.age_dec = new_patient_hash['AgeDec']
    new_patient.patient_location = new_patient_hash['PatientLocation']

    # Only import patients we have not seen before
    new_patient.save unless Patient.find_by_patient_id(patient_id)
  end

  def self.find_patients_needing_first_hepatitis_a_shot
    hepatitis_a_cpt = IMMUNIZATIONS_CONFIG['hepatitis_a']['cpt']
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '12 months'
      and not exists (select 1 from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{hepatitis_a_cpt}))"
  end

  def self.find_patients_needing_second_hepatitis_a_shot
    hepatitis_a_cpt = IMMUNIZATIONS_CONFIG['hepatitis_a']['cpt']
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '18 months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{hepatitis_a_cpt})
        group by 1
        having count(i.id) = 1) -- Patients who have only received 1 hep a shot
      and not exists (select 1 from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{hepatitis_a_cpt})
        and i.display_date > current_date - interval '6 months')"
  end

  def self.find_patients_needing_first_hepatitis_b_shot
    hepatitis_b_cpt = IMMUNIZATIONS_CONFIG['hepatitis_b']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['hepatitis_b']['patient_age_in_months'][0]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and not exists (select 1
        from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{hepatitis_b_cpt}))"
  end

  def self.find_patients_needing_second_hepatitis_b_shot
    hepatitis_b_cpt = IMMUNIZATIONS_CONFIG['hepatitis_b']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['hepatitis_b']['patient_age_in_months'][1]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{hepatitis_b_cpt})
        group by 1
        having count(i.id) = 1) -- Patients who have only received 1 hep b shot
      and not exists (select 1 from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{hepatitis_b_cpt})
        and i.display_date > current_date - interval '1 months')"
  end

  def self.find_patients_needing_third_hepatitis_b_shot
    hepatitis_b_cpt = IMMUNIZATIONS_CONFIG['hepatitis_b']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['hepatitis_b']['patient_age_in_months'][2]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{hepatitis_b_cpt})
        group by 1
        having count(i.id) = 2) -- Patients who have only received 2 hep b shots
      and (select min(display_date) from immunizations i
        where i.patient_id = p.patient_id
        --Third dose must be at least 6 months after the first dose
        and i.code in (#{hepatitis_b_cpt})) < current_date - interval '6 months'"
  end

  def self.find_patients_needing_first_rotavirus_shot
    rotavirus_cpt = IMMUNIZATIONS_CONFIG['rotavirus']['cpt']
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '2 months'
      and p.date_of_birth > current_date - interval '15 weeks'
        -- Only appropriate for babies between 6 weeks and 14 weeks 6 days old
      and not exists (select 1
        from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{rotavirus_cpt}))"
  end

  def self.find_patients_needing_second_rotarix_shot
    rotarix_cpt = IMMUNIZATIONS_CONFIG['rotavirus']['rotarix']['cpt']
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '4 months'
      and p.date_of_birth > current_date - interval '8 months'
      and (select count(id)
        from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{rotarix_cpt})) = 1
      and (select min(display_date)
        from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{rotarix_cpt})) < current_date - interval '4 weeks'
          -- 2nd dose should come at least 4 weeks after the 1st one"
  end

  def self.find_patients_needing_second_rotateq_shot
    rotateq_cpt = IMMUNIZATIONS_CONFIG['rotavirus']['rotateq']['cpt']
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '4 months'
      and p.date_of_birth > current_date - interval '8 months'
      and (select count(id)
        from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{rotateq_cpt})) = 1
      and (select min(display_date)
        from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{rotateq_cpt})) < current_date - interval '4 weeks'
          -- 2nd dose should come at least 4 weeks after the 1st one"
  end

  def self.find_patients_needing_third_rotateq_shot
    rotateq_cpt = IMMUNIZATIONS_CONFIG['rotavirus']['rotateq']['cpt']
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '6 months'
      and p.date_of_birth > current_date - interval '8 months'
      and (select count(id)
        from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{rotateq_cpt})) = 2
      and (select min(display_date)
        from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{rotateq_cpt})) < current_date - interval '4 weeks'
          -- 3rd dose should come at least 4 weeks after the 2nd one"
  end

  def self.find_patients_needing_first_dpt_shot
    dpt_cpt = IMMUNIZATIONS_CONFIG['diptheria_tetanus_pertussis']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['diptheria_tetanus_pertussis']['patient_age_in_months'][0]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and not exists (select 1
        from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{dpt_cpt}))"
  end

  def self.find_patients_needing_second_dpt_shot
    dpt_cpt = IMMUNIZATIONS_CONFIG['diptheria_tetanus_pertussis']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['diptheria_tetanus_pertussis']['patient_age_in_months'][1]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{dpt_cpt})
        group by 1
        having count(i.id) = 1)"
  end

  def self.find_patients_needing_third_dpt_shot
    dpt_cpt = IMMUNIZATIONS_CONFIG['diptheria_tetanus_pertussis']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['diptheria_tetanus_pertussis']['patient_age_in_months'][2]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{dpt_cpt})
        group by 1
        having count(i.id) = 2)"
  end

  def self.find_patients_needing_fourth_dpt_shot
    dpt_cpt = IMMUNIZATIONS_CONFIG['diptheria_tetanus_pertussis']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['diptheria_tetanus_pertussis']['patient_age_in_months'][3]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{dpt_cpt})
        group by 1
        having count(i.id) = 3)"
  end

  def self.find_patients_needing_fifth_dpt_shot
    dpt_cpt = IMMUNIZATIONS_CONFIG['diptheria_tetanus_pertussis']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['diptheria_tetanus_pertussis']['patient_age_in_months'][4]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{dpt_cpt})
        group by 1
        having count(i.id) = 4)
      and not exists (select 1 from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{dpt_cpt})
        and i.display_date > current_date - interval '10 years')"
    # Booster after 10 years
  end

  def self.find_patients_needing_first_haemophilus_influenza_shot
    haemophilus_influenza_cpt = IMMUNIZATIONS_CONFIG['haemophilus_influenza']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['haemophilus_influenza']['patient_age_in_months'][0]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.date_of_birth > current_date - interval '5 years'
        -- CDC does not recommend Hib for anyone age 5 years or older
        -- Unless they are at increased risk for Hib infection
      and not exists (select 1
        from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{haemophilus_influenza_cpt}))"
  end

  def self.find_patients_needing_second_haemophilus_influenza_shot
    haemophilus_influenza_cpt = IMMUNIZATIONS_CONFIG['haemophilus_influenza']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['haemophilus_influenza']['patient_age_in_months'][1]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.date_of_birth > current_date - interval '5 years'
        -- CDC does not recommend Hib for anyone age 5 years or older
        -- Unless they are at increased risk for Hib infection
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{haemophilus_influenza_cpt})
        group by 1
        having count(i.id) = 1)"
  end

  def self.find_patients_needing_third_haemophilus_influenza_shot
    haemophilus_influenza_cpt = IMMUNIZATIONS_CONFIG['haemophilus_influenza']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['haemophilus_influenza']['patient_age_in_months'][2]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.date_of_birth > current_date - interval '5 years'
        -- CDC does not recommend Hib for anyone age 5 years or older
        -- Unless they are at increased risk for Hib infection
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{haemophilus_influenza_cpt})
        group by 1
        having count(i.id) = 2)"
  end

  def self.find_patients_needing_fourth_haemophilus_influenza_shot
    haemophilus_influenza_cpt = IMMUNIZATIONS_CONFIG['haemophilus_influenza']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['haemophilus_influenza']['patient_age_in_months'][3]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.date_of_birth > current_date - interval '5 years'
        -- CDC does not recommend Hib for anyone age 5 years or older
        -- Unless they are at increased risk for Hib infection
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{haemophilus_influenza_cpt})
        group by 1
        having count(i.id) = 3)"
  end

  def self.find_patients_needing_first_pneumococcal_conjugate_shot
    pneumococcal_conjugate_cpt = IMMUNIZATIONS_CONFIG['pneumococcal_conjugate']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['pneumococcal_conjugate']['patient_age_in_months'][0]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and not exists (select 1
        from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{pneumococcal_conjugate_cpt}))"
  end

  def self.find_patients_needing_second_pneumococcal_conjugate_shot
    pneumococcal_conjugate_cpt = IMMUNIZATIONS_CONFIG['pneumococcal_conjugate']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['pneumococcal_conjugate']['patient_age_in_months'][1]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{pneumococcal_conjugate_cpt})
        group by 1
        having count(i.id) = 1)"
  end

  def self.find_patients_needing_third_pneumococcal_conjugate_shot
    pneumococcal_conjugate_cpt = IMMUNIZATIONS_CONFIG['pneumococcal_conjugate']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['pneumococcal_conjugate']['patient_age_in_months'][2]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{pneumococcal_conjugate_cpt})
        group by 1
        having count(i.id) = 2)"
  end

  def self.find_patients_needing_fourth_pneumococcal_conjugate_shot
    pneumococcal_conjugate_cpt = IMMUNIZATIONS_CONFIG['pneumococcal_conjugate']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['pneumococcal_conjugate']['patient_age_in_months'][3]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{pneumococcal_conjugate_cpt})
        group by 1
        having count(i.id) = 3)"
  end

  def self.find_patients_needing_pneumococcal_polysaccharide_shots
    pneumococcal_polysaccharide_start_age = IMMUNIZATIONS_CONFIG['pneumococcal_polysaccharide']['patient_age_in_months'][0]
    pneumococcal_polysaccharide_cpt = IMMUNIZATIONS_CONFIG['pneumococcal_polysaccharide']['cpt']
    Patient.find_by_sql "select * from patients p
      where date_of_birth < current_date - interval '#{pneumococcal_polysaccharide_start_age} months'
      and not exists (select 1 from immunizations i
        where i.patient_id = p.patient_id
          and i.code in (#{pneumococcal_polysaccharide_cpt}))"
  end

  def self.find_patients_needing_first_poliovirus_shot
    poliovirus_cpt = IMMUNIZATIONS_CONFIG['poliovirus']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['poliovirus']['patient_age_in_months'][0]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and not exists (select 1
        from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{poliovirus_cpt}))"
  end

  def self.find_patients_needing_second_poliovirus_shot
    poliovirus_cpt = IMMUNIZATIONS_CONFIG['poliovirus']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['poliovirus']['patient_age_in_months'][1]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{poliovirus_cpt})
        group by 1
        having count(i.id) = 1)"
  end

  def self.find_patients_needing_third_poliovirus_shot
    poliovirus_cpt = IMMUNIZATIONS_CONFIG['poliovirus']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['poliovirus']['patient_age_in_months'][2]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{poliovirus_cpt})
        group by 1
        having count(i.id) = 2)"
  end

  def self.find_patients_needing_fourth_poliovirus_shot
    poliovirus_cpt = IMMUNIZATIONS_CONFIG['poliovirus']['cpt']
    patient_age = IMMUNIZATIONS_CONFIG['poliovirus']['patient_age_in_months'][3]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{patient_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{poliovirus_cpt})
        group by 1
        having count(i.id) = 3)"
  end

  def self.find_patients_needing_influenza_shots
    influenza_cpt = IMMUNIZATIONS_CONFIG['influenza']['cpt']
    Patient.find_by_sql "select *
      from patients p
      where not exists
              (select 1 from immunizations i
              where i.patient_id = p.patient_id
                      and display_date >
                              /*Start looking for flu vaccinations on July 1
                              Flu vaccines should start to become available in late July
                              Count any vaccinations prior to July 1 as belonging to the previous flu season */
                              case
                                      when date_part('month', current_date) >= 7
                                              then date_trunc('year', current_date) + interval '6 months'
                                      when date_part('month', current_date) < 7
                                              then date_trunc('year', current_date - interval '1 year') + interval '6 months'
                                      end
              and i.code in (#{influenza_cpt}))"
  end

  def self.find_patients_needing_first_mmr_shot
    mmr_cpt = IMMUNIZATIONS_CONFIG['measles_mumps_rubella']['cpt']
    mmr_start_age = IMMUNIZATIONS_CONFIG['measles_mumps_rubella']['patient_age_in_months'][0]
    Patient.find_by_sql "select *
      from patients p
      where date_of_birth < current_date - interval '#{mmr_start_age} months'
      and not exists (select 1 from immunizations i
        where i.patient_id = p.patient_id
          and i.code in (#{mmr_cpt}))"
  end

  def self.find_patients_needing_second_mmr_shot
    mmr_cpt = IMMUNIZATIONS_CONFIG['measles_mumps_rubella']['cpt']
    mmr_start_age = IMMUNIZATIONS_CONFIG['measles_mumps_rubella']['patient_age_in_months'][1]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{mmr_start_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{mmr_cpt})
        group by 1
        having count(i.id) = 1)"
  end

  def self.find_patients_needing_first_varicella_shot
    varicella_cpt = IMMUNIZATIONS_CONFIG['varicella']['cpt']
    varicella_start_age = IMMUNIZATIONS_CONFIG['varicella']['patient_age_in_months'][0]
    Patient.find_by_sql "select *
      from patients p
      where date_of_birth < current_date - interval '#{varicella_start_age} months'
      and not exists (select 1 from immunizations i
        where i.patient_id = p.patient_id
          and i.code in (#{varicella_cpt}))"
  end

  def self.find_patients_needing_second_varicella_shot
    varicella_cpt = IMMUNIZATIONS_CONFIG['varicella']['cpt']
    varicella_start_age = IMMUNIZATIONS_CONFIG['varicella']['patient_age_in_months'][1]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{varicella_start_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{varicella_cpt})
        group by 1
        having count(i.id) = 1)
      and not exists (select 1 from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{varicella_cpt})
        and i.display_date > current_date - interval '3 months')"
  end

  def self.find_patients_needing_first_human_papillomavirus_shot
    human_papillomavirus_cpt = IMMUNIZATIONS_CONFIG['human_papillomavirus']['cpt']
    human_papillomavirus_start_age = IMMUNIZATIONS_CONFIG['human_papillomavirus']['patient_age_in_months'][0]
    Patient.find_by_sql "select *
      from patients p
      where date_of_birth < current_date - interval '#{human_papillomavirus_start_age} months'
      and not exists (select 1 from immunizations i
        where i.patient_id = p.patient_id
          and i.code in (#{human_papillomavirus_cpt}))"
  end

  def self.find_patients_needing_second_human_papillomavirus_shot
    human_papillomavirus_cpt = IMMUNIZATIONS_CONFIG['human_papillomavirus']['cpt']
    Patient.find_by_sql "select *
      from patients p
      where p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{human_papillomavirus_cpt})
        group by 1
        having count(i.id) = 1)
      and not exists (select 1 from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{human_papillomavirus_cpt})
        and i.display_date > current_date - interval '1 month')"
  end

  def self.find_patients_needing_third_human_papillomavirus_shot
    human_papillomavirus_cpt = IMMUNIZATIONS_CONFIG['human_papillomavirus']['cpt']
    Patient.find_by_sql "select *
      from patients p
      where p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{human_papillomavirus_cpt})
        group by 1
        having count(i.id) = 2)
      and not exists (select 1 from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{human_papillomavirus_cpt})
        and i.display_date > current_date - interval '4 months')"
  end

  def self.find_patients_needing_first_meningococcal_shot
    meningococcal_cpt = IMMUNIZATIONS_CONFIG['meningococcal']['cpt']
    meningococcal_start_age = IMMUNIZATIONS_CONFIG['meningococcal']['patient_age_in_months'][0]
    Patient.find_by_sql "select * from patients p
      where date_of_birth < current_date - interval '#{meningococcal_start_age} months'
      and not exists (select 1 from immunizations i
        where i.patient_id = p.patient_id
          and i.code in (#{meningococcal_cpt}))"
  end

  def self.find_patients_needing_second_meningococcal_shot
    meningococcal_cpt = IMMUNIZATIONS_CONFIG['meningococcal']['cpt']
    meningococcal_start_age = IMMUNIZATIONS_CONFIG['meningococcal']['patient_age_in_months'][1]
    Patient.find_by_sql "select *
      from patients p
      where p.date_of_birth < current_date - interval '#{meningococcal_start_age} months'
      and p.id in (
        select
        p.id
        from patients p
        inner join immunizations i on i.patient_id = i.patient_id
          and i.code in (#{meningococcal_cpt})
        group by 1
        having count(i.id) = 1)
      and not exists (select 1 from immunizations i
        where i.patient_id = p.patient_id
        and i.code in (#{meningococcal_cpt})
        and i.display_date > current_date - interval '5 years')"
  end

  def self.find_patients_needing_zoster_shots
    zoster_start_age = IMMUNIZATIONS_CONFIG['zoster']['patient_age_in_months'][0]
    zoster_cpt = IMMUNIZATIONS_CONFIG['zoster']['cpt']
    Patient.find_by_sql "select * from patients p
      where date_of_birth < current_date - interval '#{zoster_start_age} months'
      and not exists (select 1 from immunizations i
        where i.patient_id = p.patient_id
          and i.code = '#{zoster_cpt}')"
  end
end
