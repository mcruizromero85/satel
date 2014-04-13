require 'spec_helper'

describe "asociados/show" do
  before(:each) do
    @asociado = assign(:asociado, stub_model(Asociado,
      :nombre => "Nombre",
      :descripcion => "Descripcion",
      :juego_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/1/)
  end
end
