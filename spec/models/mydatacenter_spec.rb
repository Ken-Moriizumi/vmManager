require 'spec_helper'

describe Mydatacenter do
    describe "データセンターから情報の取得" do
       before do
          @mydc = Mydatacenter.new
       end

       context "hoge というVMを検索" do
          before do
             @reth = @mydc.search_vm_by_name("hoge")
          end
          it "hoge という名前のVirtualMachine オブジェクトを返却" do
             @reth['obj'].class.should eq RbVmomi::VIM::VirtualMachine
             @reth['obj'].name.should eq "hoge"
          end
          it "hogeのフルパスを返却" do
             @reth['fullName'].should eq "/検証用/hoge"
          end
       end 
       context "存在しないVM fuga というを検索" do
          before do
             @reth = @mydc.search_vm_by_name("fuga")
          end
          it "nil オブジェクトを返却" do
             @reth['obj'].class.should eq nil.class
          end
          it "フルパスにfugaを返却" do
             @reth['fullName'].should eq "fuga"
          end
       end 
    end
end
