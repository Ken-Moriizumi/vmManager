class Myvminfo

  attr_reader :vm, :name,:path,:ipaddress, :powerstatus ,:macaddress

  def initialize(vm,path)
      @vm = vm
      @name = vm.name
      @path = path
      @ipaddress = vm.guest.ipAddress
      @powerstatus = vm.runtime.powerState
      @macaddress = get_macaddr_from_vm
  end
  
  def isTemplate?
      @vm.config.template
  end

private
  def get_macaddr_from_vm
      @vm.config.hardware.device.each do |dev|
           return dev.macAddress if dev.deviceInfo.label == "ネットワーク アダプタ 1"
      end || ""
  end
end
