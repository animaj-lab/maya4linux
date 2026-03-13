#!/bin/bash
# Send an "OpenURI" request to the host's desktop portal via DBus
gdbus call --session \
    --dest org.freedesktop.portal.Desktop \
    --object-path /org/freedesktop/portal/desktop \
    --method org.freedesktop.portal.OpenURI.OpenURI \
    "" "$1" "{}"