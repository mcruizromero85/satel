require "spec_helper"

describe EncuentrosController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/encuentros").to route_to("encuentros#index")
    end

    it "routes to #new" do
      expect(:get => "/encuentros/new").to route_to("encuentros#new")
    end

    it "routes to #show" do
      expect(:get => "/encuentros/1").to route_to("encuentros#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/encuentros/1/edit").to route_to("encuentros#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/encuentros").to route_to("encuentros#create")
    end

    it "routes to #update" do
      expect(:put => "/encuentros/1").to route_to("encuentros#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/encuentros/1").to route_to("encuentros#destroy", :id => "1")
    end

  end
end
