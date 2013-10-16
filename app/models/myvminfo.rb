class Myvminfo

  attr_reader :name,:path,:ipaddress

  def initialize(name,path,ipaddress)
      @name = name
      @path = path
      @ipaddress = ipaddress
  end

end
