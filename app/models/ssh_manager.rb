class SshManager
require 'rubygems'
require 'net/ssh'
#config.action_mailer.raise_delivery_errors = true

   def self.init(servername , ipaddr , jenkinsSlaveNodeName ,jenkinsSlaveSecret)
      opt = { :password => '10Katu'}
       
      100.times { |i|
         puts "waiting!!!!!"
         begin
            Net::SSH.start('172.17.50.170', 'root', opt) do |ssh|
                sleep 120
                ssh.exec!(initting_script(servername , ipaddr , jenkinsSlaveNodeName ,jenkinsSlaveSecret))
                ssh.exec!("reboot")
            end
            break
         rescue
         end
         sleep 6
      }
   end

private
  
  def self.initting_script(servername , ipaddr , jenkinsSlaveNodeName ,jenkinsSlaveSecret)
     "/mnt/D209007/sh/fist_setup.sh \"#{servername}\" \"#{ipaddr}\" \"#{jenkinsSlaveNodeName}\" \"#{jenkinsSlaveSecret}\""
  end
end
