require 'spec_helper'

describe "juegos/index" do
  before(:each) do
    assign(:juegos, [
      stub_model(Juego,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :asociado_id => 1
      ),
      stub_model(Juego,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :asociado_id => 1
      )
    ])
  end

  it "renders a list of juegos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
