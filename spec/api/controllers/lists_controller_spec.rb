# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::ListsController, type: :controller do
  describe 'GET index' do
    it 'is successful' do
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
