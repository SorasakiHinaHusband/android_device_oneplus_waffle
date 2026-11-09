# OnePlus 12 (waffle) device tree

MikuUI device tree for the OnePlus 12 (codename `waffle`, models `CPH2573` / `OP595DL1`).

## Maintainer

- **SorasakiHinaHusband** — <https://github.com/SorasakiHinaHusband>

## Branch

- `Cinderella` — MikuUI (Android 17 / BP2A)

## Building

```bash
source build/envsetup.sh
lunch miku_waffle-user
mka miku
```

## Dependencies

| Path | Repository |
| --- | --- |
| `device/oneplus/sm8650-common` | `SorasakiHinaHusband/android_device_oneplus_sm8650-common` |
| `hardware/oplus` | `LineageOS/android_hardware_oplus` |
| `hardware/lineage/interfaces` | provided by the MikuUI manifest |
| `kernel/oneplus/sm8650` | `SorasakiHinaHusband/android_kernel_oneplus_sm8650` |
| `kernel/oneplus/sm8650-devicetrees` | `SorasakiHinaHusband/android_kernel_oneplus_sm8650-devicetrees` |
| `kernel/oneplus/sm8650-modules` | `SorasakiHinaHusband/android_kernel_oneplus_sm8650-modules` |
| `vendor/oneplus/waffle` | `SorasakiHinaHusband/proprietary_vendor_oneplus_waffle` |
| `vendor/oneplus/sm8650-common` | `SorasakiHinaHusband/proprietary_vendor_oneplus_sm8650-common` |

## Blobs

Proprietary files are listed in `proprietary-files.txt` and are extracted from
OxygenOS `11.F.58` (Android 16) with `extract-files.py`. The prebuilt `dtbo.img`
in `prebuilt/` is re-signed by the build system.

## Notes

- The alert slider is handled by `prebuilt/vendor/bin/alert-slider.sh`, which is
  copied to `/vendor/bin` and invoked from `init.target.rc` of the common tree.
- SMS handling expects the AOSP Messaging app with the privileged permissions
  whitelist in `prebuilt/etc/permissions/`.

## License

Licensed under the Apache License, Version 2.0, unless stated otherwise in the
individual source files. Copyright notices and SPDX tags are retained from the
original authors as required by the license.
