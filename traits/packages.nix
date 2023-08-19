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
    jhead
    tar
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
