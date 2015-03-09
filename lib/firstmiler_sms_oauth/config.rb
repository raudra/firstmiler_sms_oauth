module FirstmilerSmsOauth
  class << self
    attr_accessor :exotel_sid, :exotel_token, :sms_template, :code, :from_number

    def configure
      yield self
    end
  end
end