# KOOMPI Hyprland

KOOMPI's Hyprland desktop, based on [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland) (illogical-impulse) + quickshell.

## Install

One line, on a fresh machine:

```sh
bash <(curl -fsSL https://raw.githubusercontent.com/rithythul/koompi-hyprland/main/bootstrap.sh)
```

> Use the `bash <(...)` form, **not** `curl ... | bash`. The setup is interactive
> (it confirms each step and can enroll a fingerprint), so it needs a real terminal.

This installs `git` if missing, clones the repo to `~/koompi-hyprland` (with
submodules), and runs `./setup install`.

Already cloned? Just run:

```sh
./setup install
```

## Fingerprint login (optional)

During setup, if a supported fingerprint reader is detected you'll be asked
whether to enroll a finger. It's entirely opt-in:

- Choose **no** and nothing changes — enroll later with `./setup install-setups`.
- Choose **yes** and your finger unlocks the **lock screen**, **SDDM login**, and **sudo**.

Your password always keeps working as a fallback. Enrolled fingerprints are
stored locally in `/var/lib/fprint` and are **never** part of this repo.

On non-Arch distros the lock screen works after enrollment alone; enabling it
for login/sudo needs a PAM tweak (Fedora: `sudo authselect enable-feature with-fingerprint`).

## Subcommands

```
./setup install        (Re)install / update everything
./setup install-deps   Dependencies only
./setup install-setups Permissions / services / fingerprint only
./setup install-files  Copy config files only
./setup uninstall      Remove
./setup help           Full help
```
