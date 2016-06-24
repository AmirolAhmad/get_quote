require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  let(:client) { FactoryGirl.create(:client) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:client) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:client).merge({contactPerson: nil}) }
  let(:user) { FactoryGirl.create(:user) }
  let(:valid_session) { sign_in(user) }

  # GET INDEX PAGE
  describe "GET #index" do
    before { valid_session }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  # GET NEW PAGE
  describe "GET #new" do
    before { valid_session }

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  # GET SHOW PAGE
  describe "GET #show" do
    before { valid_session }

    describe "when current_user is owner" do
      it "returns http success" do
        allow(controller).to receive(:current_user).and_return(client.user)
        get :show, id: client.id
        expect(response).to have_http_status(:success)
      end
    end

    describe "when current_user is not an owner" do
      it "redirect back to client index" do
        get :show, id: client.id
        expect(response).to redirect_to(clients_url)
      end
    end

  end

  # GET EDIT PAGE
  describe "GET #edit" do
    before { valid_session }

    describe "when current_user is owner" do
      it "returns http success" do
        allow(controller).to receive(:current_user).and_return(client.user)
        get :edit, { id: client.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe "when current_user is not an owner" do
      it "redirect back to client index" do
        get :show, id: client.id
        expect(response).to redirect_to(clients_url)
      end
    end
  end

  # ACTION WHEN POSTING
  describe "POST #create" do
    describe "if current_user is user" do
      before { valid_session }

      context "with valid attributes" do
        it "saves the client" do
          expect do
            post :create, { client: valid_attributes }
          end.to change(Client, :count).by(1)
        end

        it "redirects to the client index" do
          post :create, { client: valid_attributes }
          expect(response).to redirect_to(clients_url)
        end
      end

      context "with invalid attributes" do
        it "does not save the client" do
          expect do
            post :create, { client: invalid_attributes }
          end.to change(Client, :count).by(0)
        end
        it "renders new on failed create" do
          post :create, { client: invalid_attributes }
          expect(response).to render_template('new')
        end
      end
    end
  end

  # ACTION WHEN UPDATING
  describe "PUT #update" do
    before { valid_session }

    context "with valid attributes" do
      it "saves valid client" do
        allow(controller).to receive(:current_user).and_return(client.user)
        expect do
          put :update, { id: client.id, client: { contactPerson: "John" } }
        end.to change{ client.reload.contactPerson }.to("John")
      end
      it "redirects on save" do
        allow(controller).to receive(:current_user).and_return(client.user)
        put :update, { id: client.id, client: { contactPerson: "John" } }
        expect(response).to redirect_to(clients_url)
      end
    end

    context "with invalid attributes" do
      it "does not save invalid client" do
        allow(controller).to receive(:current_user).and_return(client.user)
        expect do
          put :update, { id: client.id, client: invalid_attributes }
        end.to_not change(client, :contactPerson)
      end

      it "renders edit on failed updated" do
        allow(controller).to receive(:current_user).and_return(client.user)
        put :update, { id: client.id, client: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  # ACTION WHEN DELETING
  describe "DELETE #destroy" do
    before { valid_session }

    context "success" do
      it "when deletes the client" do
        allow(controller).to receive(:current_user).and_return(client.user)
        expect do
          delete :destroy, { id: client.id }
        end.to change(Client, :count).by(-1)
      end
      it "redirects to the client index" do
        allow(controller).to receive(:current_user).and_return(client.user)
        delete :destroy, { id: client.id }
        expect(response).to redirect_to(clients_url)
      end
    end
  end
end
