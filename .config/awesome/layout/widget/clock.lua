--[[    Clock widget
                                            __        ____  __ 
  __ ___      _____  ___  ___  _ __ ___   __\ \      / /  \/  |
 / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \ \ /\ / /| |\/| |
| (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/\ V  V / | |  | |
 \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___| \_/\_/  |_|  |_|

      Author:     psyGamer
      Repository: https://github.com/psyGamer/dotfiles
]]--

-- {{{ Modules
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local theme_config = require("themes.config")
-- }}}

return wibox.widget{
    {
        widget = wibox.widget.textclock,
        format = "%H:%M",
        font   = theme_config.font .. " Bold 12",
        valign = "center",
        align  = "center"
    },
    {
        widget = wibox.widget.textclock,
        format = "%a, %e %B",
        font   = theme_config.font .. " Medium 11",
        valign = "center",
        align  = "center"
    },
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(8)
}