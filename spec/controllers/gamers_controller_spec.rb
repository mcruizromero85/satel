require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe GamersController do

  # This should return the minimal set of attributes required to create a valid
  # Gamer. As you add validations to Gamer, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "nick" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GamersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all gamers as @gamers" do
      gamer = Gamer.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:gamers)).to eq([gamer])
    end
  end

  describe "GET show" do
    it "assigns the requested gamer as @gamer" do
      gamer = Gamer.create! valid_attributes
      get :show, {:id => gamer.to_param}, valid_session
      expect(assigns(:gamer)).to eq(gamer)
    end
  end

  describe "GET new" do
    it "assigns a new gamer as @gamer" do
      get :new, {}, valid_session
      expect(assigns(:gamer)).to be_a_new(Gamer)
    end
  end

  describe "GET edit" do
    it "assigns the requested gamer as @gamer" do
      gamer = Gamer.create! valid_attributes
      get :edit, {:id => gamer.to_param}, valid_session
      expect(assigns(:gamer)).to eq(gamer)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Gamer" do
        expect {
          post :create, {:gamer => valid_attributes}, valid_session
        }.to change(Gamer, :count).by(1)
      end

      it "assigns a newly created gamer as @gamer" do
        post :create, {:gamer => valid_attributes}, valid_session
        expect(assigns(:gamer)).to be_a(Gamer)
        expect(assigns(:gamer)).to be_persisted
      end

      it "redirects to the created gamer" do
        post :create, {:gamer => valid_attributes}, valid_session
        expect(response).to redirect_to(Gamer.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved gamer as @gamer" do
        # Trigger the behavior that occurs when invalid params are submitted
        Gamer.any_instance.stub(:save).and_return(false)
        post :create, {:gamer => { "nick" => "invalid value" }}, valid_session
        expect(assigns(:gamer)).to be_a_new(Gamer)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Gamer.any_instance.stub(:save).and_return(false)
        post :create, {:gamer => { "nick" => "invalid value" }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested gamer" do
        gamer = Gamer.create! valid_attributes
        # Assuming there are no other gamers in the database, this
        # specifies that the Gamer created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Gamer).to receive(:update).with({ "nick" => "MyString" })
        put :update, {:id => gamer.to_param, :gamer => { "nick" => "MyString" }}, valid_session
      end

      it "assigns the requested gamer as @gamer" do
        gamer = Gamer.create! valid_attributes
        put :update, {:id => gamer.to_param, :gamer => valid_attributes}, valid_session
        expect(assigns(:gamer)).to eq(gamer)
      end

      it "redirects to the gamer" do
        gamer = Gamer.create! valid_attributes
        put :update, {:id => gamer.to_param, :gamer => valid_attributes}, valid_session
        expect(response).to redirect_to(gamer)
      end
    end

    describe "with invalid params" do
      it "assigns the gamer as @gamer" do
        gamer = Gamer.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Gamer.any_instance.stub(:save).and_return(false)
        put :update, {:id => gamer.to_param, :gamer => { "nick" => "invalid value" }}, valid_session
        expect(assigns(:gamer)).to eq(gamer)
      end

      it "re-renders the 'edit' template" do
        gamer = Gamer.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Gamer.any_instance.stub(:save).and_return(false)
        put :update, {:id => gamer.to_param, :gamer => { "nick" => "invalid value" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested gamer" do
      gamer = Gamer.create! valid_attributes
      expect {
        delete :destroy, {:id => gamer.to_param}, valid_session
      }.to change(Gamer, :count).by(-1)
    end

    it "redirects to the gamers list" do
      gamer = Gamer.create! valid_attributes
      delete :destroy, {:id => gamer.to_param}, valid_session
      expect(response).to redirect_to(gamers_url)
    end
  end

end
