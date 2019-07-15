require 'rails_helper'

RSpec.describe Api::ListsController, type: :controller do
  describe "GET index" do
    it "is successful" do
      get :index
      expect(response).to have_http_status(:ok)
    end

  end


  describe "POST index" do
    it "is successful" do
      post :index, params: { list: {title: "Christmas list" } }
      expect(response).to have_http_status(:ok)
    end
  end
end
