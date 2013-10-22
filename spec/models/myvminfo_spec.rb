require 'spec_helper'

describe Myvminfo do
    describe "インスタンスの作成" do
       before do
          #vim = RbVmomi::VIM.connect host: '172.17.50.61', user: 'Administrator', password: '10Katu'
          #@dc ||= vim.serviceInstance.find_datacenter("ZR") or fail "datacenter not found"
          @dc = Mydatacenter.new.dc
       end

       context "VMメンバの取得" do
          before do
             @myvm = Myvminfo.new(@dc.find_vm("/開発用/業務/devServerXX01"),"/開発用/業務/devServerXX01")
          end
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
          it "ネットワークラベル is 仮想マシン ネットワーク" do
             @myvm.network.should eq "仮想マシン ネットワーク"
          end
          it "is テンプレート？" do
             @myvm.isTemplate?.should eq false
          end
          it "tools is toolsOk" do
             @myvm.toolsstatus.should eq "toolsOk"
          end
       end 
       context "テンプレートメンバの取得" do
          before do
             @myvmT = Myvminfo.new(@dc.find_vm("/開発用/業務/devServerXX_template"),"/開発用/業務/devServerXX_template")
          end
          it "is テンプレート？" do
             @myvmT.isTemplate?.should eq true
          end
          it "MACアドレス is 00:50:56:9b:4f:38" do
             @myvmT.macaddress.should eq "00:50:56:9b:4f:38"
          end
       end 
       
       context "電源制御 on" do
          before do
             @myvmP = Myvminfo.new(@dc.find_vm("/検証用/hoge"),"/検証用/hoge")
             @myvmP.powerOff if @myvmP.powerstatus == "poweredOn"
          end
          it "電源 on" do
             @myvmP.powerOn
             @myvmP.powerstatus.should eq "poweredOn"
          end
       end 

       context "電源制御 off" do
          before do
             @myvmP = Myvminfo.new(@dc.find_vm("/検証用/hoge"),"/検証用/hoge")
             @myvmP.powerOn if @myvmP.powerstatus == "poweredOff"
          end
          it "電源 off" do
             @myvmP.powerOff
             @myvmP.powerstatus.should eq "poweredOff"
          end
       end 
       
      context "クローン時の挙動" do
          before do
             @myvmC = Myvminfo.new(@dc.find_vm("/開発用/業務/devServerXX_template"),"/開発用/業務/devServerXX_template")
          end
          it "クローンされたVMの名前が、devServerCloneXX01" do
             clonedvm = @myvmC.clone_from_myself("devServerCloneXX01",@dc)
             clonedvm.name.should eq "devServerCloneXX01"
          end
          after do
             @dc.find_vm("/開発用/業務/devServerCloneXX01").Destroy_Task.wait_for_completion if @dc.find_vm("/開発用/業務/devServerCloneXX01")
          end
       end 
    end
end
