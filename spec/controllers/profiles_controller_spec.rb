require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { FactoryGirl.create(:profile, user_id: user.id ) }
  let (:valid_attributes) { FactoryGirl.attributes_for(:profile) }
  let (:invalid_attributes) { FactoryGirl.attributes_for(:profile).merge({firstName: nil}) }
  let(:valid_session) { sign_in(user) }

  # GET EDIT PAGE
  describe "GET #edit" do
    before { valid_session }

    it "returns http success" do
      get :edit, { id: profile.id }
      expect(response).to have_http_status(:success)
    end
  end

  # ACTION WHEN UPDATING
  describe "PUT #update" do
    before { valid_session }

    context "with valid attributes" do
      it "saves valid profile" do
        expect do
          put :update, id: user.id, user: { profile_attributes: { user_id: user.id, firstName: "Cena" } }
        end.to change{ profile.reload.firstName }.to("Cena")
      end
      it "returns http success on save" do
        put :update, id: user.id, user: { profile_attributes: { user_id: user.id, firstName: "Cena" } }
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid attributes" do
      it "does not save invalid profile" do
        expect do
          put :update, id: user.id, user: { profile_attributes: invalid_attributes }
        end.to_not change(profile, :firstName)
      end

      it "renders edit on failed updated" do
        put :update, id: user.id, user: { profile_attributes: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end
end
