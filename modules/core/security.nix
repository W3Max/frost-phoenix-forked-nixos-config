{ ... }:
{
  security.rtkit.enable = true;
  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = [ "w3max" ];
        commands = [
          {
            command = "/etc/profiles/per-user/w3max/bin/deno";
            options = [
              "NOPASSWD"
              "SETENV"
            ];
          }
          {
            command = "/etc/profiles/per-user/w3max/bin/expect";
            options = [
              "NOPASSWD"
              "SETENV"
            ];
          }
        ];
      }
    ];
  };
  security.pam.services.swaylock = { };
  security.pam.services.hyprlock = { };
}
