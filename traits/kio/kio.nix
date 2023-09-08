{ config, pkgs, ... }: {
  users.users.kio = {
    isNormalUser = true;
    description = "Kio";
    extraGroups = [ "wheel" "sudo" ];
    packages = with pkgs; [ ];
  };
}
