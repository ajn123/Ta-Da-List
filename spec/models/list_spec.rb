# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List, type: :model do
  let(:user) { User.create(email: 'aj@gmail.com', password: 'password') }
  describe 'Create the List' do

    context 'be valid' do
      it 'validates title properly' do
        list = List.new(title: 'title proper', user: user)
        expect(list).to be_valid
      end
    end

    context 'be invalid' do
      it 'is invalid title' do
        list = List.new(title: 'to h', user: user)
        expect(list).to_not be_valid
      end

      it 'is invalid user' do
        list = List.new(title: 'full title')
        expect(list).to_not be_valid
      end
    end
  end


  describe '#as_json' do
    it 'displays nested items' do
      list = List.create(title: 'title proper', user: user, items: [Item.create(title: 'title #1', content: 'hello')])
      expect(list.as_json.keys).to include 'items'
    end
  end
end
