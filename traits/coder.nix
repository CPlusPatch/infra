{ config, pkgs, ... }: {
  services.coder = {
    enable = true;
    listenAddress = "127.0.0.1:29643";
    accessUrl = "https://code.cpluspatch.dev";
  };
}
