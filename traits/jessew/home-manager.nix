{ config, pkgs, ... }:

{
  home.username = "jessew";
  home.homeDirectory = "/home/jessew";
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      config = "sudo micro /etc/nixos/configuration.nix";
      dockerup = "sudo docker compose up -d";
      dockerdown = "sudo docker compose down";
      dockerlogs = "sudo docker compose logs -n 20";
      dockerlogsf = "sudo docker compose logs -n 20 -f";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/.zhistory";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        {
          name = "romkatv/powerlevel10k";
          tags = [ "as:theme" "depth:1" ];
        } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };

    initExtra = "source /home/jessew/.p10k.zsh";
  };

  programs.git = {
    enable = true;
    userName = "Jesse Wierzbinski";
    userEmail = "contact@cpluspatch.com";
    extraConfig = { pull.rebase = false; };
  };
}
