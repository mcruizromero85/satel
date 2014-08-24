require 'spec_helper'

describe "ordens/show" do
  before(:each) do
    @orden = assign(:orden, stub_model(Orden,
      :dni => "Dni",
      :password => "Password",
      :sku => "Sku",
      :medio_de_pago => "Medio De Pago"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Dni/)
    expect(rendered).to match(/Password/)
    expect(rendered).to match(/Sku/)
    expect(rendered).to match(/Medio De Pago/)
  end
end
