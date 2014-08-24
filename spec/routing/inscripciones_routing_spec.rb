require "spec_helper"

describe InscripcionesController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/inscripciones").to route_to("inscripciones#index")
    end

    it "routes to #new" do
      expect(:get => "/inscripciones/new").to route_to("inscripciones#new")
    end

    it "routes to #show" do
      expect(:get => "/inscripciones/1").to route_to("inscripciones#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/inscripciones/1/edit").to route_to("inscripciones#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/inscripciones").to route_to("inscripciones#create")
    end

    it "routes to #update" do
      expect(:put => "/inscripciones/1").to route_to("inscripciones#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/inscripciones/1").to route_to("inscripciones#destroy", :id => "1")
    end

  end
end
