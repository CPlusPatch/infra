{ config, pkgs, ... }: {
  security.apparmor.enable = mkDefault true;
  security.apparmor.killUnconfinedConfinables = mkDefault true;
}
