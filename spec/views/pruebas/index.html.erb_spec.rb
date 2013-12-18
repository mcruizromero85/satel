require 'spec_helper'

describe "pruebas/index" do
  before(:each) do
    assign(:pruebas, [
      stub_model(Prueba,
        :cadena => "Cadena",
        :entero => 1,
        :decimal => "9.99"
      ),
      stub_model(Prueba,
        :cadena => "Cadena",
        :entero => 1,
        :decimal => "9.99"
      )
    ])
  end

  it "renders a list of pruebas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Cadena".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
