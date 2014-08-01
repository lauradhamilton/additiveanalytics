class ImmunizationTaskStatus < ActiveRecord::Base
  belongs_to :immunization_tasks

  enum status: [:postpone_one_day, :postpone_one_month, :postpone_one_year, :close]
end
