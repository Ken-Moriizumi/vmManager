require 'spec_helper'

describe "ipaddrs/edit" do
  before(:each) do
    @ipaddr = assign(:ipaddr, stub_model(Ipaddr,
      :ipaddress => "MyString",
      :manageno => "MyString",
      :servername => "MyString",
      :macaddress => "MyString",
      :use => "MyString",
      :remarks => "MyString"
    ))
  end

  it "renders the edit ipaddr form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", ipaddr_path(@ipaddr), "post" do
      assert_select "input#ipaddr_ipaddress[name=?]", "ipaddr[ipaddress]"
      assert_select "input#ipaddr_manageno[name=?]", "ipaddr[manageno]"
      assert_select "input#ipaddr_servername[name=?]", "ipaddr[servername]"
      assert_select "input#ipaddr_macaddress[name=?]", "ipaddr[macaddress]"
      assert_select "input#ipaddr_use[name=?]", "ipaddr[use]"
      assert_select "input#ipaddr_remarks[name=?]", "ipaddr[remarks]"
    end
  end
end
