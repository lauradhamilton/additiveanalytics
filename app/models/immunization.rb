require 'rails'

class Immunization < ActiveRecord::Base

  belongs_to :patient

  # Don't save empty strings. Store them as null values in the db.
  nilify_blanks

  def self.import_immunizations
    Patient.all.each do |p|
      print p.patient_id
    end

    import_immunizations(2)
  end

  def self.import_immunization(patient_id)
    immunization = AllscriptsIntegration.get_immunizations('Terry', patient_id)
    new_immunization_hash = JSON[immunization][0]["getclinicalsummaryinfo"][0]
    new_immunization = Immunization.new

    new_immunization.patient_id = patient_id
    new_immunization.entry_code = new_immunization_hash["entrycode"]
    new_immunization.section = new_immunization_hash["section"]
    new_immunization.status = new_immunization_hash["status"]
    new_immunization.detail = new_immunization_hash["detail"]
    new_immunization.code = new_immunization_hash["code"]
    new_immunization.trans_id = new_immunization_hash["transid"]
    new_immunization.display_date = new_immunization_hash["displaydate"]
    new_immunization.description = new_immunization_hash["description"]

    new_immunization.save

  end

end
