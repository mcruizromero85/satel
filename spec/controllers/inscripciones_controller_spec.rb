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

describe InscripcionesController do

  # This should return the minimal set of attributes required to create a valid
  # Inscripcion. As you add validations to Inscripcion, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "torneo_id" => "1" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # InscripcionesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all inscripciones as @inscripciones" do
      inscripcion = Inscripcion.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:inscripciones)).to eq([inscripcion])
    end
  end

  describe "GET show" do
    it "assigns the requested inscripcion as @inscripcion" do
      inscripcion = Inscripcion.create! valid_attributes
      get :show, {:id => inscripcion.to_param}, valid_session
      expect(assigns(:inscripcion)).to eq(inscripcion)
    end
  end

  describe "GET new" do
    it "assigns a new inscripcion as @inscripcion" do
      get :new, {}, valid_session
      expect(assigns(:inscripcion)).to be_a_new(Inscripcion)
    end
  end

  describe "GET edit" do
    it "assigns the requested inscripcion as @inscripcion" do
      inscripcion = Inscripcion.create! valid_attributes
      get :edit, {:id => inscripcion.to_param}, valid_session
      expect(assigns(:inscripcion)).to eq(inscripcion)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Inscripcion" do
        expect {
          post :create, {:inscripcion => valid_attributes}, valid_session
        }.to change(Inscripcion, :count).by(1)
      end

      it "assigns a newly created inscripcion as @inscripcion" do
        post :create, {:inscripcion => valid_attributes}, valid_session
        expect(assigns(:inscripcion)).to be_a(Inscripcion)
        expect(assigns(:inscripcion)).to be_persisted
      end

      it "redirects to the created inscripcion" do
        post :create, {:inscripcion => valid_attributes}, valid_session
        expect(response).to redirect_to(Inscripcion.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved inscripcion as @inscripcion" do
        # Trigger the behavior that occurs when invalid params are submitted
        Inscripcion.any_instance.stub(:save).and_return(false)
        post :create, {:inscripcion => { "torneo_id" => "invalid value" }}, valid_session
        expect(assigns(:inscripcion)).to be_a_new(Inscripcion)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Inscripcion.any_instance.stub(:save).and_return(false)
        post :create, {:inscripcion => { "torneo_id" => "invalid value" }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested inscripcion" do
        inscripcion = Inscripcion.create! valid_attributes
        # Assuming there are no other inscripciones in the database, this
        # specifies that the Inscripcion created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Inscripcion).to receive(:update).with({ "torneo_id" => "1" })
        put :update, {:id => inscripcion.to_param, :inscripcion => { "torneo_id" => "1" }}, valid_session
      end

      it "assigns the requested inscripcion as @inscripcion" do
        inscripcion = Inscripcion.create! valid_attributes
        put :update, {:id => inscripcion.to_param, :inscripcion => valid_attributes}, valid_session
        expect(assigns(:inscripcion)).to eq(inscripcion)
      end

      it "redirects to the inscripcion" do
        inscripcion = Inscripcion.create! valid_attributes
        put :update, {:id => inscripcion.to_param, :inscripcion => valid_attributes}, valid_session
        expect(response).to redirect_to(inscripcion)
      end
    end

    describe "with invalid params" do
      it "assigns the inscripcion as @inscripcion" do
        inscripcion = Inscripcion.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Inscripcion.any_instance.stub(:save).and_return(false)
        put :update, {:id => inscripcion.to_param, :inscripcion => { "torneo_id" => "invalid value" }}, valid_session
        expect(assigns(:inscripcion)).to eq(inscripcion)
      end

      it "re-renders the 'edit' template" do
        inscripcion = Inscripcion.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Inscripcion.any_instance.stub(:save).and_return(false)
        put :update, {:id => inscripcion.to_param, :inscripcion => { "torneo_id" => "invalid value" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested inscripcion" do
      inscripcion = Inscripcion.create! valid_attributes
      expect {
        delete :destroy, {:id => inscripcion.to_param}, valid_session
      }.to change(Inscripcion, :count).by(-1)
    end

    it "redirects to the inscripciones list" do
      inscripcion = Inscripcion.create! valid_attributes
      delete :destroy, {:id => inscripcion.to_param}, valid_session
      expect(response).to redirect_to(inscripciones_url)
    end
  end

end
