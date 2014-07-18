ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587,
    :user_name => "laura@additiveanalytics.com",
    :password  => 'OuvLfBflxCH7OtBRfygNuQ',
    :domain    => 'additiveanalytics.com'
  }
ActionMailer::Base.delivery_method = :smtp

MandrillMailer.configure do |config|
  config.api_key = 'OuvLfBflxCH7OtBRfygNuQ'
end
