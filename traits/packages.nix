{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wget
    micro
    curl
    rsync
    btop
    magic-wormhole
    unzip
    lsof
    jq
  ];
}
