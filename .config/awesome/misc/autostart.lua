local awful = require("awful")

-- Disable KDE keybindings
awful.spawn.with_shell("systemctl --user mask --runtime plasma-kglobalaccel.service")

-- Compositing & Wallpaper
--awful.spawn.with_shell("picom --experimental-backends")
awful.spawn.with_shell("picom")
awful.spawn.with_shell("nitrogen --restore")

awful.spawn.with_shell("~/.scripts/startup.sh") -- TODO Remove personal stuff