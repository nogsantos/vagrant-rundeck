require 'yaml'

# Vagrant version
Vagrant.require_version '>= 2.0.1'
path_root = File.dirname(__FILE__)

# Vagrant plugins
required_plugins = ['vagrant-hosts']
required_plugins.each do |plugin|
    raise "Run \'vagrant plugin install #{plugin}\'" unless Vagrant.has_plugin? plugin
end

# Vagrant boxes config parameters
boxes = YAML.load_file("#{path_root}/boxes.yaml")
nodes = boxes['nodes']
config = boxes['config']
network = config['network']
domain = config['domain']

# Definitions
Vagrant.configure('2') do |config|
    # Vagrant config
    config.vbguest.installer_options = { allow_kernel_upgrade: true }
    config.vm.provision :hosts do |provisioner|
        provisioner.autoconfigure = true
        provisioner.sync_hosts = true
        provisioner.add_localhost_hostnames = false
    end

    # Definitions
    nodes.each_with_index do |(node, data), index|
        config.vm.define node do |n|
            # Box
            n.vm.box = data['box']
            n.vm.hostname = "#{node}.#{domain}"
            n.vm.synced_folder '.', '/vagrant', type: 'sshfs'
            # Network
            network_address = "#{network}.#{index + 100}"
            if !data['network'].nil? && !data['network']['forwarded_port'].nil?
                n.vm.network :forwarded_port, guest: data['network']['forwarded_port']['guess'], host: data['network']['forwarded_port']['host']
            end
            n.vm.network :private_network, ip: "#{network_address}"
            # Config
            n.vm.provider 'virtualbox' do |v|
                v.memory = data['memory']
                v.cpus = data['cpus']
                v.customize ['modifyvm', :id, '--ioapic', 'on']
                v.customize ['modifyvm', :id, '--audio', 'none']
            end
            # Scripts
            if !data['script'].nil?
                n.vm.provision "#{data['script']['provision']}", type: "#{data['script']['type']}", path: "#{path_root}/scripts/#{data['script']['name']}", privileged: data['script']['privileged']
            end
        end
    end
end