{ config, pkgs, stdenv, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./traits/hardening/memory.nix
    ./traits/hardening/openssh.nix
    ./traits/hardening/sudo.nix
    ./traits/hardening/sysctl.nix
    ./traits/hardening/systemd.nix
    ./traits/security/auditing.nix
    ./traits/security/lynis.nix
    ./traits/security/apparmor.nix
    ./traits/jessew/jessew.nix
    ./traits/jessew/ssh-keys.nix
    ./traits/timezone-honolulu.nix
    ./traits/packages.nix
    ./traits/zerotier-a09acf0233609fc8.nix
    ./traits/zsh.nix
    ./traits/flakes.nix
    ./traits/plasma.nix
    ./traits/nextdns.nix
    ./traits/sound.nix
    ./traits/syncthing.nix
    (import "${home-manager}/nixos")
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  nixpkgs.config.packageOverrides = pkgs: {
    llama-cpp = (builtins.getFlake
      "github:ggerganov/llama.cpp").packages.${builtins.currentSystem}.default;
  };

  home-manager.users.jessew = import ./traits/jessew/home-manager.nix;

  # Setup keyfile
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

  hardware.bluetooth.enable = true;

  services.logrotate = { enable = true; };

  programs.adb.enable = true;

  networking.hostName = "hacktop"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable Flatpak
  services.flatpak.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;

  users.users.jessew = {
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    packages = with pkgs; [
      kate
      libreoffice-qt
      dbeaver
      llama-cpp
      neofetch
      vscode-fhs
      spicetify-cli
      vlc
      mpv
      nodePackages_latest.pnpm
      qbittorrent
      wineWowPackages.staging
      winetricks
      wineWowPackages.waylandFull
      syncthingtray
      nodejs_18
      syncplay
    ];
  };

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    python311
    waypipe
    magic-wormhole
    bun
    flameshot
    neofetch
    rustup
    gcc
    clang
    cmake
    libclang
    libcxx
    nixfmt
    rnix-lsp
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 9354 3000 2467 ];
  networking.firewall.allowedUDPPorts = [ 2467 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
