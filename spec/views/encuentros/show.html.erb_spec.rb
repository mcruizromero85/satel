require 'spec_helper'

describe "encuentros/show" do
  before(:each) do
    @encuentro = assign(:encuentro, stub_model(Encuentro,
      :gamera_id => 1,
      :gamerb_id => 2,
      :posicion_en_ronda => 3,
      :id_ronda => 4,
      :flag_ganador => "Flag Ganador",
      :descripcion => "Descripcion",
      :encuentro_anterior_a_id => 5,
      :encuentro_anterior_b_id => "Encuentro Anterior B"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Flag Ganador/)
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Encuentro Anterior B/)
  end
end
