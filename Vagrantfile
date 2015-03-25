# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.network :private_network, ip: "192.168.33.102"
  config.vm.network :forwarded_port, host: 4568, guest: 80

  config.vm.provision :puppet do |puppet|
    puppet.module_path = "modules"
  end

  config.vm.synced_folder "./source", "/vagrant",
    owner: "www-data",
    group: "www-data"

  config.vm.post_up_message = "If this is the first intall visit: moodle.vagrant:4568 in your browser.\nAlso, make sure to add 127.0.0.1 moodle.vagrant to the hosts file in the host machine"

end
