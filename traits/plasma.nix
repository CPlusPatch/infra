{ config, pkgs, ... }: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";

  xdg.portal.enable = true;

  # Fix GTK themes on Wayland
  programs.dconf.enable = true;

  security.pam.services.sddm.enableKwallet = true;

  environment.systemPackages = with pkgs; [
    partition-manager
    qdirstat
    discover
    lightly-qt
    xdg-desktop-portal-kde
    libsForQt5.qt5.qtimageformats
    qt6.qtimageformats
    libsForQt5.ffmpegthumbs
    libsForQt5.kleopatra
    bluez
    libsForQt5.kalendar
    libsForQt5.kaddressbook
  ];

  programs.kdeconnect.enable = true;
}
