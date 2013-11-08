require 'spec_helper'

describe "ipaddrs/index" do
  before(:each) do
    assign(:ipaddrs, [
      stub_model(Ipaddr,
        :ipaddress => "Ipaddress",
        :manageno => "Manageno",
        :macaddress => "Macaddress",
        :use => "Use",
        :remarks => "Remarks"
      ),
      stub_model(Ipaddr,
        :ipaddress => "Ipaddress",
        :manageno => "Manageno",
        :macaddress => "Macaddress",
        :use => "Use",
        :remarks => "Remarks"
      )
    ])
  end

  it "renders a list of ipaddrs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ipaddress".to_s, :count => 2
    assert_select "tr>td", :text => "Manageno".to_s, :count => 2
    assert_select "tr>td", :text => "Macaddress".to_s, :count => 2
    assert_select "tr>td", :text => "Use".to_s, :count => 2
    assert_select "tr>td", :text => "Remarks".to_s, :count => 2
  end
end
