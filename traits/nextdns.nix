{ config, pkgs, ... }: {
  services.resolved = {
    enable = true;
    dnssec = "true";
    extraConfig = ''
      [Resolve]
      DNS=45.90.28.0#hacktop-7369cf.dns.nextdns.io
      DNS=2a07:a8c0::#hacktop-7369cf.dns.nextdns.io
      DNS=45.90.30.0#hacktop-7369cf.dns.nextdns.io
      DNS=2a07:a8c1::#hacktop-7369cf.dns.nextdns.io
      DNSOverTLS=yes
    '';
  };
}
