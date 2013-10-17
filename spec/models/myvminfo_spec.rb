require 'spec_helper'

describe Myvminfo do
    describe "インスタンスの作成" do
       before do
          @myvm = Myvminfo.new("VMname","VMpath","192.168.0.1")
       end

       context "メンバの取得" do
          it "name is VMname" do
             @myvm.name.should eq "VMname"
          end
          it "path is VMpath" do
             @myvm.path.should eq "VMpath"
          end
          it "ip is 192.168.0.1" do
             @myvm.ipaddress.should eq "192.168.0.1"
          end
       end 
    end
end
