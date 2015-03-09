 class SmsOauthToken < ::ActiveRecord::Base
    attr_accessible :sms_oauth_token,
                    :tokner_type,
                    :tokner_id  if defined?(ActiveModel::MassAssignmentSecurity)
    belongs_to :tokner, polymorphic: true
end

