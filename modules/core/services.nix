{ pkgs, ... }:
{
  services = {
    gvfs.enable = true;
    gnome = {
      tinysparql.enable = true;
      gnome-keyring.enable = true;
    };
    dbus.enable = true;
    fstrim.enable = true;

    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = with pkgs; [
      gcr
      gnome-settings-daemon
    ];
  };
  services.logind.settings.Login = {

    # don’t shutdown when power button is short-pressed


    HandlePowerKey = "ignore";


  };

  # services.syncthing = {
  #   enable = true;
  #   openDefaultPorts = true;
  #   extraFlags = [ "--no-default-folder" ];
  #   settings = {
  #     # Optional: GUI credentials (can be set in the browser instead)
  #     # settings.gui = {
  #     #   user = "myuser";
  #     #   password = "mypassword";
  #     # };
  #     devices = {
  #       "raspberrypi" = {
  #         id = "2IXC2MO-OX242ZJ-BR67J65-7PFGAE2-6GAXEYV-LYJOLHS-2WG3QYR-5GUC5AD";
  #       };
  #     };
  #     documents = {
  #       path = "/home/w3max/Documents/obsidian/w3max-obsidian";
  #       devices = [ "raspberrypi" ];
  #     };
  #   };
  # };
}
