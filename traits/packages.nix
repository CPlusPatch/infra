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
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
