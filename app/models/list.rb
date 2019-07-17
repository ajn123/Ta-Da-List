# frozen_string_literal: true

class List < ApplicationRecord
  has_many :items, dependent: :destroy

  #  validates :title, uniqueness: true, presence: true
end
