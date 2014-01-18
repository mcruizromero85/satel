require 'spec_helper'

describe "rondas/new" do
  before(:each) do
    assign(:ronda, stub_model(Ronda,
      :numero => 1,
      :modo_ganar => "MyString",
      :torneo_id => 1
    ).as_new_record)
  end

  it "renders new ronda form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", rondas_path, "post" do
      assert_select "input#ronda_numero[name=?]", "ronda[numero]"
      assert_select "input#ronda_modo_ganar[name=?]", "ronda[modo_ganar]"
      assert_select "input#ronda_torneo_id[name=?]", "ronda[torneo_id]"
    end
  end
end
