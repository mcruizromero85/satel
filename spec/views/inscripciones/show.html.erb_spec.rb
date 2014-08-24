require 'spec_helper'

describe "inscripciones/show" do
  before(:each) do
    @inscripcion = assign(:inscripcion, stub_model(Inscripcion,
      :torneo_id => 1,
      :gamer_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
