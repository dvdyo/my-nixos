{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  inherit (inputs.NixVirt.lib) domain network;
  cfg = config.custom.virtualization.libvirt;
in
{
  config = lib.mkIf cfg.enable {
    virtualisation.libvirt.connections."qemu:///system" = {
      # 1. Standard Bridge Network
      networks = [
        {
          definition = network.writeXML (network.templates.bridge {
            uuid = "70b08691-28dc-4b47-90a1-45bbeac9ab5a";
            subnet_byte = 71; # 192.168.71.0/24
          });
          active = true;
        }
      ];

      # 2. Main Storage Pool
      pools = [
        {
          definition = pkgs.writeText "main-pool.xml" ''
            <pool type='dir'>
              <name>default</name>
              <uuid>650c5bbb-eebd-4cea-8a2f-36e1a75a8683</uuid>
              <target>
                <path>/var/lib/libvirt/images</path>
              </target>
            </pool>
          '';
          active = true;
        }
      ];

     domains = [
#       # Kali Linux
#       {
#         definition = domain.writeXML (domain.templates.linux {
#           name = "kali";
#           uuid = "cc7439ed-36af-4696-a6f2-1f0c4474d87e";
#           memory = { count = 4; unit = "GiB"; };
#           
#           install_vol = "/var/lib/libvirt/iso/kali-linux-latest-installer-amd64.iso";
#           storage_vol = "/var/lib/libvirt/images/kali.qcow2";
#         });
#         active = false;
#       }

        # Windows 11
          {
          definition = domain.writeXML (lib.recursiveUpdate (domain.templates.windows {
            name = "windows11";
            uuid = "def734bb-e2ca-44ee-80f5-0ea0f2593aaa";
            memory = { count = 8; unit = "GiB"; };
            vcpu = { count = 4; };
            storage_vol = "/var/lib/libvirt/images/win11.qcow2";
            install_vol = "/var/lib/libvirt/images/win11.iso";
            nvram_path = "/var/lib/libvirt/qemu/nvram/win11.nvram";
            virtio_net = true;
            virtio_drive = true;
            install_virtio = true;
          }) {
            # THIS IS THE OVERRIDE SECTION
            devices = {
              # Disable 3D acceleration on the GPU
              video = [{
                model = {
                  type = "virtio";
                  acceleration = { accel3d = "no"; };
                };
              }];
              #  Disable OpenGL on the Spice display
              graphics = [{
                type = "spice";
                gl = { enable = "no"; };
              }];
            };
          });
          active = false;
        }
      ];
    };
  };
}
