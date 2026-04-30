# Laptop Suspend Fix

Fast recovery notes for this laptop's s2idle suspend.

## 1. Enable NVIDIA suspend/S0ix

```sh
run0 tee /etc/modprobe.d/nvidia-s0ix.conf >/dev/null <<'EOF'
# Enable NVIDIA S0ix handling for s2idle suspend/resume on this laptop.
options nvidia NVreg_EnableS0ixPowerManagement=1
EOF

run0 tee /etc/modprobe.d/nvidia.conf >/dev/null <<'EOF'
options nvidia NVreg_PreserveVideoMemoryAllocations=1
EOF

run0 mkinitcpio -P
```

## 2. Keep user sessions frozen during suspend

```sh
run0 mkdir -p /etc/systemd/system/systemd-suspend.service.d
run0 tee /etc/systemd/system/systemd-suspend.service.d/90-freeze-user-sessions.conf >/dev/null <<'EOF'
[Service]
Environment="SYSTEMD_SLEEP_FREEZE_USER_SESSIONS=true"
EOF
```

## 3. Ignore the bad AMD GPIO wake

Add this to `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub`:

```text
gpiolib_acpi.ignore_interrupt=AMDI0030:00@4
```

Then rebuild GRUB:

```sh
run0 grub-mkconfig -o /boot/grub/grub.cfg
```

## 4. Lid close should suspend

Set this in `/etc/systemd/logind.conf`:

```text
HandleLidSwitch=suspend
```

Apply without reboot:

```sh
run0 systemctl restart systemd-logind.service
```

## 5. Reboot and verify

```sh
reboot
cat /proc/cmdline | grep 'gpiolib_acpi.ignore_interrupt=AMDI0030:00@4'
cat /proc/driver/nvidia/params | grep EnableS0ixPowerManagement
systemctl suspend
```

Expected: laptop sleeps, does not auto-wake after ~30 seconds, and wakes from keyboard/power button.
