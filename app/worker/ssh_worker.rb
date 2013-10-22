class SshWorker
  include Sidekiq::Worker
  sidekiq_options queue: :ssh
  #sidekiq_options retry: false

  def perform(servername , ipaddr , jenkinsSlaveNodeName ,jenkinsSlaveSecret)
    #SshManager.init(servername , ipaddr , jenkinsSlaveNodeName ,jenkinsSlaveSecret)
  end
end

