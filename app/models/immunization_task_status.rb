require 'rails'

class ImmunizationTaskStatus < ActiveRecord::Base
  belongs_to :immunization_task

  #enum status: [:postpone_one_day, :postpone_one_month, :postpone_one_year, :close]

  validates :immunization_task_id, presence: true
  validates :user_id, presence: true
end
