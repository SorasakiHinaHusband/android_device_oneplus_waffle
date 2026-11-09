#!/system/bin/sh
# 一加三段式拨动键处理
# 内核驱动把档位暴露在 /proc/tristatekey/tri_state：
#   1 = 上档（静音）  2 = 中档（振动）  3 = 下档（响铃）
# 采用轮询方式，避免依赖 getevent 的输出格式与权限。
NODE=/proc/tristatekey/tri_state

log -t alert_slider "service started"

apply() {
    case "$1" in
        1) cmd audio set-ringer-mode SILENT  ;;
        2) cmd audio set-ringer-mode VIBRATE ;;
        3) cmd audio set-ringer-mode NORMAL  ;;
    esac
    log -t alert_slider "position=$1 -> applied"
}

last=""
while [ ! -e "$NODE" ]; do sleep 3; done

while true; do
    pos=$(cat "$NODE" 2>/dev/null)
    if [ -n "$pos" ] && [ "$pos" != "$last" ]; then
        last="$pos"
        apply "$pos"
    fi
    sleep 2
done
