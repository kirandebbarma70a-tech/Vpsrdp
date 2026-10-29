#!/bin/bash

# 1. Dbus और PulseAudio को शुरू करना
service dbus start
pulseaudio --start --system --disallow-exit --disable-shm

# 2. XRDP सर्विस को शुरू करना
service xrdp start

# 3. X11 socket directory permissions सही करना
mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

# 4. Pinggy का TCP टनल बैकग्राउंड में चलाना ताकि RDP पोर्ट (3389) बाहर मिल जाए
echo "Starting Pinggy TCP tunnel for RDP..."
ssh -o StrictHostKeyChecking=no -p 443 -R 0:localhost:3389 a.pinggy.io &

# 5. XRDP के लॉग्स देखने के साथ-साथ कंटेनर को जिंदा रखने के लिए
tail -f /var/log/xrdp-sesman.log
