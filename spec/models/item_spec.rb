require 'rails_helper'

RSpec.describe Item, type: :model do
  
  describe "validations" do
    it "needs a title" do
      item_error = Item.new()
      expect(item_error).to_not be_valid
      item_error.title = "Item 1"
      item_error.content = "content"
      expect(item_error).to be_valid
    end
  end
end
