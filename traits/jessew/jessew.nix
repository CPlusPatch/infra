{ config, pkgs, ... }: {
  users.users.jessew = {
    isNormalUser = true;
    description = "Jesse Wierzbinski";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "sudo" ];
    packages = with pkgs; [ ];
  };
}
