class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def text
    @lastpass = Lastpass::Client.new
    body = params["Body"]
    password, account = body.split(" ")
    phone_number = params["From"]
    username = TwilioHelper.get_username(phone_number)
    begin
      status = @lastpass.login(email: username, password: password)
    rescue => error
      status = false
    end

    response = Twilio::TwiML::MessagingResponse.new
    response.message do |message|
      message.body("Invalid credentials")
    end

    if status
      accounts = @lastpass.accounts.find_all(account, with_passwords: true)

      msg = "No account found"
      if accounts.present?
        account = accounts.first
        msg = "#{account.username}, #{account.password}"
      end

      response.message do |message|
        message.body(msg)
      end
    end
    render :xml => response.to_xml
  end
end
