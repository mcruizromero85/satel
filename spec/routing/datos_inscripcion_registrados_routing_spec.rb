require "spec_helper"

describe DatosInscripcionRegistradosController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/datos_inscripcion_registrados").to route_to("datos_inscripcion_registrados#index")
    end

    it "routes to #new" do
      expect(:get => "/datos_inscripcion_registrados/new").to route_to("datos_inscripcion_registrados#new")
    end

    it "routes to #show" do
      expect(:get => "/datos_inscripcion_registrados/1").to route_to("datos_inscripcion_registrados#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/datos_inscripcion_registrados/1/edit").to route_to("datos_inscripcion_registrados#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/datos_inscripcion_registrados").to route_to("datos_inscripcion_registrados#create")
    end

    it "routes to #update" do
      expect(:put => "/datos_inscripcion_registrados/1").to route_to("datos_inscripcion_registrados#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/datos_inscripcion_registrados/1").to route_to("datos_inscripcion_registrados#destroy", :id => "1")
    end

  end
end
