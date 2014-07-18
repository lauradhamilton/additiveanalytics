require 'mandrill'
require 'yaml'

EMAIL_CONFIGS = YAML.load_file("#{Rails.root}/config/email.yml") rescue{}

#Override the standard devise mailer to use pretty templates in Mandrill
class MyDeviseMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    mandrill = Mandrill::API.new("OuvLfBflxCH7OtBRfygNuQ")
    template_content = [{"content"=>"example content", "name"=>"example name"}]
    template_name = "provider-sign-up"
    message = {
      "from_name" => "Additive Analytics Support",
      "subject" => "Please confirm your email address",
      "to" => ["email" => record.email],
      "inline_css"=> true
      }
    result = mandrill.messages.send_template template_name, template_content, message

      #We need to call super because Devise doesn't think we have sent any mail 
      #FIXME
  end
end
