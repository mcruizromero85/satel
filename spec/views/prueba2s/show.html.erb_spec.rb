require 'spec_helper'

describe "prueba2s/show" do
  before(:each) do
    @prueba2 = assign(:prueba2, stub_model(Prueba2,
      :estado => "Estado"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Estado/)
  end
end
