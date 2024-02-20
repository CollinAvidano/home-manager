{ config, pkgs, lib, ... }:

with lib;
with builtins;

let
  cfg = config.virtualisation.docker;
in {
    # does not configure docker params just adds useful aliases to the common shell stuff if docker hosting is enabled
    config.shell.aliases = mkIf cfg.enable {
        dlsi = "docker images";
        dlsc = "docker containers";
        dflush = "docker system prune";
    };

    config.shell.functions = mkIf cfg.enable ''
        # -t allocates a psuedo tty -i keps stdin open after the process exits
        # docker functions
        dockershellrun() {
            docker run -it $1 /bin/bash
        }

        dockershellexec() {
            docker exec -it $1 /bin/bash
        }

        # in case you didnt use --rm
        dockersr() {
            docker container stop $1 && docker container rm $1
        }
    '';
}