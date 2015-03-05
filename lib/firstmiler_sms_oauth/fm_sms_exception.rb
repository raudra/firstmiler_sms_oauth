require 'active_support/core_ext/hash'

module FirstmilerSmsOauth
  module FmSmsException
    module_function
    def check_response(response)
      exotel_hash=Hash.from_xml(response.gsub("\n", ""))
      if exotel_hash["TwilioResponse"].has_key?("SMSMessage")
        return true
      elsif exotel_hash["TwilioResponse"].has_key?("RestException")
        return false, exotel_hash["TwilioResponse"]["RestException"]["Message"]
      else
        return false , "Some unknown exception occured"
      end
    end
  end
end