require 'yaml'
require 'rails'

EMAIL_CONFIGS = YAML.load_file("#{Rails.root}/config/email.yml")

ActionMailer::Base.smtp_settings = {
  address: 'smtp.mandrillapp.com',
  port: 587,
  user_name: 'laura@additiveanalytics.com',
  password: EMAIL_CONFIGS['api_key'],
  domain: 'additiveanalytics.com'
}
ActionMailer::Base.delivery_method = :smtp
