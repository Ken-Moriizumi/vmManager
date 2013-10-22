class CloneWorker
  include Sidekiq::Worker
  sidekiq_options queue: :clone
  sidekiq_options retry: false

  def perform(before,name, ipaddr , jenkinsSlaveNodeName ,jenkinsSlaveSecret)
    myDc = Mydatacenter.new
    @vminfo = myDc.search_vm_by_name(before)
    vm = @vminfo.clone_from_myself(name,myDc.dc)
    vm.powerOn
    SshManager.init(name , ipaddr , jenkinsSlaveNodeName ,jenkinsSlaveSecret)
  end
end
