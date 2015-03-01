require 'spec_helper'

describe "DatosInscripcionRegistrados" do
  describe "GET /datos_inscripcion_registrados" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get datos_inscripcion_registrados_path
      expect(response.status).to be(200)
    end
  end
end
