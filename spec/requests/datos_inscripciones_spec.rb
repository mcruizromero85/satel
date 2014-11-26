require 'spec_helper'

describe "DatosInscripciones" do
  describe "GET /datos_inscripciones" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get datos_inscripciones_path
      expect(response.status).to be(200)
    end
  end
end
