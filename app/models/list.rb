# frozen_string_literal: true

class List < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :title, uniqueness: true, presence: true, length: { minimum: 5 }

  accepts_nested_attributes_for :items



  def as_json(*)
    puts "hello"
    super.tap do |hash|
      puts self.items
      hash["items"] ||= []
      self.items.each do |item|
        hash["items"] << item.as_json
      end
    end
    
  end
end
