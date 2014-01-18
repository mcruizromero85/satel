require 'spec_helper'

describe "rondas/show" do
  before(:each) do
    @ronda = assign(:ronda, stub_model(Ronda,
      :numero => 1,
      :modo_ganar => "Modo Ganar",
      :torneo_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Modo Ganar/)
    expect(rendered).to match(/2/)
  end
end
