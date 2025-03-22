# Troubleshooting & Issues

## Nix errors

Nix errors can be tricky to diagnose, but the following information is required when creating an issue, please provide as much as possible.

> [!TIP]
> rerun the command with `-v` to get more verbose output.
> you can also rerun the command with `--show-trace` to get a more detailed traceback.
> If the nix error is not clear, often the correct error message is somewhere in the *middle* of the error message.

## System errors & bugs

The following information is required when creating an issue, please provide as much as possible.
It's also possible to diagnose issues yourself with the information below.

1. **System Logs**
  
   ```bash
   journalctl -b                                          # System logs
   sudo systemctl status home-manager-$HOSTNAME.service   # Home-manager status
   ```

2. **System Information**

   ```bash
   nix-shell -p nix-info --run "nix-info -m"
   ```

3. **Configuration**
   - Must have a github repo with your templated flake

> [!NOTE]
> Custom modules and configurations have limited support.
