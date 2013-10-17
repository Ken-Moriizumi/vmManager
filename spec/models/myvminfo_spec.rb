require 'spec_helper'

describe Myvminfo do
    describe "インスタンスの作成" do
       before do
          vim = RbVmomi::VIM.connect host: '172.17.50.61', user: 'Administrator', password: '10Katu'
          @dc ||= vim.serviceInstance.find_datacenter("ZR") or fail "datacenter not found"
          @myvm = Myvminfo.new(@dc.find_vm("/開発用/業務/devServerXX01"),"/開発用/業務/devServerXX01")
       end

       context "メンバの取得" do
          it "vm is VirtualMachine" do
             @myvm.vm.class.should eq RbVmomi::VIM::VirtualMachine
          end
          it "name is devServerXX01" do
             @myvm.name.should eq "devServerXX01"
          end
          it "path is /開発用/業務/devServerXX01" do
             @myvm.path.should eq "/開発用/業務/devServerXX01"
          end
          it "ip is 172.17.50.137" do
             @myvm.ipaddress.should eq "172.17.50.137"
          end
          it "電源状態 is poweredOn" do
             @myvm.powerstatus.should eq "poweredOn"
          end
       end 
    end
end
