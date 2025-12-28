# Android Lab Template (NixOS)

Based on: https://devctrl.blog/posts/how-to-run-android-mobile-tv-emulator-on-nix-os-without-android-studio/

## 1. Initialize
```bash
# Copy template
mkdir -p ~/my-android-project && cp -r . ~/my-android-project
cd ~/my-android-project

# Setup Direnv (Optional but recommended)
echo "use flake" > .envrc
direnv allow

# OR manual enter
nix develop
```

## 2. Create Device
```bash
avdmanager create avd -n phone -k "system-images;android-36;google_apis;x86_64"
```
*Note: If keyboard doesn't work, set `hw.keyboard = yes` in `~/.android/avd/phone.avd/config.ini`.*

## 3. Run Emulator
```bash
emulator -avd phone -skin 720x1280 -noaudio -no-snapshot-load -no-snapshot
```
