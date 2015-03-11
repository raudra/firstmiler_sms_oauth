module FirstmilerSmsOauth
  module SmsOauth
    def self.included(receiver)
      receiver.extend        ClassMethods
      receiver.send :include, InstanceMethods
    end

    module ClassMethods

      def acts_as_sms_oauth(method_name)
        set_method_name(method_name)
        send :include, InstanceMethods
      end

      def set_method_name(m_name)
        FirstmilerSmsOauth.send_attr_name = m_name
      end
    end

    module InstanceMethods
      def send_otp_token
        content = sms_content
        FirstmilerSmsOauth::FmSms.send(self.send(FirstmilerSmsOauth.send_attr_name), content)
      end

      def delete_user_sms_oauth_tokens
        SmsOauthToken.where("tokner_id  = ? and tokner_type = ?", self.id, self.class.name).delete_all
      end

      def all_tokens
        tokens = SmsOauthToken.where("tokner_id  = ? and tokner_type = ?", self.id, self.class.name).collect(&:sms_oauth_token)
        tokens
      end

      def sms_content
        key = token_key
        FirstmilerSmsOauth::Otp.build_otp_content(key)
      end

      def token_key
        key = FirstmilerSmsOauth::Otp.generate_key
        build_sms_oauth_token(key)
        key
      end

      def verify_otp?(token)
        flag = all_tokens.include?(token.to_s)
        delete_user_sms_oauth_tokens
        flag
      end

      def build_sms_oauth_token(key)
        s = SmsOauthToken.create(sms_oauth_token: key)
        s.tokner = self
        s.save
      end
    end
  end
  module ActsAsSmsOauth
    if defined?(Rails::Railtie)
      class Railtie < Rails::Railtie
        initializer 'acts_as_sms_oauth.insert_into_active_record' do
          ActiveSupport.on_load :active_record do
            ActiveRecord::Base.send(:include, SmsOauth)
          end
        end
      end
    else
      ActiveRecord::Base.send(:include, SmsOauth) #if defined?(ActiveRecord)
    end
  end
end