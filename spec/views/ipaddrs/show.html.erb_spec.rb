require 'spec_helper'

describe "ipaddrs/show" do
  before(:each) do
    @ipaddr = assign(:ipaddr, stub_model(Ipaddr,
      :ipaddress => "Ipaddress",
      :manageno => "Manageno",
      :macaddress => "Macaddress",
      :use => "Use",
      :remarks => "Remarks"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ipaddress/)
    rendered.should match(/Manageno/)
    rendered.should match(/Macaddress/)
    rendered.should match(/Use/)
    rendered.should match(/Remarks/)
  end
end
