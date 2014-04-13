require "spec_helper"

describe AsociadosController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/asociados").to route_to("asociados#index")
    end

    it "routes to #new" do
      expect(:get => "/asociados/new").to route_to("asociados#new")
    end

    it "routes to #show" do
      expect(:get => "/asociados/1").to route_to("asociados#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/asociados/1/edit").to route_to("asociados#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/asociados").to route_to("asociados#create")
    end

    it "routes to #update" do
      expect(:put => "/asociados/1").to route_to("asociados#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/asociados/1").to route_to("asociados#destroy", :id => "1")
    end

  end
end
