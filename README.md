# FirstmilerSmsOauth

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'firstmiler_sms_oauth', '0.0.8'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install firstmiler_sms_oauth

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
        Include acts_as_sms_oauth   in your model
        obj.send_otp_token for sending the otp message

    Verify OTP
        obj.verify_otp?(token) for verification



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
