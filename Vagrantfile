$script = <<-'SCRIPT'
        sudo yum -y  install docker
        sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        sudo systemctl start docker
        sudo systemctl enable docker
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker 
        sudo sed -i '/PasswordAuthentication/d' /etc/ssh/sshd_config
        sudo bash -c "echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config" 
SCRIPT

Vagrant.configure("2") do |config|
    config.vm.define "staging" do |staging|
    staging.vm.provider :virtualbox
    staging.vm.box = "centos/7"
    staging.vm.hostname = "master.staging.local"
    staging.vm.network :private_network, ip:"10.0.0.4"
    staging.ssh.forward_agent = true
    staging.vm.provision "shell", inline:$script
 
    end  
    config.vm.define "production" do |production|
    production.vm.provider :virtualbox
    production.vm.box = "centos/7"
    production.vm.hostname = "master.prod.local"
    production.vm.network :private_network, ip:"10.0.0.5"
    production.ssh.forward_agent = true
    production.vm.provision "shell", inline:$script
 
    end  
end
