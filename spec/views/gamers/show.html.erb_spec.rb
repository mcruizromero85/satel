require 'spec_helper'

describe "gamers/show" do
  before(:each) do
    @gamer = assign(:gamer, stub_model(Gamer,
      :nick => "Nick",
      :correo => "Correo",
      :nombres => "Nombres",
      :apellidos => "Apellidos"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Nick/)
    expect(rendered).to match(/Correo/)
    expect(rendered).to match(/Nombres/)
    expect(rendered).to match(/Apellidos/)
  end
end
