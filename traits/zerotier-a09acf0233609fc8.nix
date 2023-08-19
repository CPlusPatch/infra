{ config, pkgs, ... }: {
  services.zerotierone = {
    package = pkgs.zerotierone;
    enable = true;
    joinNetworks = [ "a09acf0233609fc8" ];
  };
}
