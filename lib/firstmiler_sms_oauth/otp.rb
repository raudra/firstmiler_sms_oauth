module FirstmilerSmsOauth
  module Otp
    module_function
    def generate_key
      rand_key  = [*1000...9999].sample
      "#{FirstmilerSmsOauth.code}#{rand_key}"
    end

    def build_otp_content(key)
      sms_template % {key: key}
    end

    def sms_template
      FirstmilerSmsOauth.sms_template
    end
  end
end