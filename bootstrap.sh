#!/usr/bin/env bash
# One-line installer for KOOMPI Hyprland.
#
#   bash <(curl -fsSL https://raw.githubusercontent.com/rithythul/koompi-hyprland/main/bootstrap.sh)
#
# Use the bash <(...) form, NOT `curl ... | bash`: the setup is interactive
# (it asks per step, and optionally to enroll a fingerprint), so it needs a
# real terminal on stdin. A pipe feeds the script on stdin and breaks prompts.
set -euo pipefail

REPO_URL="https://github.com/rithythul/koompi-hyprland.git"
DEST="${KOOMPI_HYPR_DIR:-$HOME/koompi-hyprland}"

if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
  echo "Don't run this as root. Run as your normal user — it will sudo when needed." >&2
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "git not found; installing it first..."
  if   command -v pacman >/dev/null 2>&1; then sudo pacman -S --needed --noconfirm git
  elif command -v dnf    >/dev/null 2>&1; then sudo dnf install -y git
  elif command -v apt    >/dev/null 2>&1; then sudo apt update && sudo apt install -y git
  elif command -v zypper >/dev/null 2>&1; then sudo zypper install -y git
  else echo "Please install git manually, then re-run this command." >&2; exit 1
  fi
fi

if [[ -d "$DEST/.git" ]]; then
  echo "Updating existing clone at $DEST ..."
  git -C "$DEST" pull --ff-only
  git -C "$DEST" submodule update --init --recursive
else
  echo "Cloning into $DEST ..."
  git clone --recurse-submodules "$REPO_URL" "$DEST"
fi

cd "$DEST"
exec ./setup install
