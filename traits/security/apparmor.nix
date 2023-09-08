{ config, pkgs, lib, ... }: {
  security.apparmor.enable = lib.mkDefault true;
  security.apparmor.killUnconfinedConfinables = lib.mkDefault true;
}
