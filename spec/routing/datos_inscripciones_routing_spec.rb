require "spec_helper"

describe DatosInscripcionesController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/datos_inscripciones").to route_to("datos_inscripciones#index")
    end

    it "routes to #new" do
      expect(:get => "/datos_inscripciones/new").to route_to("datos_inscripciones#new")
    end

    it "routes to #show" do
      expect(:get => "/datos_inscripciones/1").to route_to("datos_inscripciones#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/datos_inscripciones/1/edit").to route_to("datos_inscripciones#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/datos_inscripciones").to route_to("datos_inscripciones#create")
    end

    it "routes to #update" do
      expect(:put => "/datos_inscripciones/1").to route_to("datos_inscripciones#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/datos_inscripciones/1").to route_to("datos_inscripciones#destroy", :id => "1")
    end

  end
end
