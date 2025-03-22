---
name: Bug Report
about: Create a report to help improve hydenix
title: '[BUG] '
labels: bug
assignees: ''
---

## Bug Description
<!-- A clear and concise description of the bug -->

## Steps to Reproduce
1. 
2. 
3. 

## System Information
<details>
<summary>System Details</summary>

```bash
# Please paste the output of:
nix-shell -p nix-info --run "nix-info -m"
```
</details>

<details>
<summary>System Logs</summary>

```bash
# Please paste relevant logs from:
journalctl -b                                           # System logs
sudo systemctl status home-manager-$HOSTNAME.service   # Home-manager status
```
</details>

## Environment

- [ ] Templated Flake - No changes made
- [ ] Custom Flake

## Link to your flake (Required for a Custom Flake)
<!-- Please provide a link to your custom templated flake -->

## Checklist

- [ ] I have read the FAQ
- [ ] I have checked for existing issues
- [ ] I have included all relevant system information
- [ ] I have included relevant logs
- [ ] I have provided my configuration