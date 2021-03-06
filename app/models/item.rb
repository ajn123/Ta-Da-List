# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :list

  validates :title, :content, presence: true, uniqueness: { scope: :list }

  before_validation do
    self.due_date = Date.today unless due_date
  end

  def as_json(*)
    super.tap do |hash|
      hash['due_date'] = format
    end
  end


  def format
    self.due_date.strftime('%F %T %P')
  end
end
