class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :zxcvbnable #Enforce minimum password strength

  # This is providers who are allowed to access the patient data

  has_many :immunization_task_statuses
end
