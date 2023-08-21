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
    hyfetch
    neofetch
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
