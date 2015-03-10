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
      template = FirstmilerSmsOauth.sms_template
      unless is_valid_sms_template?(template)
        FirstmilerSmsOauth::FmSmsException.raise_exception(500)
      end
      template
    end

    def is_valid_sms_template?(template)
      template.present? && check_valid_formate?(template)
    end

    def check_valid_formate?(template)
      template.include? '%{key}'
    end
  end
end