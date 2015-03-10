require 'active_support/core_ext/hash'

module FirstmilerSmsOauth
  module FmSmsException
    module_function
    def check_response(response)
      exotel_hash = Hash.from_xml(response.gsub("\n", ""))
      if exotel_hash["TwilioResponse"].has_key?("SMSMessage")
        return true
      elsif exotel_hash["TwilioResponse"].has_key?("RestException")
        hash = exotel_hash["TwilioResponse"]["RestException"]
        raise_exception(hash["status"], hash["Message"])
      end
      false
    end


    def raise_exception(code, message = nil)
      case code.to_i
      when 400
        raise ParamsError, message
      when 401
        raise AuthenticationError, message
      when 403
        raise ExotelAccountError, message
      when 500
        raise InvalidSmsTemplateError, "Sms Template is invalid, format for sms template should be 'sms content %{key}'"
      else
        raise UnexpectedError, "#{code} #{message}"
      end
    end
  end

  class AuthenticationError < StandardError;  end

  class UnexpectedError < StandardError;  end

  class ParamsError < StandardError;  end

  class ExotelAccountError < StandardError;  end

  class InvalidSmsTemplateError < StandardError;  end
end