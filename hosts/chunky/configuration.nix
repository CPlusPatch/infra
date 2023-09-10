{ config, pkgs, stdenv, lib, ... }:

let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  nixpkgs-coder = builtins.fetchTarball
    "https://github.com/chrisportela/nixpkgs/archive/refs/heads/chrisportela/coder-v2.0.2.tar.gz";
  overlay = final: prev: {
    # Inherit the changes into the overlay
    inherit (nixpkgs-coder.legacyPackages.${prev.system}) coder;
  };
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
    ./traits/nvidia.nix
    (import "${home-manager}/nixos")
  ];

  zramSwap = { enable = true; };

  nixpkgs.config.packageOverrides = pkgs: {
    llama-cpp = (builtins.getFlake
      "github:ggerganov/llama.cpp").packages.${builtins.currentSystem}.opencl;
  };

  nixpkgs.overlays = [ overlay ];

  services.coder = {
    enable = true;
    listenAddress = "127.0.0.1:29643";
    accessUrl = "https://code.cpluspatch.dev";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  home-manager.users.jessew = import ./traits/jessew/home-manager.nix;

  # Setup keyfile
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

  environment.etc.crypttab = {
    enable = true;
    text = ''
      luks-9a631cb6-d42e-4bd5-a6bc-42ef727a71ca UUID=9a631cb6-d42e-4bd5-a6bc-42ef727a71ca /hdd2_keyfile.key luks
    '';
  };

  fileSystems."/run/media/jessew/HDD2" = {
    device = "/dev/mapper/luks-9a631cb6-d42e-4bd5-a6bc-42ef727a71ca";
    fsType = "btrfs";
  };

  hardware.bluetooth.enable = true;

  programs.adb.enable = true;

  networking.hostName = "chunky"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "be";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "be-latin1";

  # Enable Flatpak
  services.flatpak.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jessew = {
    packages = with pkgs; [
      kate
      libreoffice-qt
      steam
      spicetify-cli
      vlc
      mpv
      nodejs_18
      nodePackages_latest.pnpm
      wineWowPackages.staging
      winetricks
      wineWowPackages.waylandFull

    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxa56rZeF6NxqNHNs4LUxoblPbhdXrbt41TLdy84KwaHAwGlMDivQgrAPDwyPFTz9bRauCefwusb01dMqKADCwGCY1YDWtCFShZENRvxGyss7jLo4ppWF1nqqyVDMgH25wBjMl2FfaaqQ9rWx8yDQbNty8r9WLj5Yq4ZNp///CvM2lWsZ/FVdfXspQ6GoWzLCSX0fu3bNXAiHyQBBDQECiWPvZOl2zMxrPu44FQHrX2fp+97qWrO+6Gxm7sGkEJNgxYVJZnY2VXbJ4kypoW0MBAjpwYHHT+uecz61+zKfdYB2KU9R+GXtpPOxei8JtNxT+5XZEV2KjEchRzQfJ5eP8afSB0O+oRluIuSmjaWwD7078whytFoLqZtrUlyoc1ADvhRf+7TddulH5zyLjIzPJ70Pu++rW85pKl6p9tp2IAy6bHfd9udnwe6zB+3W78XNnTYN8bPKXPcsQXTlOO76cEDo+o3Qp+LoSmvKI5e2uvnnIm9teTIfvAnoITfADPbk= jessew@nu-nix-s01"
    ];
  };

  virtualisation.docker.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    syncplay
    btop
    waypipe
    vscode-fhs
    autoconf
    binutils
    git # The program instantly crashes if git is not present, even if everything is already downloaded
    gitRepo
    glib
    gnumake
    gnupg
    gperf
    libGL
    libGLU
    m4
    ncurses5
    pkg-config
    procps
    python310
    util-linux
    virtualenv
    cudaPackages_12_2.cudatoolkit
    #llama-cpp
  ];

  services.cloudflared = {
    enable = true;
    tunnels = {
      "0c3f6e66-5afb-4859-91a1-51d4d2a41aac" = {
        credentialsFile =
          "/nix/store/wyzscaww97ycdvkwwxvvhdbjfckr38xm-0c3f6e66-5afb-4859-91a1-51d4d2a41aac.json";
        originRequest.noTLSVerify = false;
        ingress = {
          "jf.cpluspatch.com" = "http://localhost:56863";
          "sonarr.cpluspatch.com" = "http://localhost:48538";
          "radarr.cpluspatch.com" = "http://localhost:48539";
          "jackett.cpluspatch.com" = "http://localhost:37984";
          "prowlarr.cpluspatch.com" = "http://localhost:61983";
          "code.cpluspatch.dev" = "http://localhost:29643";
        };
        default = "http_status:404";
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    9354
    9993
    22
    3000
    7860
    2864
    2865
    2866
    2867
    2868
    2869
    2870
    2871
    2872
    2873
    2874
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
