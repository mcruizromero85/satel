require "spec_helper"

describe JuegosController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/juegos").to route_to("juegos#index")
    end

    it "routes to #new" do
      expect(:get => "/juegos/new").to route_to("juegos#new")
    end

    it "routes to #show" do
      expect(:get => "/juegos/1").to route_to("juegos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/juegos/1/edit").to route_to("juegos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/juegos").to route_to("juegos#create")
    end

    it "routes to #update" do
      expect(:put => "/juegos/1").to route_to("juegos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/juegos/1").to route_to("juegos#destroy", :id => "1")
    end

  end
end
