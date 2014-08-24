require "spec_helper"

describe OrdensController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ordens").to route_to("ordens#index")
    end

    it "routes to #new" do
      expect(:get => "/ordens/new").to route_to("ordens#new")
    end

    it "routes to #show" do
      expect(:get => "/ordens/1").to route_to("ordens#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ordens/1/edit").to route_to("ordens#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ordens").to route_to("ordens#create")
    end

    it "routes to #update" do
      expect(:put => "/ordens/1").to route_to("ordens#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ordens/1").to route_to("ordens#destroy", :id => "1")
    end

  end
end
