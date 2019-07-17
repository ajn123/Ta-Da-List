# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  before :each do
    @list = FactoryBot.create(:list_one)
  end

  describe 'validations' do
    it 'needs a title' do
      item_error = Item.new(list: @list)
      expect(item_error).to_not be_valid
      item_error.title = 'Item 1'
      item_error.content = 'content'
      expect(item_error).to be_valid
    end
  end
end
