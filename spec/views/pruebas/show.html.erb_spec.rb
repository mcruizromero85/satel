require 'spec_helper'

describe "pruebas/show" do
  before(:each) do
    @prueba = assign(:prueba, stub_model(Prueba,
      :cadena => "Cadena",
      :entero => 1,
      :decimal => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Cadena/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/9.99/)
  end
end
