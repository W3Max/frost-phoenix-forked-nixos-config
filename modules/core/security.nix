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
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
  security.pam.services.swaylock = { };
  security.pam.services.hyprlock = { };
}
