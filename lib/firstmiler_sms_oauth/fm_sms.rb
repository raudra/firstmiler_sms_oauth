require "firstmiler_sms_oauth/otp"
require "firstmiler_sms_oauth/fm_sms_response"
require "firstmiler_sms_oauth/fm_sms_exception"

module FirstmilerSmsOauth
  class FmSms

    def send(to_number, auth_hash, content = nil)
      content = content ? content : opt_secret_key
      url = build_url(auth_hash)
      response = send_sms_command(url, auth_hash[:from_number], to_number, content)
      handle_response(response)
    end

    def send_sms_command(url, from_number, to_number, content)
      %x{curl -X POST -G \
        "#{url}" \
        -d 'From'="#{from_number}" \
        -d 'To'="#{to_number}" \
        -d 'Body'=#{content}
      }
    end

    def build_url(auth_hash)
      "https://#{auth_hash[:exotel_sid]}:#{auth_hash[:exotel_token]}@twilix.exotel.in/v1/Accounts/#{auth_hash[:exotel_sid]}/Sms/send"
    end

    def handle_response(response)
      flag, msg = FirstmilerSmsOauth::FmSmsException.check_response(response)
      if flag
        FirstmilerSmsOauth::FmSmsResponse.new(response)
      else
        raise msg
      end
    end

    def opt_secret_key
      FirstmilerSmsOauth::Otp.generate_key
    end

    class << self
      def send_otp(to_number, auth_hash)
        new.send(to_number, auth_hash)
      end

      def send_sms(to_number, auth_hash, content =  nil)
        if content
          new.send(to_number, auth_hash, content)
        else
          raise "Content should not be blank."
        end
      end
    end
  end
end