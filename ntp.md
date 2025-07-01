开启网络adb



获取设备IP



+ 设置时区

```
adb shell setprop persist.sys.timezone Asia/Shanghai
```

+ 新建全局ntp服务器

```
adb shell settings put global ntp_server your_ntp_server
```

+ 使用全局ntp服务器

```
adb shell settings get global ntp_server
```

+ 重启设备使设置生效

```
adb reboot
```

