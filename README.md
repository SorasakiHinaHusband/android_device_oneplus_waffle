# 一加 12（waffle）设备树 🍜

诶嘿，这就是把 **MikuUI** 塞进一加 12 的那份「图纸」。
代号 `waffle`，型号 `CPH2573` / `OP595DL1`。刷机有风险，备份请趁早～

## 谁在管这棵树

**SorasakiHinaHusband** —— 也就是我。发现 bug 欢迎提 issue，但请温柔一点 🙏

## 分支

`Cinderella` —— 跟着 MikuUI（Android 17 / BP2A）一起摇摆。

## 怎么编

```bash
source build/envsetup.sh
lunch miku_waffle-cp2a-user
mka miku
```

编完的包躺在 `out/target/product/waffle/miku_waffle-ota.zip`。
编译前记得确认 `vendor/miku-priv/keys/` 里的签名密钥还在，不然签名环节会当场哭给你看。

## 都靠谁撑腰（依赖）

| 路径 | 仓库 |
| --- | --- |
| `device/oneplus/sm8650-common` | `SorasakiHinaHusband/android_device_oneplus_sm8650-common` |
| `hardware/oplus` | `LineageOS/android_hardware_oplus` |
| `hardware/lineage/interfaces` | MikuUI manifest 自带 |
| `kernel/oneplus/sm8650` | `SorasakiHinaHusband/android_kernel_oneplus_sm8650` |
| `kernel/oneplus/sm8650-devicetrees` | `SorasakiHinaHusband/android_kernel_oneplus_sm8650-devicetrees` |
| `kernel/oneplus/sm8650-modules` | `SorasakiHinaHusband/android_kernel_oneplus_sm8650-modules` |
| `vendor/oneplus/waffle` | `SorasakiHinaHusband/proprietary_vendor_oneplus_waffle` |
| `vendor/oneplus/sm8650-common` | `SorasakiHinaHusband/proprietary_vendor_oneplus_sm8650-common` |

## 一些碎碎念

- **三段式拨动键**：由 `prebuilt/vendor/bin/alert-slider.sh` 负责，它会被塞进
  `/vendor/bin`，然后由 common 树的 `init.target.rc` 拉起来。放在 `/vendor/etc/init`
  里它是不认的，这台机器就是这么多戏。
- **短信**：走 AOSP Messaging，外加 `prebuilt/etc/permissions/` 里那份特权白名单，
  不然通知会装死。
- **dtbo**：`prebuilt/dtbo.img` 是预编译的，构建时由 AVB 重新签名，不要手贱去改。

## 许可证

除非文件里另有说明，否则按 Apache License 2.0 授权。
原作者的版权声明和 SPDX 标识都好好留着——这是规矩，也是礼貌。
