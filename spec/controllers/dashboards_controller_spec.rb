require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:valid_session) { sign_in(user) }

  describe "GET #index" do
    before { valid_session }
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
