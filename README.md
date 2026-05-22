# legnode-os

Alpine Linux configuration for the ungulate leg node.

**Hardware:** HP Compaq nx6110 — Pentium M i686, Intel 915GM, HDA audio  
**Base OS:** Alpine Linux 3.23 Extended i386  
**Purpose:** mishmaath schema boots as the primary decision layer

## Boot sequence

```
POST → Alpine → OpenRC → udev → mishmaath (pulseaudio + schema)
                              → X11 → openbox → netsurf @ localhost:8765
```

Schema is live before X11. The browser is just the window into it.

## Fresh install

```sh
git clone https://github.com/ajax80/legnode-os
cd legnode-os
sudo sh setup.sh
```

## Dashboard

`http://localhost:8765` — schema weights, audio features, Eleanor, yield, history

## Phase 2 (future)

- Native i686 binary via Nuitka (no Python)
- Custom kernel: only nx6110 drivers, PREEMPT_RT
- ALSA direct capture (remove PulseAudio)
- GPIO/I2C/SPI for leg hardware
- mishmaath ISA: opcodes → hardware registers
