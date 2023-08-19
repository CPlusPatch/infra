{ config, pkgs, ... }: {
  users.users.jessew = {
    isNormalUser = true;
    description = "Jesse Wierzbinski";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
  };
}
