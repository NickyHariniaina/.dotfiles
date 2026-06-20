local scriptsDir = os.getenv("HOME") .. "/.config/hypr/scripts"

-- Workspace switching
hl.bind("SUPER + I", hl.dsp.focus({ workspace = "1" }))
hl.bind("SUPER + O", hl.dsp.focus({ workspace = "2" }))
hl.bind("SUPER + E", hl.dsp.focus({ workspace = "3" }))
hl.bind("SUPER + A", hl.dsp.focus({ workspace = "4" }))

-- Move windows to workspaces
hl.bind("SUPER + SHIFT + I", hl.dsp.window.move({ workspace = "1" }))
hl.bind("SUPER + SHIFT + O", hl.dsp.window.move({ workspace = "2" }))
hl.bind("SUPER + SHIFT + E", hl.dsp.window.move({ workspace = "3" }))
hl.bind("SUPER + SHIFT + A", hl.dsp.window.move({ workspace = "4" }))

-- Window management
hl.bind("SUPER + SHIFT + C", hl.dsp.window.close())
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + P", hl.dsp.window.pseudo())

-- Move focus
hl.bind("SUPER + left", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "d" }))

-- Move windows
hl.bind("SUPER + T", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + N", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + L", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + S", hl.dsp.window.move({ direction = "d" }))

-- Move windows (alternate with CTRL)
hl.bind("SUPER + CTRL + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + CTRL + right", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + CTRL + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + CTRL + down", hl.dsp.window.move({ direction = "d" }))

-- Mouse binds (drag/resize)
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Quit
hl.bind("CTRL + Delete", hl.dsp.exit())

-- Application launchers
hl.bind("SUPER + APOSTROPHE", hl.dsp.exec_cmd("wlogout"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -modi drun,filebrowser,window"))

-- Scripts
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd(scriptsDir .. "/ScreenLock.sh"))
hl.bind("SUPER + W", hl.dsp.exec_cmd(scriptsDir .. "/WallpaperSelect.sh"))
hl.bind("SUPER + CTRL + R", hl.dsp.exec_cmd(scriptsDir .. "/Refresh.sh"))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd(scriptsDir .. "/RofiEmojis.sh"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(scriptsDir .. "/RofiSearch.sh"))
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd(scriptsDir .. "/WaybarStyle.sh"))
hl.bind("SUPER + Q", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --area"))
hl.bind("SUPER + CTRL + Q", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in6"))

-- Media keys (locked = works even when lockscreen active)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true })

-- Media player controls (locked)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
