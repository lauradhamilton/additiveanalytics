require 'rails'

class Patient < ActiveRecord::Base
  # Don't save empty strings. Store them as null values in the db.
  nilify_blanks

  def self.find_patients_to_import
    changed_patients_hash = JSON[AllscriptsIntegration.get_changed_patients][0]["getchangedpatientsinfo"]
    changed_patients_array = []
    changed_patients_hash.each do |patient|
      changed_patients_array.push patient["patientid"].to_i
    end
    return changed_patients_array
  end

  def self.import_all_patients
    all_patients = Patient.find_patients_to_import
    all_patients.each do |patient_id|
      import_patient(patient_id)
    end
  end

  def self.import_patient(patient_id)
    patient = AllscriptsIntegration.get_patient(patient_id)
    new_patient_hash = JSON[patient][0]["getpatientinfo"][0]
    new_patient = Patient.new

    new_patient.patient_id = patient_id
    new_patient.age = new_patient_hash["age"]
    new_patient.gender = new_patient_hash["gender"]
    new_patient.marital_status = new_patient_hash["MaritalStatus"]
    new_patient.first_name = new_patient_hash["FirstName"]
    new_patient.middle_name = new_patient_hash["MiddleName"]
    new_patient.last_name = new_patient_hash["LastName"]
    new_patient.suffix = new_patient_hash["Suffix"]
    new_patient.occupation = new_patient_hash["Occupation"]
    new_patient.employer = new_patient_hash["Employer"]
    new_patient.phone_number = new_patient_hash["PhoneNumber"]
    new_patient.work_phone = new_patient_hash["WorkPhone"]
    new_patient.cell_phone = new_patient_hash["CellPhone"]
    new_patient.address_line_1 =new_patient_hash["AddressLine1"]
    new_patient.address_line_2 = new_patient_hash["AddressLine2"]
    new_patient.city = new_patient_hash["City"]
    new_patient.state = new_patient_hash["State"]
    new_patient.zip = new_patient_hash["Zip"]
    new_patient.email = new_patient_hash["Email"]
    new_patient.date_of_birth = new_patient_hash["dateofbirth"]
    new_patient.physician_phone = new_patient_hash["PhysPhone"]
    new_patient.physician_first_name = new_patient_hash["PhysFirstName"]
    new_patient.physician_last_name = new_patient_hash["PhysLastName"]
    new_patient.physician_username = new_patient_hash["PhysUserName"]
    new_patient.base64image = new_patient_hash["base64image"]
    new_patient.primary_insurance = new_patient_hash["PrimaryInsurance"]
    new_patient.language = new_patient_hash["Language"]
    new_patient.race = new_patient_hash["Race"]
    new_patient.ethnicity = new_patient_hash["Ethnicity"]
    new_patient.ssn = new_patient_hash["ssn"]
    new_patient.mrn = new_patient_hash["mrn"]
    new_patient.picture_of_patient = new_patient_hash["patientpix"]
    new_patient.age_dec = new_patient_hash["AgeDec"]
    new_patient.patient_location = new_patient_hash["PatientLocation"]

    # Only import patients we have not seen before
    unless Patient.find_by_patient_id(patient_id)
      new_patient.save
    end
  end

end
