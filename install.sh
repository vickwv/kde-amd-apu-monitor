#!/bin/bash

# KDE AMD APU Monitor Widget Installation Script

WIDGET_NAME="plasma-cpu-monitor"
WIDGET_ID="org.kde.plasma.cpumonitor"

# Check if running in KDE environment
if [ "$XDG_CURRENT_DESKTOP" != "KDE" ]; then
    echo "Warning: This widget is designed for KDE Plasma desktop environment"
fi

# Get user's Plasma widget directory
PLASMA_DIR="$HOME/.local/share/plasma/plasmoids"

echo "=== Installing AMD APU Monitor Widget ==="
echo ""

# 1. Stop plasmashell
echo "[1/7] Stopping Plasma Shell..."
kquitapp6 plasmashell 2>/dev/null || kquitapp5 plasmashell 2>/dev/null || true
sleep 2

# 2. Clean all caches (ensure updates take effect)
echo "[2/7] Cleaning caches..."
rm -rf ~/.cache/plasma* 2>/dev/null
rm -rf ~/.cache/plasmashell* 2>/dev/null
rm -rf ~/.cache/qmlcache* 2>/dev/null
rm -rf ~/.cache/ksycoca* 2>/dev/null
rm -rf ~/.cache/QtProject* 2>/dev/null

# 3. Remove old version
echo "[3/7] Removing old version..."
rm -rf "$PLASMA_DIR/$WIDGET_ID"

# 4. Create directory
echo "[4/7] Creating directory..."
mkdir -p "$PLASMA_DIR"

# 5. Copy new version
echo "[5/7] Installing new version..."
if [ -d "$WIDGET_NAME" ]; then
    cp -r "$WIDGET_NAME" "$PLASMA_DIR/$WIDGET_ID"
    echo "✓ Widget files copied to: $PLASMA_DIR/$WIDGET_ID"
else
    echo "✗ Error: Cannot find $WIDGET_NAME directory"
    exit 1
fi

# 6. Verify installation
echo "[6/7] Verifying installation..."
if [ -f "$PLASMA_DIR/$WIDGET_ID/contents/ui/main.qml" ]; then
    echo "✓ main.qml file size: $(wc -c < "$PLASMA_DIR/$WIDGET_ID/contents/ui/main.qml") bytes"
    echo "✓ main.qml lines: $(wc -l < "$PLASMA_DIR/$WIDGET_ID/contents/ui/main.qml") lines"
else
    echo "✗ Error: main.qml file does not exist!"
    exit 1
fi

# 7. Restart plasmashell
echo "[7/7] Restarting Plasma Shell..."
kstart plasmashell 2>/dev/null || kstart5 plasmashell 2>/dev/null &

sleep 3

echo ""
echo "=== Installation Complete! ==="
echo ""
echo "Usage Tips:"
echo "• If the widget doesn't update, manually remove the old one and add it again"
echo "• Right-click panel → Add Widgets → Search for 'AMD APU Monitor'"
echo "• New layout: [CPU] [PWR] [MEM] [NET]"
echo ""
echo "To uninstall:"
echo "rm -rf \"$PLASMA_DIR/$WIDGET_ID\""