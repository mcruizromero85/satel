require 'spec_helper'

describe "gamers/edit" do
  before(:each) do
    @gamer = assign(:gamer, stub_model(Gamer,
      :nick => "MyString",
      :correo => "MyString",
      :nombres => "MyString",
      :apellidos => "MyString"
    ))
  end

  it "renders the edit gamer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", gamer_path(@gamer), "post" do
      assert_select "input#gamer_nick[name=?]", "gamer[nick]"
      assert_select "input#gamer_correo[name=?]", "gamer[correo]"
      assert_select "input#gamer_nombres[name=?]", "gamer[nombres]"
      assert_select "input#gamer_apellidos[name=?]", "gamer[apellidos]"
    end
  end
end
