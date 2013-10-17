class Myvminfo

  attr_reader :vm, :name,:path,:ipaddress, :powerstatus

  def initialize(vm,path)
      @vm = vm
      @name = vm.name
      @path = path
      @ipaddress = vm.guest.ipAddress
      @powerstatus = vm.runtime.powerState
  end

end
