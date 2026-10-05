#!/bin/bash
#
# MikuUI (Blooming_v2) Automation Script for OnePlus 12 (waffle)
# Ref: https://github.com/Miku-UI/manifesto/blob/Blooming_v2/READMECN.md
#

set -e

MIKU_DIR="$HOME/mikuui"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PAYLOAD_BIN="/home/teto/下载/payload.bin"

echo "=== [1/5] 初始化 MikuUI Blooming_v2 源码目录 ==="
mkdir -p "$MIKU_DIR"
cd "$MIKU_DIR"

if [ ! -d ".repo" ]; then
    repo init -u https://github.com/Miku-UI/manifesto -b Blooming_v2 --git-lfs
fi

echo "=== [2/5] 配置本地设备树与 Manifest ==="
mkdir -p .repo/local_manifests
cp -f "$PROJECT_DIR/local_manifests/waffle.xml" .repo/local_manifests/waffle.xml

echo "=== [3/5] 同步源码 (repo sync - Blooming_v2 官方分支) ==="
repo sync -c -j$(nproc) --force-sync --no-clone-bundle --no-tags

echo "=== [4/5] 部署本地手搓设备树到源码树 ==="
mkdir -p device/oneplus/waffle
mkdir -p device/oneplus/sm8650-common
mkdir -p vendor/oneplus/waffle
mkdir -p hardware/oneplus/tri-state-key

cp -rf "$PROJECT_DIR/device/oneplus/waffle/"* device/oneplus/waffle/
cp -rf "$PROJECT_DIR/device/oneplus/sm8650-common/"* device/oneplus/sm8650-common/
cp -rf "$PROJECT_DIR/vendor/oneplus/waffle/"* vendor/oneplus/waffle/
cp -rf "$PROJECT_DIR/hardware/oneplus/"* hardware/oneplus/

echo "=== [5/5] 从官方 payload.bin 提取闭源驱动 (Vendor Blobs) ==="
if [ -f "$PAYLOAD_BIN" ]; then
    mkdir -p /tmp/waffle_dump
    echo "正在解包 payload.bin (ColorOS 16.0.10)..."
    /tmp/payload-dumper-go -p vendor,vendor_boot,vendor_dlkm,odm -o /tmp/waffle_dump "$PAYLOAD_BIN"

    cd device/oneplus/waffle
    ./extract-files.sh /tmp/waffle_dump
    cd "$MIKU_DIR"
    echo "驱动提取完成！"
else
    echo "警告: 未在 /home/teto/下载/ 找到 payload.bin，请手动运行提取脚本。"
fi

echo "=== 准备就绪！ ==="
echo "请执行以下命令开始编译 MikuUI (Blooming_v2):"
echo "  cd $MIKU_DIR"
echo "  . build/envsetup.sh"
echo "  lunch miku_waffle-userdebug"
echo "  make diva"
