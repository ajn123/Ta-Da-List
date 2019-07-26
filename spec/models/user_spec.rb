# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Create User' do
    let(:user) { User.create(email: 'aj@gmail.com', password: 'password') }

    context 'is valid' do
      it 'is valid' do
        expect(user).to be_valid
        expect(user.api_key).to_not be_nil
      end
    end

    context 'is not valid' do
      it 'has invalid email' do
        user.email = 'aj'
        expect(user).to_not be_valid
      end
    end
  end
end
