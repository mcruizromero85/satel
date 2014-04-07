require 'spec_helper'

describe "prueba2s/index" do
  before(:each) do
    assign(:prueba2s, [
      stub_model(Prueba2,
        :estado => "Estado"
      ),
      stub_model(Prueba2,
        :estado => "Estado"
      )
    ])
  end

  it "renders a list of prueba2s" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Estado".to_s, :count => 2
  end
end
