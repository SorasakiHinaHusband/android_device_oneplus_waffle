#!/system/bin/sh
# 一加三段式拨动键处理（user / userdebug 通用）
#
# 硬件：内核驱动 oplus,hall_tri_state_key 在拨动时上报 KEY_F3（0x003d），
#       value 即档位：1=上(静音) 2=中(振动) 3=下(响铃)。
#
# 运行环境：init 通过 /system/bin/sh 拉起 → shell 域
#   （system/sepolicy/private/init.te: domain_trans(init, shell_exec, shell)），
#   shell 域可以执行 `cmd audio`，且能读 /dev/input/*。
#   注意：shell 域读不到 /proc/tristatekey/tri_state（vendor_proc_tri_state_key），
#   所以优先用 getevent，proc 节点只作为可读时的补充。
#
# 依赖：getevent（toolbox）、cmd（system/bin）

NODE=/proc/tristatekey/tri_state
log -t alert_slider "service started"

apply() {
    case "$1" in
        1) cmd audio set-ringer-mode SILENT  ;;
        2) cmd audio set-ringer-mode VIBRATE ;;
        3) cmd audio set-ringer-mode NORMAL  ;;
        *) return 1 ;;
    esac
    log -t alert_slider "position=$1 -> ringer applied"
}

# 自动查找三段式按键的 input 设备
# 注意：shell 域读不了 /sys/class/input/*/device/name，
#       必须用 getevent -lp 列出的 name 来匹配。
find_dev() {
    getevent -lp 2>/dev/null | awk '
        /^add device/ { dev = $NF }
        /name:/ && tolower($0) ~ /tri|hall/ { print dev; exit }
    '
}

# 可读 proc 节点时，直接轮询（最可靠）
watch_proc() {
    last=""
    while true; do
        v=$(cat "$NODE" 2>/dev/null)
        case "$v" in
            1|2|3)
                if [ "$v" != "$last" ]; then
                    last="$v"
                    apply "$v"
                fi
                ;;
        esac
        sleep 2
    done
}

# 解析 getevent：内核补丁在拨动时会额外上报 EV_MSC/MSC_SCAN（0x0004 0x0004），
# 其 value 就是真实档位 1/2/3。
# 注意：KEY_F3 事件的 value 被 input_report_key 压成 0/1，不能用来判断档位。
watch_events() {
    dev="$1"
    getevent "$dev" 2>/dev/null | while read -r line; do
        case "$line" in
            *"0004 0004 "*)
                hex=$(printf '%s\n' "$line" | awk '{print $NF}')
                case "$hex" in
                    *[!0-9a-fA-F]*) continue ;;
                esac
                val=$((0x$hex))
                case "$val" in
                    1|2|3) apply "$val" ;;
                esac
                ;;
        esac
    done
}

# 开机时若 proc 可读，先按当前档位同步一次
if [ -r "$NODE" ]; then
    p=$(cat "$NODE" 2>/dev/null)
    case "$p" in 1|2|3) apply "$p" ;; esac
fi

if [ -r "$NODE" ]; then
    watch_proc
else
    while true; do
        DEV=$(find_dev) || DEV=""
        if [ -n "$DEV" ] && [ -e "$DEV" ]; then
            watch_events "$DEV"
        fi
        sleep 3
    done
fi
