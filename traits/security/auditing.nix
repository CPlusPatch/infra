{ config, pkgs, ... }: {
  security.auditd.enable = true;
  services.sysstat.enable = true;
}
