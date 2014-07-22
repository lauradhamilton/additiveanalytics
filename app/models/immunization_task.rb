class ImmunizationTask < ActiveRecord::Base

  belongs_to :patient, :foreign_key => "patient_id"

  validates_uniqueness_of :immunization, scope: [:patient_id]

end
