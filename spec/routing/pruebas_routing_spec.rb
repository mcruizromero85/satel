require "spec_helper"

describe PruebasController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pruebas").to route_to("pruebas#index")
    end

    it "routes to #new" do
      expect(:get => "/pruebas/new").to route_to("pruebas#new")
    end

    it "routes to #show" do
      expect(:get => "/pruebas/1").to route_to("pruebas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pruebas/1/edit").to route_to("pruebas#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pruebas").to route_to("pruebas#create")
    end

    it "routes to #update" do
      expect(:put => "/pruebas/1").to route_to("pruebas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pruebas/1").to route_to("pruebas#destroy", :id => "1")
    end

  end
end
