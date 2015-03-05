module FirstmilerSmsOauth
  module Otp
    module_function

    def generate_key
      rand(1000 .. 9999)
    end

    # def verify_key?(key, user_id)
    #   user = User.find_by_id(user_id)
    #   if user.present?

    #   end
    #   false
    # end
  end
end