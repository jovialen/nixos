{pkgs, ...}: {
  users.users.loki = {
    isNormalUser = true;
    description = "loki";
    initialPassword = "loki";
    extraGroups = ["networkmanager" "wheel"];
  };
}
