require "spec_helper"

describe GamersController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/gamers").to route_to("gamers#index")
    end

    it "routes to #new" do
      expect(:get => "/gamers/new").to route_to("gamers#new")
    end

    it "routes to #show" do
      expect(:get => "/gamers/1").to route_to("gamers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/gamers/1/edit").to route_to("gamers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/gamers").to route_to("gamers#create")
    end

    it "routes to #update" do
      expect(:put => "/gamers/1").to route_to("gamers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/gamers/1").to route_to("gamers#destroy", :id => "1")
    end

  end
end
