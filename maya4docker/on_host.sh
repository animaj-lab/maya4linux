#!/usr/bin/env bash
set -euo pipefail

# Set up X11 permissions for the Docker container to access the display
xhost +local:docker

# Create the adskidmgr:// protocol handler script
mkdir -p "$HOME/.local/bin"
cat > "$HOME/.local/bin/adskidmgr-handler" << 'EOF'
#!/usr/bin/env bash
docker exec -u user maya /opt/Autodesk/AdskIdentityManager/Current/AdskIdentityManager "$1"
EOF
chmod +x "$HOME/.local/bin/adskidmgr-handler"

# Register the adskidmgr:// URL scheme with the desktop environment
mkdir -p "$HOME/.local/share/applications"
cat > "$HOME/.local/share/applications/adskidmgr-handler.desktop" << EOF
[Desktop Entry]
Type=Application
Name=Autodesk Identity Manager
Exec=$HOME/.local/bin/adskidmgr-handler %u
MimeType=x-scheme-handler/adskidmgr;
NoDisplay=true
Terminal=false
EOF

# Update the MIME database to recognize the new protocol handler
xdg-mime default adskidmgr-handler.desktop x-scheme-handler/adskidmgr
update-desktop-database "$HOME/.local/share/applications"
