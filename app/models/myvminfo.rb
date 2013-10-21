class Myvminfo

  attr_reader :vm, :name,:path,:ipaddress, :powerstatus ,:macaddress ,:toolsstatus ,:network


  def initialize(vm,path)
      @vm = vm
      @name = vm.name
      @path = path
      get_ipAddr_from_vm
      get_powerStatus_from_vm
      get_macAddr_from_vm
      get_toolsStatus_from_vm 
      get_network_from_vm 
  end
  
  def isTemplate?
      @vm.config.template
  end

  def powerOn
      @vm.PowerOnVM_Task.wait_for_completion if get_powerStatus_from_vm != "poweredOn"
      check_vm_powerStatus("poweredOn")
  end
  
  def powerOff
      if get_toolsStatus_from_vm == "toolsOk"
         @vm.ShutdownGuest if get_powerStatus_from_vm != "poweredOff" 
      else
         @vm.PowerOffVM_Task.wait_for_completion if get_powerStatus_from_vm != "poweredOff" 
      end 
      check_vm_powerStatus("poweredOff")
  end
  
  def clone_from_myself(cloneName,dc)
      clonedVm = clone_vm_Task(cloneName)
      modify_from_template_to_vm(clonedVm,dc)
      Myvminfo.new(clonedVm,"/開発用/業務/#{name}")
  end
  
private
  def check_vm_powerStatus(state)
      100.times do
         return true if get_powerStatus_from_vm == state
         sleep 6
      end
      false
  end

  def get_macAddr_from_vm
      @macaddress = ""
      begin
         @vm.config.hardware.device.each do |dev|
             @macaddress = dev.macAddress if dev.deviceInfo.label == "ネットワーク アダプタ 1"
         end
      rescue
      end
      @macaddress
  end

  def get_toolsStatus_from_vm
      @toolsstatus = @vm.guest.toolsStatus
  end
  
  def get_powerStatus_from_vm
      @powerstatus = @vm.runtime.powerState
  end
  
  def get_ipAddr_from_vm
      @ipaddress = @vm.guest.ipAddress
  end
  
  def get_network_from_vm
      network = []
      begin
         @vm.network.each do |dev|
             network.push dev.name
         end
      rescue
      end
      @network = network.join(',')
  end
  
  def clone_vm_Task(cloneName)
      relocateSpec = RbVmomi::VIM.VirtualMachineRelocateSpec
      spec = RbVmomi::VIM.VirtualMachineCloneSpec(:location => relocateSpec, :powerOn => false, :template => self.isTemplate? )
      clonedVm = @vm.CloneVM_Task(:folder => @vm.parent, :name => cloneName, :spec => spec).wait_for_completion
  end

  def modify_from_template_to_vm(vm,dc)
      pool = nil
      dc.hostFolder.childEntity.each do |ce|
          pool = ce.resourcePool if ce.name == "Toshiba"
      end
      vm.MarkAsVirtualMachine({:pool => pool}) if self.isTemplate?
  end
end
