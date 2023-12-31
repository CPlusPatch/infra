{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./traits/hardening/memory.nix
    ./traits/hardening/openssh.nix
    ./traits/hardening/sudo.nix
    ./traits/hardening/sysctl.nix
    ./traits/hardening/systemd.nix
    ./traits/hardening/kernel.nix
    ./traits/security/auditing.nix
    ./traits/security/clamav.nix
    ./traits/security/lynis.nix
    ./traits/security/apparmor.nix
    ./traits/jessew/jessew.nix
    ./traits/jessew/ssh-keys.nix
    ./traits/kio/kio.nix
    ./traits/timezone-toronto.nix
    ./traits/packages.nix
    ./traits/zerotier-a09acf0233609fc8.nix
    ./traits/zsh.nix
    ./traits/nvidia.nix
    ./traits/flakes.nix
    (import "${home-manager}/nixos")
  ];

  home-manager.users.jessew = import ./traits/jessew/home-manager.nix;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ca-nix-s01"; # Define your hostname.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  services.logrotate = { enable = true; };

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    lynis
    magic-wormhole
    chkrootkit
    gocryptfs
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 80 443 8008 12486 ];
  networking.firewall.allowedUDPPorts = [ 22 443 8008 12486 ];
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  boot.loader.grub.devices = [ "/dev/sda" ];

  # Initial empty root password for easy login:
  # services.openssh.permitRootLogin = "prohibit-password";
}
