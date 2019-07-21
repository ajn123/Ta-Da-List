# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :lists



  def self.api_authorized(api_key)
      User.all.pluck(:api_key).include?(password)
  end
end
