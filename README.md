# FirstmilerSmsOauth

## Installation

Add this line to your application's Gemfile:

    gem 'firstmiler_sms_oauth', '0.1.1'

## Usage
    Initialize

        Before you can do anything, you must have a initializer file with exotel credential.
        FirstmilerSmsOauth.configure do |c|
          c.exotel_sid   = "exotel sid"
          c.exotel_token = "exotel token"
          c.from_number = "phone no given by exotel"
          c.code = "code"
          c.sms_template = "Mobile authentication Otp token is %{key}"
        end

    Create generator

        Run generator to create a migration for creating the sms_oauth_token table
        rails generate firstmiler_sms_oauth
        rake db:migrate

    Send OTP
        For sending otp your model should have attribute phone_no
        Include acts_as_sms_oauth :column_name like(:phone_no, :number, :phone, :mobile_no)
        for example: acts_as_sms_oauth :mphone
        obj.send_otp_token for sending the otp message

    Verify OTP
        obj.verify_otp?(token) for verification
