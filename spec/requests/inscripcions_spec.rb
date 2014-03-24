require 'spec_helper'

describe "Inscripcions" do
  describe "GET /inscripcions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get inscripcions_path
      expect(response.status).to be(200)
    end
  end
end
