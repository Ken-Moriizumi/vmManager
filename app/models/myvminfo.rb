class Myvminfo

  attr_reader :vm, :name,:path,:ipaddress, :powerstatus ,:macaddress ,:toolsstatus

  def initialize(vm,path)
      @vm = vm
      @name = vm.name
      @path = path
      get_ipAddr_from_vm
      get_powerStatus_from_vm
      get_macAddr_from_vm
      get_toolsStatus_from_vm 
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
end
