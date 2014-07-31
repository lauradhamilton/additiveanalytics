require 'rails'
require 'filterrific'

class ImmunizationTask < ActiveRecord::Base
  belongs_to :patient, foreign_key: 'patient_id'

  validates_uniqueness_of :immunization, scope: [:patient_id]

  filterrific(
    default_settings: { sorted_by: 'created_at_desc' },
    filter_names: [
      :sorted_by,
      :search_query,
      :with_series_followup,
      :with_last_immunization_on,
      :with_immunization
    ]
  )

  scope :search_query, lambda { |query|
  }

  scope :sorted_by, lambda { |sort_key|
  }

  # Filter for series 2+ only
  scope :with_series_followup, lambda { |flag|
    return nil if 0 == flag
    where('series_number >=?', 2)
  }

  scope :with_last_immunization_on, lambda { |reference_time|
    where(
      'Exists (SELECT 1 from immunizations i where i.patient_id = immunization_tasks.patient_id and i.display_date > ? )', reference_time)
  }

  # Immunization type selection
  scope :with_immunization, lambda { |immunizations|
    where(immunization: [*immunizations])
  }

  # Filters on 'series' attribute
  scope :with_series_number, lambda { |series_numbers|
    where(series_number: [*series_numbers])
  }

  def self.options_for_sorted_by
    [
      ['Task Created On', 'created_at_desc'],
      ['Immunization', 'immunization'],
      ['Series Number', 'series_number']
    ]
  end

  def self.options_for_select
    order('immunization').map{|i| i.immunization}.uniq
  end

  def self.create_all_immunization_tasks
    create_hepatitis_a_tasks
    create_hepatitis_b_tasks
    create_rotavirus_tasks
    create_influenza_tasks
    create_mmr_tasks
    create_varicella_tasks
    create_human_papillomavirus_tasks
    create_dpt_tasks
    create_haemophilus_influenza_tasks
    create_pneumococcal_conjugate_tasks
    create_pneumococcal_polysaccharide_tasks
    create_poliovirus_tasks
    create_zoster_tasks
    create_meningococcal_tasks
  end

  def self.create_hepatitis_a_tasks
    hepatitis_a_series_1_patients = Patient.find_patients_needing_first_hepatitis_a_shot
    hepatitis_a_series_1_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'hepatitis_a'
      new_immunization_task.series_number = 1
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'hepatitis_a', 1)
        new_immunization_task.save
      end
    end

    hepatitis_a_series_2_patients = Patient.find_patients_needing_second_hepatitis_a_shot
    hepatitis_a_series_2_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'hepatitis_a'
      new_immunization_task.series_number = 2
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'hepatitis_a', 2)
        new_immunization_task.save
      end
    end
  end

  def self.create_hepatitis_b_tasks
    hepatitis_b_series_1_patients = Patient.find_patients_needing_first_hepatitis_b_shot
    hepatitis_b_series_1_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'hepatitis_b'
      new_immunization_task.series_number = 1
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'hepatitis_b', 1)
        new_immunization_task.save
      end
    end

    hepatitis_b_series_2_patients = Patient.find_patients_needing_second_hepatitis_b_shot
    hepatitis_b_series_2_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'hepatitis_b'
      new_immunization_task.series_number = 2
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'hepatitis_b', 2)
        new_immunization_task.save
      end
    end

    hepatitis_b_series_3_patients = Patient.find_patients_needing_third_hepatitis_b_shot
    hepatitis_b_series_3_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'hepatitis_b'
      new_immunization_task.series_number = 3
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'hepatitis_b', 3)
        new_immunization_task.save
      end
    end
  end

  def self.create_rotavirus_tasks
    rotavirus_series_1_patients = Patient.find_patients_needing_first_rotavirus_shot
    rotavirus_series_1_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'rotavirus'
      new_immunization_task.series_number = 1
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'rotavirus', 1)
        new_immunization_task.save
      end
    end

    rotarix_series_2_patients = Patient.find_patients_needing_second_rotarix_shot
    rotarix_series_2_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'rotavirus'
      new_immunization_task.series_number = 2
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'rotavirus', 2)
        new_immunization_task.save
      end
    end

    rotateq_series_2_patients = Patient.find_patients_needing_second_rotateq_shot
    rotateq_series_2_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'rotavirus'
      new_immunization_task.series_number = 2
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'rotavirus', 2)
        new_immunization_task.save
      end
    end

    rotateq_series_3_patients = Patient.find_patients_needing_third_rotateq_shot
    rotateq_series_3_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'rotavirus'
      new_immunization_task.series_number = 3
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'rotavirus', 3)
        new_immunization_task.save
      end
    end
  end

  def self.create_dpt_tasks
    dpt_series_1_patients = Patient.find_patients_needing_first_dpt_shot
    dpt_series_1_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'diptheria_tetanus_pertussis'
      new_immunization_task.series_number = 1
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'dpt', 1)
        new_immunization_task.save
      end
    end

    dpt_series_2_patients = Patient.find_patients_needing_second_dpt_shot
    dpt_series_2_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'diptheria_tetanus_pertussis'
      new_immunization_task.series_number = 2
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'diptheria_tetanus_pertussis', 2)
        new_immunization_task.save
      end
    end

    dpt_series_3_patients = Patient.find_patients_needing_third_dpt_shot
    dpt_series_3_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'diptheria_tetanus_pertussis'
      new_immunization_task.series_number = 3
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'diptheria_tetanus_pertussis', 3)
        new_immunization_task.save
      end
    end

    dpt_series_4_patients = Patient.find_patients_needing_fourth_dpt_shot
    dpt_series_4_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'diptheria_tetanus_pertussis'
      new_immunization_task.series_number = 4
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'diptheria_tetanus_pertussis', 4)
        new_immunization_task.save
      end
    end

    dpt_series_5_patients = Patient.find_patients_needing_fifth_dpt_shot
    dpt_series_5_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'diptheria_tetanus_pertussis'
      new_immunization_task.series_number = 5
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'diptheria_tetanus_pertussis', 5)
        new_immunization_task.save
      end
    end
  end

  def self.create_haemophilus_influenza_tasks
    haemophilus_influenza_series_1_patients = Patient.find_patients_needing_first_haemophilus_influenza_shot
    haemophilus_influenza_series_1_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'haemophilus_influenza'
      new_immunization_task.series_number = 1
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'haemophilus_influenza', 1)
        new_immunization_task.save
      end
    end

    haemophilus_influenza_series_2_patients = Patient.find_patients_needing_second_haemophilus_influenza_shot
    haemophilus_influenza_series_2_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'haemophilus_influenza'
      new_immunization_task.series_number = 2
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'haemophilus_influenza', 2)
        new_immunization_task.save
      end
    end

    haemophilus_influenza_series_3_patients = Patient.find_patients_needing_third_haemophilus_influenza_shot
    haemophilus_influenza_series_3_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'haemophilus_influenza'
      new_immunization_task.series_number = 3
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'haemophilus_influenza', 3)
        new_immunization_task.save
      end
    end

    haemophilus_influenza_series_4_patients = Patient.find_patients_needing_fourth_haemophilus_influenza_shot
    haemophilus_influenza_series_4_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'haemophilus_influenza'
      new_immunization_task.series_number = 4
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'haemophilus_influenza', 4)
        new_immunization_task.save
      end
    end
  end

  def self.create_pneumococcal_conjugate_tasks
    pneumococcal_conjugate_series_1_patients = Patient.find_patients_needing_first_pneumococcal_conjugate_shot
    pneumococcal_conjugate_series_1_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'pneumococcal_conjugate'
      new_immunization_task.series_number = 1
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'pneumococcal_conjugate', 1)
        new_immunization_task.save
      end
    end

    pneumococcal_conjugate_series_2_patients = Patient.find_patients_needing_second_pneumococcal_conjugate_shot
    pneumococcal_conjugate_series_2_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'pneumococcal_conjugate'
      new_immunization_task.series_number = 2
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'pneumococcal_conjugate', 2)
        new_immunization_task.save
      end
    end

    pneumococcal_conjugate_series_3_patients = Patient.find_patients_needing_third_pneumococcal_conjugate_shot
    pneumococcal_conjugate_series_3_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'pneumococcal_conjugate'
      new_immunization_task.series_number = 3
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'pneumococcal_conjugate', 3)
        new_immunization_task.save
      end
    end

    pneumococcal_conjugate_series_4_patients = Patient.find_patients_needing_fourth_pneumococcal_conjugate_shot
    pneumococcal_conjugate_series_4_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'pneumococcal_conjugate'
      new_immunization_task.series_number = 4
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'pneumococcal_conjugate', 4)
        new_immunization_task.save
      end
    end
  end

  def self.create_pneumococcal_polysaccharide_tasks
    pneumococcal_polysaccharide_patients = Patient.find_patients_needing_pneumococcal_polysaccharide_shots
    pneumococcal_polysaccharide_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'pneumococcal_polysaccharide'
      unless ImmunizationTask.find_by_patient_id_and_immunization(new_immunization_task.patient_id, 'pneumococcal_polysaccharide')
        new_immunization_task.save
      end
    end
  end

  def self.create_poliovirus_tasks
    poliovirus_series_1_patients = Patient.find_patients_needing_first_poliovirus_shot
    poliovirus_series_1_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'poliovirus'
      new_immunization_task.series_number = 1
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'poliovirus', 1)
        new_immunization_task.save
      end
    end

    poliovirus_series_2_patients = Patient.find_patients_needing_second_poliovirus_shot
    poliovirus_series_2_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'poliovirus'
      new_immunization_task.series_number = 2
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'poliovirus', 2)
        new_immunization_task.save
      end
    end

    poliovirus_series_3_patients = Patient.find_patients_needing_third_poliovirus_shot
    poliovirus_series_3_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'poliovirus'
      new_immunization_task.series_number = 3
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'poliovirus', 3)
        new_immunization_task.save
      end
    end

    poliovirus_series_4_patients = Patient.find_patients_needing_fourth_poliovirus_shot
    poliovirus_series_4_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'poliovirus'
      new_immunization_task.series_number = 4
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'poliovirus', 4)
        new_immunization_task.save
      end
    end
  end

  def self.create_mmr_tasks
    mmr_series_1_patients = Patient.find_patients_needing_first_mmr_shot
    mmr_series_1_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'measles_mumps_rubella'
      new_immunization_task.series_number = 1
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'measles_mumps_rubella', 1)
        new_immunization_task.save
      end
    end

    mmr_series_2_patients = Patient.find_patients_needing_second_mmr_shot
    mmr_series_2_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'measles_mumps_rubella'
      new_immunization_task.series_number = 2
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'measles_mumps_rubella', 2)
        new_immunization_task.save
      end
    end
  end

  def self.create_varicella_tasks
    varicella_series_1_patients = Patient.find_patients_needing_first_varicella_shot
    varicella_series_1_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'varicella'
      new_immunization_task.series_number = 1
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'varicella', 1)
        new_immunization_task.save
      end
    end

    varicella_series_2_patients = Patient.find_patients_needing_second_mmr_shot
    varicella_series_2_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'varicella'
      new_immunization_task.series_number = 2
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'varicella', 2)
        new_immunization_task.save
      end
    end
  end

  def self.create_human_papillomavirus_tasks
    human_papillomavirus_series_1_patients = Patient.find_patients_needing_first_human_papillomavirus_shot
    human_papillomavirus_series_1_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'human_papillomavirus'
      new_immunization_task.series_number = 1
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'human_papillomavirus', 1)
        new_immunization_task.save
      end
    end

    human_papillomavirus_series_2_patients = Patient.find_patients_needing_second_human_papillomavirus_shot
    human_papillomavirus_series_2_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'human_papillomavirus'
      new_immunization_task.series_number = 2
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'human_papillomavirus', 2)
        new_immunization_task.save
      end
    end

    human_papillomavirus_series_3_patients = Patient.find_patients_needing_third_human_papillomavirus_shot
    human_papillomavirus_series_3_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'human_papillomavirus'
      new_immunization_task.series_number = 3
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'human_papillomavirus', 3)
        new_immunization_task.save
      end
    end
  end

  def self.create_influenza_tasks
    influenza_patients = Patient.find_patients_needing_influenza_shots
    influenza_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'influenza'
      unless ImmunizationTask.find_by_patient_id_and_immunization(new_immunization_task.patient_id, 'influenza')
        new_immunization_task.save
      end
    end
  end

  def self.create_zoster_tasks
    zoster_patients = Patient.find_patients_needing_zoster_shots
    zoster_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'zoster'
      unless ImmunizationTask.find_by_patient_id_and_immunization(new_immunization_task.patient_id, 'zoster')
        new_immunization_task.save
      end
    end
  end

  def self.create_meningococcal_tasks
    meningococcal_series_1_patients = Patient.find_patients_needing_first_meningococcal_shot
    meningococcal_series_1_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'meningococcal'
      new_immunization_task.series_number = 1
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'meningococcal', 1)
        new_immunization_task.save
      end
    end

    meningococcal_series_2_patients = Patient.find_patients_needing_second_meningococcal_shot
    meningococcal_series_2_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'meningococcal'
      new_immunization_task.series_number = 2
      unless ImmunizationTask.find_by_patient_id_and_immunization_and_series_number(new_immunization_task.patient_id, 'meningococcal', 2)
        new_immunization_task.save
      end
    end
  end
end
