require 'spec_helper'

describe "prueba2s/new" do
  before(:each) do
    assign(:prueba2, stub_model(Prueba2,
      :estado => "MyString"
    ).as_new_record)
  end

  it "renders new prueba2 form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", prueba2s_path, "post" do
      assert_select "input#prueba2_estado[name=?]", "prueba2[estado]"
    end
  end
end
