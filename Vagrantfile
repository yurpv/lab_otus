MACHINES = {
  :"kernel-update" => {
              :box_name => "gyptazy/debian12.1-arm64",
              :box_version => "1.0.0",
              :cpus => 2,
              :memory => 1024,
            }
}

Vagrant.configure("2") do |config|
  MACHINES.each do |boxname, boxconfig|
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.define boxname do |box|
      box.vm.box = boxconfig[:box_name]
      box.vm.box_version = boxconfig[:box_version]
      box.vm.host_name = boxname.to_s
      box.vm.provider :vmware_desktop do |vmware|
        vmware.gui = true
        vmware.vmx["ethernet0.virtualdev"] = "vmxnet3"
        vmware.memory = boxconfig[:memory]
        vmware.cpus = boxconfig[:cpus]
      end
    end
  end
end
