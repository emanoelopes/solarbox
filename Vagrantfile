Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.network "forwarded_port", guest: 3000, host: 3000
  # Instalar os pacotes do linux(provisionamento)
  #
  # config.vm.provision :shell, path: "https://github.com/orendon/vagrant-rails/raw/master/script/vagrant_bootstrap.sh", privileged: false
  config.vm.provision :shell, path: "script/vagrant_bootstrap.sh", privileged: false
  
  # Compartilhar diretórios(pastas) adicionais para a máquina hospedeira
  #
  # config.vm.synced_folder "../folder_on_your_host_machine", "/folder_on_vagrant_vm"
end
