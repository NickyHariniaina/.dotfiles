-- Fcitx5 Japanese input
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
-- Japanese locale
hl.env("LC_MESSAGES", "mg_MG.UTF-8")
hl.env("LC_TIME", "ja_JP.UTF-8")
hl.env("LC_MONETARY", "mg_MG.UTF-8")

hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    }
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
