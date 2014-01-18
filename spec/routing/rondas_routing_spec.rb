require "spec_helper"

describe RondasController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/rondas").to route_to("rondas#index")
    end

    it "routes to #new" do
      expect(:get => "/rondas/new").to route_to("rondas#new")
    end

    it "routes to #show" do
      expect(:get => "/rondas/1").to route_to("rondas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/rondas/1/edit").to route_to("rondas#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/rondas").to route_to("rondas#create")
    end

    it "routes to #update" do
      expect(:put => "/rondas/1").to route_to("rondas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rondas/1").to route_to("rondas#destroy", :id => "1")
    end

  end
end
