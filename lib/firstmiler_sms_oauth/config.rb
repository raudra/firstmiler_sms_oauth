module FirstmilerSmsOauth
  class << self
    attr_accessor :exotel_sid, :exotel_token, :sms_template, :code

    def configure
      yield self
    end
  end
end