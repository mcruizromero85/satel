require 'spec_helper'

describe "prueba2s/edit" do
  before(:each) do
    @prueba2 = assign(:prueba2, stub_model(Prueba2,
      :estado => "MyString"
    ))
  end

  it "renders the edit prueba2 form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", prueba2_path(@prueba2), "post" do
      assert_select "input#prueba2_estado[name=?]", "prueba2[estado]"
    end
  end
end
