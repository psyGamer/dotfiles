--[[    Autostart
                                            __        ____  __ 
  __ ___      _____  ___  ___  _ __ ___   __\ \      / /  \/  |
 / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \ \ /\ / /| |\/| |
| (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/\ V  V / | |  | |
 \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___| \_/\_/  |_|  |_|

      Author:     psyGamer
      Repository: https://github.com/psyGamer/dotfiles
]]--

-- {{{ Modules
local awful = require("awful")
-- }}}}

-- Disable KDE keybindings
awful.spawn.with_shell("systemctl --user mask --runtime plasma-kglobalaccel.service")

-- Compositing & Wallpaper
awful.spawn.with_shell("picom --experimental-backends")
--awful.spawn.with_shell("picom")
awful.spawn.with_shell("nitrogen --restore")

awful.spawn.with_shell("~/.scripts/startup.sh") -- TODO Remove personal stuff