require 'spec_helper'

describe "ordens/edit" do
  before(:each) do
    @orden = assign(:orden, stub_model(Orden,
      :dni => "MyString",
      :password => "MyString",
      :sku => "MyString",
      :medio_de_pago => "MyString"
    ))
  end

  it "renders the edit orden form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", orden_path(@orden), "post" do
      assert_select "input#orden_dni[name=?]", "orden[dni]"
      assert_select "input#orden_password[name=?]", "orden[password]"
      assert_select "input#orden_sku[name=?]", "orden[sku]"
      assert_select "input#orden_medio_de_pago[name=?]", "orden[medio_de_pago]"
    end
  end
end
