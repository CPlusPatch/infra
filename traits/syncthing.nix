{ config, pkgs, ... }:

let
  correctDevices = devices:
    builtins.filter (device: device != builtins.currentSystem) devices;
in {
  services.syncthing = {
    enable = true;
    user = "jessew";
    dataDir = "/home/jessew/";
    configDir = "/home/jessew/.config/syncthing";
    settings = {
      devices = {
        "android" = {
          id =
            "QSV7TN2-V76QYSW-WRLCJBC-TU3M7YW-AB7GX2X-A2J2WB4-QS7MNB3-7USW5QR";
        };
        "chunky" = {
          id =
            "KSYDUOJ-355KWNH-TGWG36C-5Y7DFCE-NRHZBKK-6EP73XL-5KYYXPH-PRVAUAH";
        };
        "hacktop" = {
          id =
            "6JHVZ6R-6WHCIQU-UOVJJVU-SHFVIXP-A77HYGU-JHIXMEA-U642UP4-BVNMVAI";
        };
      };
      folders = {
        "Cloud" = {
          path = "/home/jessew/Cloud";
          devices = correctDevices [ "android" "chunky" "hacktop" ];
        };
      };
    };
  };
}
