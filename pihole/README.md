# Pihole setup

This setup runs Pihole in a Docker container with a custom network and persistent storage.
Pihole is configured to run as a service in `../nix/pihole-service.nix`

## Installation

1. Run the following command
   ```bash
   pihole/docker/scripts/setup.sh
   ```

2. This will create the links in /etc/pihole and /opt/pihole.

3. Check /etc/pihole/environment and set the variables as needed.
   See: pihole/docker/scripts/start.sh for more details around the variables.
