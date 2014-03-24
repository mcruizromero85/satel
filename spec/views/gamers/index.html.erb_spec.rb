require 'spec_helper'

describe "gamers/index" do
  before(:each) do
    assign(:gamers, [
      stub_model(Gamer,
        :nick => "Nick",
        :correo => "Correo",
        :nombres => "Nombres",
        :apellidos => "Apellidos"
      ),
      stub_model(Gamer,
        :nick => "Nick",
        :correo => "Correo",
        :nombres => "Nombres",
        :apellidos => "Apellidos"
      )
    ])
  end

  it "renders a list of gamers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nick".to_s, :count => 2
    assert_select "tr>td", :text => "Correo".to_s, :count => 2
    assert_select "tr>td", :text => "Nombres".to_s, :count => 2
    assert_select "tr>td", :text => "Apellidos".to_s, :count => 2
  end
end
