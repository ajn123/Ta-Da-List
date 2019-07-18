# frozen_string_literal: true

class List < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :title, uniqueness: true, presence: true

  accepts_nested_attributes_for :items
end
