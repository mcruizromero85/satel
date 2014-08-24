require 'spec_helper'

describe "authentications/show" do
  before(:each) do
    @authentication = assign(:authentication, stub_model(Authentication,
      :user_id => 1,
      :provider => "Provider",
      :uid => "Uid",
      :index => "Index",
      :create => "Create",
      :destroy => "Destroy"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Provider/)
    expect(rendered).to match(/Uid/)
    expect(rendered).to match(/Index/)
    expect(rendered).to match(/Create/)
    expect(rendered).to match(/Destroy/)
  end
end
