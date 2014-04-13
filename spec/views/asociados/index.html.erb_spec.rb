require 'spec_helper'

describe "asociados/index" do
  before(:each) do
    assign(:asociados, [
      stub_model(Asociado,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :juego_id => 1
      ),
      stub_model(Asociado,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :juego_id => 1
      )
    ])
  end

  it "renders a list of asociados" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
