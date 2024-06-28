{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.podsync;
  tomlFormat = pkgs.formats.toml { };
  configFile = tomlFormat.generate "podsync.toml" cfg.config;
  command = "${cfg.package}/bin/podsync --debug -c <(cat ${configFile} ${cfg.tokenFile})";

in {
  meta.maintainers = [ maintainers.phil ];

  options.services.podsync = {

    enable = mkEnableOption "enable podsync";

    package = mkOption {
      type = types.package;
      default = pkgs.podsync;
      defaultText = literalExpression "pkgs.podsync";
      description = "The podsync package to use";
    };

    config = mkOption {
      type = tomlFormat.type;
      description =
        "Podsync configuration. See https://github.com/mxpv/podsync#configuration for more information.";
      default = { };
    };

    tokenFile = mkOption {
      type = types.str;
      default = "";
      description = "Path (as string) to a file containing the [tokens] section of the configuration";
    };
  };

  config = mkIf cfg.enable {

    users = {
      users.podsync = {
        isSystemUser = true;
        group = "podsync";
      };
      groups.podsync = { };
    };

    systemd.services.podsync = {
      path = with pkgs; [
        (writeShellScriptBin "youtube-dl" "exec -a $0 ${yt-dlp}/bin/yt-dlp $@") # workaround, youtube-dl fails if used
        ffmpeg
      ];
      serviceConfig = {
          ExecStart = "${pkgs.bash}/bin/bash -c '${command}'";
          User = "podsync";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
