require "spec_helper"

describe Prueba2sController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/prueba2s").to route_to("prueba2s#index")
    end

    it "routes to #new" do
      expect(:get => "/prueba2s/new").to route_to("prueba2s#new")
    end

    it "routes to #show" do
      expect(:get => "/prueba2s/1").to route_to("prueba2s#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/prueba2s/1/edit").to route_to("prueba2s#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/prueba2s").to route_to("prueba2s#create")
    end

    it "routes to #update" do
      expect(:put => "/prueba2s/1").to route_to("prueba2s#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/prueba2s/1").to route_to("prueba2s#destroy", :id => "1")
    end

  end
end
