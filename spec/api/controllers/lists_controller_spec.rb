# frozen_string_literal: true

require 'rails_helper'
require 'base64'

RSpec.describe Api::ListsController, type: :controller do

  let!(:user) { User.create(email: 'aj@gmail.com', password: 'password') }
  let!(:auth) { Base64.encode64("#{user.id}:#{user.api_key}") }

  before(:each) do
    request.headers['Authorization'] = "Basic #{auth}"
  end

  describe 'GET index' do
    it 'is successful' do 
      headers = { password: user.api_key }
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST index' do
    it 'is successful' do
      post :index, params: { list: { title: 'Christmas list' } }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE list' do
    let!(:list) { FactoryBot.create(:list_one) }

    it 'is succussful' do
      expect do
        id = list.id
        delete :destroy, params: { id: id }
        expect(response).to have_http_status(:ok)
      end.to change { List.count }.by(-1)
    end

    it 'can patch' do
      patch :update, params: { id: list.id, list: { title: 'hello' } }
      expect(response).to have_http_status(:ok)
      expect(list.reload.title).to eq('hello')
    end
  end
end
