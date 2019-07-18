# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :list

  validates :title, :content, presence: true, uniqueness: { scope: :list}
end
