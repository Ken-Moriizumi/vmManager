require 'spec_helper'

describe Mydatacenter do
    describe "データセンターから情報の取得" do
       before do
          @mydc = Mydatacenter.new
       end

       context "devServerXX01 というVMを検索" do
          before do
             @reth = @mydc.search_vm_by_name("devServerXX01")
          end
          it "devServerXX01 という名前のVirtualMachine オブジェクトを返却" do
             @reth.vm.class.should eq RbVmomi::VIM::VirtualMachine
             @reth.name.should eq "devServerXX01"
          end
          it "devServerXX01のフルパスを返却" do
             @reth.path.should eq "/開発用/業務/devServerXX01"
          end
       end 
       context "存在しないVM fuga というを検索" do
          before do
             @reth = @mydc.search_vm_by_name("fuga")
          end
          it "nil オブジェクトを返却" do
             @reth.class.should eq nil.class
          end
       end 
    end
end
