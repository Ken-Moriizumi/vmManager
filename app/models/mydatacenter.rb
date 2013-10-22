class Mydatacenter
   require 'rbvmomi'
   require 'rubygems'
   OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

   attr_reader :vmArray,:dc

   def initialize
      begin
         get_connection_to_vCenter
      rescue RbVmomi::Fault
         $vim = nil
         get_connection_to_vCenter
      end
      getVms
   end

   def search_vm_by_name(name)
      @vmArray.each do |vm|
        return vm if vm.name =~ /#{name}$/
      end
      nil
   end

private
   def get_connection_to_vCenter
      $vim ||= RbVmomi::VIM.connect host: '172.17.50.61', user: 'Administrator', password: '10Katu'
      @dc ||= $vim.serviceInstance.find_datacenter("ZR") or fail "datacenter not found"
   end

   def getVms
      @vmArray = Array.new
      @fdArray = Array.new
      init_search_place.each do |folder|
          search_vms_from_folders folder
      end
   end

   def search_vms_from_folders(folderHash)
      folderHash['obj'].childEntity.each do |child|
         newFolderHash = set_value_folderHash(child,folderHash['fullName'] + "/" + child.name)
         @fdArray.push newFolderHash if /^Folder/  =~ child.to_s
         @vmArray.push set_folderHash_to_myvminfo(newFolderHash) if /^VirtualMachine/  =~ child.to_s
      end
   end
   
   def init_search_place
      @fdArray.push set_value_folderHash( @dc.vmFolder ,"" )
   end

   def set_value_folderHash(obj,fullName)
      {'obj' => obj, 'fullName' => fullName}
   end

   def set_folderHash_to_myvminfo(folderHash)
      Myvminfo.new(folderHash['obj'],folderHash['fullName'])
   end
end

