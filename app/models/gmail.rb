class Gmail < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  belongs_to :user, foreign_key: 'uin', primary_key: 'uin'

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)
  end

  def self.new_with_session(params, session)
    new(params)
  end
end
