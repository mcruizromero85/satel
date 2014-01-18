require 'spec_helper'

describe "rondas/index" do
  before(:each) do
    assign(:rondas, [
      stub_model(Ronda,
        :numero => 1,
        :modo_ganar => "Modo Ganar",
        :torneo_id => 2
      ),
      stub_model(Ronda,
        :numero => 1,
        :modo_ganar => "Modo Ganar",
        :torneo_id => 2
      )
    ])
  end

  it "renders a list of rondas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Modo Ganar".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
