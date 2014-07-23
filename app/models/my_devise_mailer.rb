require 'mandrill'
require 'yaml'
require 'rails'

EMAIL_CONFIGS = YAML.load_file("#{Rails.root}/config/email.yml")

# Override the standard devise mailer to use pretty templates in Mandrill
class MyDeviseMailer < Devise::Mailer
  def confirmation_instructions(record, _token, _opts={})
    mandrill = Mandrill::API.new('OuvLfBflxCH7OtBRfygNuQ')
    template_content = [{ 'content' => 'example content', 'name' => 'example name' }]
    template_name = 'provider-sign-up'
    message = {
      'from_name' => 'Additive Analytics Support',
      'subject' => 'Please confirm your email address',
      'to' => ['email' => record.email],
      'inline_css' => true,
      'merge_vars' => [
        {
          'rcpt' => record.email,
          'vars' => [
            {
              'name' => 'CONFIRMATION_URL',
              'content' => "<a href='#{user_confirmation_url(confirmation_token: record.confirmation_token)}'>Confirm my email</a>"
            }
          ]
        }
      ]
    }
    mandrill.messages.send_template template_name, template_content, message

    # We need to call super because Devise doesn't think we have sent any mail
    # FIXME
  end
end
