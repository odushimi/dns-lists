#!/bin/bash

# --- PI-HOLE SMART CONFIGURATOR ---
# Combined lists for: Smart Home, Social, Google, Microsoft, Mobile, Smart TVs, and OS Telemetry.

echo "Starting Pi-hole Configuration..."
echo "Note: This script adds domains to your Blacklist and Whitelist."

# ==========================================
# 1. EXACT BLACKLIST (Specific Trackers)
# ==========================================
echo "Adding Exact Blacklist Domains..."

# Smart Home Telemetry
pihole deny msmetrics.ws.sonos.com jishi.sonos.com update-software.sonos.com # Sonos
pihole deny device-metrics-us.amazon.com device-metrics-us-2.amazon.com cal-video.amazon.com vsp-alexa-na.amazon.com vsp-alexa-eu.amazon.com # Alexa
pihole deny experiment-runner.ecobee.com payload.ecobee.com t.ecobee.com # Ecobee
pihole deny metrics.irobot.com axeda.com imgs.irobot.com # Roomba
pihole deny api.mixpanel.com # IoT General

# Google Explicit Ads & Tracking
pihole deny googleadservices.com www.googleadservices.com google-analytics.com ssl.google-analytics.com
pihole deny googletagservices.com googletagmanager.com ad.doubleclick.net googleads.g.doubleclick.net
pihole deny stats.g.doubleclick.net pagead2.googlesyndication.com tpc.googlesyndication.com ddm.google.com 2mdn.net

# Smart TV & Streaming Spies
pihole deny samsungacr.com config.samsungads.com gpm.samsungqbe.com log-config.samsungacr.com samsungcloudsolution.com # Samsung
pihole deny lgad.cjpowercast.com edgesuite.net smartshare.lgtvsdp.com us.info.lgsmartad.com # LG
pihole deny cooper.logs.roku.com giga.logs.roku.com track.sr.roku.com scribe.logs.roku.com # Roku

# Mobile & OS Telemetry
pihole deny app-measurement.com firebase-settings.crashlytics.com reports.crashlytics.com mobile-service.adjust.com # Mobile
pihole deny ads.unity3d.com gameads-admin.x.unity3d.com config.unityads.unity3d.com appsflyer.com branch.io # Games
pihole deny v10.events.data.microsoft.com v20.events.data.microsoft.com watson.telemetry.microsoft.com telemetry.microsoft.com # Windows
pihole deny iad-content.apple.com iad.apple.com metrics.icloud.com securemetrics.apple.com # Apple Ads

# ==========================================
# 2. REGEX BLACKLIST (Catch-all Blockers)
# ==========================================
echo "Adding Regex Blacklist Filters..."

# DNS Rebind Protection (HaGeZi)
# Blocks domains resolving to private/internal IPs to prevent DNS rebinding attacks
pihole regex "^10\.(?:\d{1,3})\.(?:\d{1,3})\.(?:\d{1,3})$"                    # IPv4 Private 10.x
pihole regex "^172\.(?:1[6-9]|2\d|3[0-1])\.(?:\d{1,3})\.(?:\d{1,3})$"         # IPv4 Private 172.16-31.x
pihole regex "^192\.168\.(?:\d{1,3})\.(?:\d{1,3})$"                           # IPv4 Private 192.168.x
pihole regex "^169\.254\.(?:\d{1,3})\.(?:\d{1,3})$"                           # IPv4 Link-Local
pihole regex "^127\.(?:\d{1,3})\.(?:\d{1,3})\.(?:\d{1,3})$"                   # IPv4 Loopback
pihole regex "^0\.0\.0\.(?:\d{1,3})$"                                         # IPv4 Unspecified
pihole regex "^f[cd][0-9a-f]{2}:"                                             # IPv6 ULA
pihole regex "^fe80:"                                                         # IPv6 Link-Local
pihole regex "^::1$"                                                          # IPv6 Loopback
pihole regex "^::$"                                                           # IPv6 Unspecified
pihole regex "^([a-z0-9\-]+\.)?(localhost|localdomain|ip6-localhost)$"        # Local Hostnames

pihole regex "^device-metrics.*\.amazon\.com$"   # Amazon Catch-all
pihole regex "^metrics\.irobot\.com$"            # Roomba Catch-all
pihole regex "(\.|^)googleadservices\.com$"      # Google Ads
pihole regex "(\.|^)doubleclick\.net$"           # Doubleclick
pihole regex "(\.|^)googlesyndication\.com$"     # AdSense
pihole regex "(\.|^)google-analytics\.com$"      # GA
pihole regex "^cdn\.consensu\.org$"              # Cookie Banners
pihole regex "^cmp\.quantcast\.com$"             # Cookie Banners

# ==========================================
# 3. EXACT WHITELIST (Functionality Savers)
# ==========================================
echo "Adding Exact Whitelist Domains..."

# Smart Home Keep-Alive
pihole allow sonos.com optimizely.com # Sonos
pihole allow api.amazon.com alexa.amazon.com softwareupdates.amazon.com # Alexa
pihole allow prod.immedia-semi.com rest-prod.immedia-semi.com rest-u001.immedia-semi.com # Blink Cameras
pihole allow api.ecobee.com disconnect.ecobee.com # Ecobee
pihole allow irobot.axeda.com irobot-homes-prod.s3.amazonaws.com # Roomba

# Microsoft & Social Specifics
pihole allow trafficmanager.net connect.facebook.net mmg.whatsapp.net pps.whatsapp.net

# Apple Critical (Fixes Slow WiFi/Updates)
pihole allow ocsp.apple.com ocsp2.apple.com mesu.apple.com gdmf.apple.com xp.apple.com

# ==========================================
# 4. REGEX WHITELIST (The Big Ecosystems)
# ==========================================
echo "Adding Regex Whitelist Filters (This enables Social/MS/Google services)..."

# Social Media
pihole --allow-regex "(\.|^)facebook\.com$"
pihole --allow-regex "(\.|^)facebook\.net$"
pihole --allow-regex "(\.|^)fbcdn\.net$"
pihole --allow-regex "(\.|^)fbsbx\.com$"
pihole --allow-regex "(\.|^)messenger\.com$"
pihole --allow-regex "(\.|^)whatsapp\.com$"
pihole --allow-regex "(\.|^)whatsapp\.net$"
pihole --allow-regex "(\.|^)twitter\.com$"
pihole --allow-regex "(\.|^)twimg\.com$"
pihole --allow-regex "(\.|^)t\.co$"
pihole --allow-regex "(\.|^)x\.com$"
pihole --allow-regex "(\.|^)linkedin\.com$"
pihole --allow-regex "(\.|^)licdn\.com$"
pihole --allow-regex "(\.|^)reddit\.com$"
pihole --allow-regex "(\.|^)redditmedia\.com$"
pihole --allow-regex "(\.|^)redd\.it$"

# Microsoft Teams / Office
pihole --allow-regex "(\.|^)microsoft\.com$"
pihole --allow-regex "(\.|^)microsoftonline\.com$"
pihole --allow-regex "(\.|^)live\.com$"
pihole --allow-regex "(\.|^)msauth\.net$"
pihole --allow-regex "(\.|^)office\.com$"
pihole --allow-regex "(\.|^)office365\.com$"
pihole --allow-regex "(\.|^)office\.net$"
pihole --allow-regex "(\.|^)outlook\.com$"
pihole --allow-regex "(\.|^)outlook\.office365\.com$"
pihole --allow-regex "(\.|^)teams\.microsoft\.com$"
pihole --allow-regex "(\.|^)skype\.com$"
pihole --allow-regex "(\.|^)skypeassets\.com$"
pihole --allow-regex "(\.|^)azureedge\.net$"
pihole --allow-regex "(\.|^)msecnd\.net$"
pihole --allow-regex "(\.|^)aspnetcdn\.com$"

# Google Minimalist (Services YES, Ads NO)
pihole --allow-regex "(\.|^)gstatic\.com$"
pihole --allow-regex "(\.|^)googleusercontent\.com$"
pihole --allow-regex "(\.|^)googleapis\.com$"
pihole --allow-regex "(\.|^)ggpht\.com$"
pihole --allow-regex "(\.|^)android\.com$"
pihole --allow-regex "(\.|^)gvt1\.com$"
pihole --allow-regex "(\.|^)xn--ngstr-lra8j\.com$"
pihole --allow-regex "(\.|^)youtube\.com$"
pihole --allow-regex "(\.|^)googlevideo\.com$"
pihole --allow-regex "(\.|^)ytimg\.com$"
# Specific Google Apps:
pihole --allow-regex "^(www|accounts|mail|drive|docs|sheets|slides|maps|calendar|keep|photos|translate|meet)\.google\.com$"

# ==========================================
# 5. CLEANUP
# ==========================================
echo "Updating Gravity to apply changes..."
pihole -g

echo "Restarting DNS Resolver..."
pihole restartdns

echo "Done! Your Smart/Privacy Pi-hole is ready."
