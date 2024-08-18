class Student < ApplicationRecord
  def generate_auth_token
    Digest::SHA256.hexdigest("#{self.id}#{Rails.application.credentials.secret_key_base}")
  end
end
