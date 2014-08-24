require 'spec_helper'

describe "ordens/new" do
  before(:each) do
    assign(:orden, stub_model(Orden,
      :dni => "MyString",
      :password => "MyString",
      :sku => "MyString",
      :medio_de_pago => "MyString"
    ).as_new_record)
  end

  it "renders new orden form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", ordens_path, "post" do
      assert_select "input#orden_dni[name=?]", "orden[dni]"
      assert_select "input#orden_password[name=?]", "orden[password]"
      assert_select "input#orden_sku[name=?]", "orden[sku]"
      assert_select "input#orden_medio_de_pago[name=?]", "orden[medio_de_pago]"
    end
  end
end
