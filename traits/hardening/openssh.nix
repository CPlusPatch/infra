{ config, pkgs, ... }: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
    extraConfig = ''
      AllowTcpForwarding yes
      X11Forwarding no
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
    banner = ''
      +-------------------------------------------------------------------------------------+
      |                                                                                     |
      |  *** WARNING: UNAUTHORIZED ACCESS TO THIS SYSTEM IS PROHIBITED ***                  |
      |                                                                                     |
      |  This system is the property of Gaspard Wierzbinski. It is for authorized users     |
      |  only. Users (authorized or unauthorized) have no explicit or implicit expectation  |
      |  of privacy.                                                                        |
      |                                                                                     |
      |  Any or all uses of this system and all files on this system may be intercepted,    |
      |  monitored, recorded, copied, audited, inspected, and disclosed to authorized       |
      |  personnel, including law enforcement.                                              |
      |                                                                                     |
      |  Unauthorized access or use of this system may result in disciplinary action,       |
      |  civil or criminal penalties, and/or other legal consequences.                      |
      |                                                                                     |
      |  By continuing to use this system, you indicate your awareness of and consent to    |
      |  these terms and conditions of use.                                                 |
      |                                                                                     |
      |  This warning contains legal terms such as "prohibited," "property," "authorized    |
      |  use," "expectation of privacy," "intercepted," "monitored," "audited," "civil or   |
      |  criminal penalties," and "terms and conditions of use." It is intended to inform   |
      |  users that unauthorized access to the system is not permitted and may result in    |
      |  legal consequences.                                                                |
      |                                                                                     |
      +-------------------------------------------------------------------------------------+
    '';
  };
}
