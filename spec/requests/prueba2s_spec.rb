require 'spec_helper'

describe "Prueba2s" do
  describe "GET /prueba2s" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get prueba2s_path
      expect(response.status).to be(200)
    end
  end
end
