class Item < ApplicationRecord

  belongs_to :list

  validates :title, :content, presence: true

end
