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
    ./traits/timezone-honolulu.nix
    ./traits/packages.nix
    ./traits/zerotier-a09acf0233609fc8.nix
    ./traits/zsh.nix
    ./traits/flakes.nix
    (import "${home-manager}/nixos")
  ];

  home-manager.users.jessew = import ./traits/jessew/home-manager.nix;

  systemd.services.backup = {
    wants = [ "network-online.target" ];
    description =
      "This unit will backup the Docker files to encrypted hard drives via SSH";
    script = ''
      ${pkgs.bash}/bin/bash /home/jessew/backup.sh
    '';
    path = [ pkgs.rsync pkgs.which pkgs.gocryptfs pkgs.fuse pkgs.openssh ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

  systemd.timers.backup = {
    wantedBy = [ "timers.target" ];
    description = "Timer for the backup service";
    timerConfig = {
      OnCalendar = [ "*-*-* 0:00:00" "*-*-* 12:00:00" ];
      Persistent = true;
    };
  };

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;

  networking.hostName = "nu-nix-s01"; # Define your hostname.
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
