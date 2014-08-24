require 'spec_helper'

describe "ordens/index" do
  before(:each) do
    assign(:ordens, [
      stub_model(Orden,
        :dni => "Dni",
        :password => "Password",
        :sku => "Sku",
        :medio_de_pago => "Medio De Pago"
      ),
      stub_model(Orden,
        :dni => "Dni",
        :password => "Password",
        :sku => "Sku",
        :medio_de_pago => "Medio De Pago"
      )
    ])
  end

  it "renders a list of ordens" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Dni".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
    assert_select "tr>td", :text => "Sku".to_s, :count => 2
    assert_select "tr>td", :text => "Medio De Pago".to_s, :count => 2
  end
end
