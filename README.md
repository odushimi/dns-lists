
# Pi-hole DNS Lists

This repository contains curated lists of domains to allow or block for use with [Pi-hole](https://pi-hole.net/), focusing on smart home devices, telemetry, ads, and privacy.

## Files

- **allowed.txt**: Domains and regex patterns to whitelist (allow) for device functionality and critical services.
- **blocked.txt**: Domains and regex patterns to blacklist (block) for telemetry, ads, tracking, and unwanted connections.
- **smart_pihole.sh**: Bash script to automate adding these lists to your Pi-hole instance.

## Usage

1. **Review the lists**: Check `allowed.txt` and `blocked.txt` to ensure they fit your network and device needs.
2. **Import to Pi-hole**:
	- You can manually add domains from these files to Pi-hole's Blacklist and Whitelist via the web interface.
	- Or, use the `smart_pihole.sh` script to automate the process (requires Pi-hole CLI access).
3. **Regex Filters**: Some entries are regex patterns. Add these as "Regex Filters" in Pi-hole for broader blocking/allowing.

## Example: Running the Script

```bash
chmod +x smart_pihole.sh
./smart_pihole.sh
```

> **Note:** The script is designed for Linux environments where Pi-hole is installed and accessible via CLI.

## Customization

- Edit `allowed.txt` and `blocked.txt` to add or remove domains as needed for your environment.
- Always test changes to avoid breaking device functionality.

## References

- [Pi-hole Documentation](https://docs.pi-hole.net/)
- [Regex Filters in Pi-hole](https://docs.pi-hole.net/regex/)

