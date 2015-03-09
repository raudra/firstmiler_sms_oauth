require "firstmiler_sms_oauth/otp"
require "firstmiler_sms_oauth/fm_sms_response"
require "firstmiler_sms_oauth/fm_sms_exception"


module FirstmilerSmsOauth
  class FmSms
    def send(to_number, content = nil)
      from_number  = FirstmilerSmsOauth.from_number
      content = CGI.escape(content)
      url = build_url
      response = send_sms_command(url,from_number, to_number, content)
      handle_response(response)
    end

    def send_sms_command(url, from_number, to_number, content)
      %x{curl -X POST -G \
        "#{url}" \
        -d 'From'="#{from_number}" \
        -d 'To'="#{to_number}" \
        -d 'Body'="#{content}"
      }
    end


    def build_url
      "https://#{FirstmilerSmsOauth.exotel_sid}:#{FirstmilerSmsOauth.exotel_token}@twilix.exotel.in/v1/Accounts/#{FirstmilerSmsOauth.exotel_sid}/Sms/send"
    end

    def handle_response(response)
      flag, msg = FirstmilerSmsOauth::FmSmsException.check_response(response)
      if flag
        FirstmilerSmsOauth::FmSmsResponse.new(response)
      else
        raise msg
      end
    end

    def exotel_sid
      FirstmilerSmsOauth.exotel_sid
    end

    def raise_blank_sms_template_exception
      raise "Sms Template content should not be blank."
    end
    class << self
      def send(number, content)
        new.send(number, content)
      end
    end
  end
end