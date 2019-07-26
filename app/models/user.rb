# frozen_string_literal: true

class User < ApplicationRecord
  APICONSTANT = 5000

  has_secure_password

  has_many :lists, dependent: :destroy

  validates :email, presence: true, format: { with: /\A.*@.*\Z/ }

  before_create do
    self.api_key = SecureRandom.urlsafe_base64
    while User.api_authorized(api_key)
      self.api_key = SecureRandom.urlsafe_base64
    end
  end

  def self.api_authorized(api_key)
    User.all.pluck(:api_key).include?(api_key)
  end
end
