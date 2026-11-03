#!/bin/bash

# 1. D-Bus को सीधे बैकग्राउंड में चलाना (बिना 'service' कमांड के)
dbus-daemon --system --fork

# 2. PulseAudio को शुरू करना (अगर इंस्टॉल है)
pulseaudio --start --system --disallow-exit --disable-shm || true

# 3. XRDP और Sesman को सीधे बाइनरी से शुरू करना
xrdp-sesman
xrdp

# 4. X11 socket directory permissions सही करना
mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

# 5. Pinggy का TCP टनल बैकग्राउंड में चलाना (सुनिश्चित करें कि openssh-client इंस्टॉल हो)
echo "Starting Pinggy TCP tunnel for RDP..."
ssh -o StrictHostKeyChecking=no -p 443 -R 0:localhost:3389 a.pinggy.io &

# 6. लॉग फाइल बनाना और उसे ट्रैक करना
mkdir -p /var/log
touch /var/log/xrdp-sesman.log
tail -f /var/log/xrdp-sesman.log
