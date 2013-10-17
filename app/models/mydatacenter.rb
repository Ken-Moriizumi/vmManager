class Mydatacenter
   require 'rbvmomi'
   require 'rubygems'
   OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

   attr_reader :vmArray

   def initialize
      vim = RbVmomi::VIM.connect host: '172.17.50.61', user: 'Administrator', password: '10Katu'
      @dc ||= vim.serviceInstance.find_datacenter("ZR") or fail "datacenter not found"

      @vmArray ||= Array.new
      @fdArray ||= Array.new
      getVms
   end

   def search_vm_by_name(name)
      @vmArray.each do |vmHash|
        return vmHash if vmHash['obj'].name =~ /#{name}$/
      end
      set_value_folderHash(nil,name)
   end

private
   def getVms
      init_search_place.each do |folder|
          search_vms_by_folders folder
      end
   end

   def search_vms_by_folders(folderHash)
      folderHash['obj'].childEntity.each do |child|
         newFolderHash = set_value_folderHash(child,folderHash['fullName'] + "/" + child.name)
         @fdArray.push newFolderHash if /^Folder/  =~ child.to_s
         @vmArray.push newFolderHash if /^VirtualMachine/  =~ child.to_s
      end
   end
   
   def init_search_place
      folder = @dc.vmFolder
      @fdArray.push set_value_folderHash( folder ,"" )
   end

   def set_value_folderHash(obj,fullName)
      {'obj' => obj, 'fullName' => fullName}
   end
end

#def get_ipaddr_by_vm(vm)
#   return vm.guest.ipAddress || "" unless vm.nil?
#   ipaddr = ""
#end
#
#def get_name_by_vm(vm)
#   return vm.name || "" unless vm.nil?
#   name = ""
#end
#
#def print_vm_info(vm)
#   puts "名前:" + get_name_by_vm(vm) + "  IPアドレス:" +  get_ipaddr_by_vm(vm)
#end
#
#
#myDc = MyDataCenter.new
#vms = myDc.vmArray
#vms.each do |vm|
#    print_vm_info vm['obj']
#end
#
#tergetVm = myDc.search_vm_by_name("fuga")['obj']
#print_vm_info tergetVm
#
##tergetVm.PowerOffVM_Task.wait_for_completion
##tergetVm.PowerOnVM_Task.wait_for_completion
