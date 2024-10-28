{
  # disko.devices.disk.internal = {
  #   device = "/dev/disk/by-id/nvme-KINGSTON_SNV2S1000G_50026B738349746F";
  #   type = "disk";
  #   content = {
  #     type = "gpt";
  #     partitions.ESP = {
  #       size = "500M";
  #       type = "EF00";
  #       content = {
  #         type = "filesystem";
  #         format = "vfat";
  #         mountpoint = "/boot";
  #         mountOptions = ["umask=0077"];
  #       };
  #     };
  #     partitions.luks = {
  #       size = "100%";
  #       content = {
  #         type = "luks";
  #         name = "crypted";
  #         settings.allowDiscards = true;
  #         passwordFile = "/tmp/secret.key";
  #         content = {
  #           type = "btrfs";
  #           extraArgs = ["-f"];
  #           mountpoint = "/";
  #           mountOptions = ["compress=zstd" "noatime"];
  #         };
  #       };
  #     };
  #   };
  # };
}
