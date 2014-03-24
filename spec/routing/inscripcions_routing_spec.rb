require "spec_helper"

describe InscripcionsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/inscripcions").to route_to("inscripcions#index")
    end

    it "routes to #new" do
      expect(:get => "/inscripcions/new").to route_to("inscripcions#new")
    end

    it "routes to #show" do
      expect(:get => "/inscripcions/1").to route_to("inscripcions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/inscripcions/1/edit").to route_to("inscripcions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/inscripcions").to route_to("inscripcions#create")
    end

    it "routes to #update" do
      expect(:put => "/inscripcions/1").to route_to("inscripcions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/inscripcions/1").to route_to("inscripcions#destroy", :id => "1")
    end

  end
end
