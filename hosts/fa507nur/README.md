# Installation Reference

## 1. Network
nmtui
ping google.com

## 2. Clone Config
sudo -i
git clone https://github.com/dvdyo/my-nixos.git /tmp/my-nixos
cd /tmp/my-nixos

## 3. Wipe & Partition (Disko)
nix run github:nix-community/disko -- --mode destroy,format,mount ./hosts/fa507nur/disko.nix

## 4. Hardware Check
nixos-generate-config --root /mnt --show-hardware-config > /tmp/hw.nix
diff /tmp/hw.nix ./hosts/fa507nur/hardware.nix

## 5. Copy Config
mkdir -p /mnt/etc/nixos
cp -r . /mnt/etc/nixos/

## 6. Install
nixos-install --flake /mnt/etc/nixos#fa507nur

## 7. Reboot
reboot
