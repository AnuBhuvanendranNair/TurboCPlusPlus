#!/bin/sh
# Installs the Px437 IBM VGA 8x16 font for the current macOS user.
# Usage: ./install.sh            install font
#        ./install.sh --uninstall remove font
set -e

FONT="Px437_IBM_VGA_8x16.ttf"
SRC="$(cd "$(dirname "$0")" && pwd)/fonts/$FONT"
DEST="$HOME/Library/Fonts/$FONT"

if [ "$(uname)" != "Darwin" ]; then
  echo "This script supports macOS only. Install fonts/$FONT manually." >&2
  exit 1
fi

if [ "$1" = "--uninstall" ]; then
  if [ -f "$DEST" ]; then
    rm "$DEST"
    echo "Removed $DEST"
  else
    echo "Font not installed, nothing to remove."
  fi
  exit 0
fi

if [ ! -f "$SRC" ]; then
  echo "Font file not found: $SRC" >&2
  exit 1
fi

if [ -f "$DEST" ]; then
  echo "Font already installed: $DEST"
else
  mkdir -p "$HOME/Library/Fonts"
  cp "$SRC" "$DEST"
  echo "Installed $DEST"
fi

echo ""
echo "Next steps:"
echo "  1. PhpStorm: Settings > Plugins > gear icon > Install Plugin from Disk > TurboCPlusPlus-1.0.3.jar"
echo "  2. Restart PhpStorm"
echo "  3. Settings > Appearance > Theme > TurboCPlusPlus"
echo "  4. Optional: Settings > Editor > Font > Px437 IBM VGA 8x16, size 16"
