class CreateSmsOauthToken < ActiveRecord::Migration
  def change
    create_table :sms_oauth_tokens do |t|
      t.string :sms_oauth_token
      t.references :tokner, polymorphic: true
      t.timestamps
    end
  end
end
