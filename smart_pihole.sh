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
pihole -b msmetrics.ws.sonos.com jishi.sonos.com update-software.sonos.com # Sonos
pihole -b device-metrics-us.amazon.com device-metrics-us-2.amazon.com cal-video.amazon.com vsp-alexa-na.amazon.com vsp-alexa-eu.amazon.com # Alexa
pihole -b experiment-runner.ecobee.com payload.ecobee.com t.ecobee.com # Ecobee
pihole -b metrics.irobot.com axeda.com imgs.irobot.com # Roomba
pihole -b api.mixpanel.com # IoT General

# Google Explicit Ads &amp; Tracking
pihole -b googleadservices.com www.googleadservices.com google-analytics.com ssl.google-analytics.com
pihole -b googletagservices.com googletagmanager.com ad.doubleclick.net googleads.g.doubleclick.net
pihole -b stats.g.doubleclick.net pagead2.googlesyndication.com tpc.googlesyndication.com ddm.google.com 2mdn.net

# Smart TV &amp; Streaming Spies
pihole -b samsungacr.com config.samsungads.com gpm.samsungqbe.com log-config.samsungacr.com samsungcloudsolution.com # Samsung
pihole -b lgad.cjpowercast.com edgesuite.net smartshare.lgtvsdp.com us.info.lgsmartad.com # LG
pihole -b cooper.logs.roku.com giga.logs.roku.com track.sr.roku.com scribe.logs.roku.com # Roku

# Mobile &amp; OS Telemetry
pihole -b app-measurement.com firebase-settings.crashlytics.com reports.crashlytics.com mobile-service.adjust.com # Mobile
pihole -b ads.unity3d.com gameads-admin.x.unity3d.com config.unityads.unity3d.com appsflyer.com branch.io # Games
pihole -b v10.events.data.microsoft.com v20.events.data.microsoft.com watson.telemetry.microsoft.com telemetry.microsoft.com # Windows
pihole -b iad-content.apple.com iad.apple.com metrics.icloud.com securemetrics.apple.com # Apple Ads

# ==========================================
# 2. REGEX BLACKLIST (Catch-all Blockers)
# ==========================================
echo "Adding Regex Blacklist Filters..."

pihole --regex "^device-metrics.*\.amazon\.com$"   # Amazon Catch-all
pihole --regex "^metrics\.irobot\.com$"            # Roomba Catch-all
pihole --regex "(\.|^)googleadservices\.com$"      # Google Ads
pihole --regex "(\.|^)doubleclick\.net$"           # Doubleclick
pihole --regex "(\.|^)googlesyndication\.com$"     # AdSense
pihole --regex "(\.|^)google-analytics\.com$"      # GA
pihole --regex "^cdn\.consensu\.org$"              # Cookie Banners
pihole --regex "^cmp\.quantcast\.com$"             # Cookie Banners

# ==========================================
# 3. EXACT WHITELIST (Functionality Savers)
# ==========================================
echo "Adding Exact Whitelist Domains..."

# Smart Home Keep-Alive
pihole -w sonos.com optimizely.com # Sonos
pihole -w api.amazon.com alexa.amazon.com softwareupdates.amazon.com # Alexa
pihole -w prod.immedia-semi.com rest-prod.immedia-semi.com rest-u001.immedia-semi.com # Blink Cameras
pihole -w api.ecobee.com disconnect.ecobee.com # Ecobee
pihole -w irobot.axeda.com irobot-homes-prod.s3.amazonaws.com # Roomba

# Microsoft &amp; Social Specifics
pihole -w trafficmanager.net connect.facebook.net mmg.whatsapp.net pps.whatsapp.net

# Apple Critical (Fixes Slow WiFi/Updates)
pihole -w ocsp.apple.com ocsp2.apple.com mesu.apple.com gdmf.apple.com xp.apple.com

# ==========================================
# 4. REGEX WHITELIST (The Big Ecosystems)
# ==========================================
echo "Adding Regex Whitelist Filters (This enables Social/MS/Google services)..."

# Social Media
pihole --white-regex "(\.|^)facebook\.com$"
pihole --white-regex "(\.|^)facebook\.net$"
pihole --white-regex "(\.|^)fbcdn\.net$"
pihole --white-regex "(\.|^)fbsbx\.com$"
pihole --white-regex "(\.|^)messenger\.com$"
pihole --white-regex "(\.|^)whatsapp\.com$"
pihole --white-regex "(\.|^)whatsapp\.net$"
pihole --white-regex "(\.|^)twitter\.com$"
pihole --white-regex "(\.|^)twimg\.com$"
pihole --white-regex "(\.|^)t\.co$"
pihole --white-regex "(\.|^)x\.com$"
pihole --white-regex "(\.|^)linkedin\.com$"
pihole --white-regex "(\.|^)licdn\.com$"
pihole --white-regex "(\.|^)reddit\.com$"
pihole --white-regex "(\.|^)redditmedia\.com$"
pihole --white-regex "(\.|^)redd\.it$"

# Microsoft Teams / Office
pihole --white-regex "(\.|^)microsoft\.com$"
pihole --white-regex "(\.|^)microsoftonline\.com$"
pihole --white-regex "(\.|^)live\.com$"
pihole --white-regex "(\.|^)msauth\.net$"
pihole --white-regex "(\.|^)office\.com$"
pihole --white-regex "(\.|^)office365\.com$"
pihole --white-regex "(\.|^)office\.net$"
pihole --white-regex "(\.|^)outlook\.com$"
pihole --white-regex "(\.|^)outlook\.office365\.com$"
pihole --white-regex "(\.|^)teams\.microsoft\.com$"
pihole --white-regex "(\.|^)skype\.com$"
pihole --white-regex "(\.|^)skypeassets\.com$"
pihole --white-regex "(\.|^)azureedge\.net$"
pihole --white-regex "(\.|^)msecnd\.net$"
pihole --white-regex "(\.|^)aspnetcdn\.com$"

# Google Minimalist (Services YES, Ads NO)
pihole --white-regex "(\.|^)gstatic\.com$"
pihole --white-regex "(\.|^)googleusercontent\.com$"
pihole --white-regex "(\.|^)googleapis\.com$"
pihole --white-regex "(\.|^)ggpht\.com$"
pihole --white-regex "(\.|^)android\.com$"
pihole --white-regex "(\.|^)gvt1\.com$"
pihole --white-regex "(\.|^)xn--ngstr-lra8j\.com$"
pihole --white-regex "(\.|^)youtube\.com$"
pihole --white-regex "(\.|^)googlevideo\.com$"
pihole --white-regex "(\.|^)ytimg\.com$"
# Specific Google Apps:
pihole --white-regex "^(www|accounts|mail|drive|docs|sheets|slides|maps|calendar|keep|photos|translate|meet)\.google\.com$"

# ==========================================
# 5. CLEANUP
# ==========================================
echo "Updating Gravity to apply changes..."
pihole -g

echo "Restarting DNS Resolver..."
pihole restartdns

echo "Done! Your Smart/Privacy Pi-hole is ready."
