--[[    Main configuration
                                            __        ____  __ 
  __ ___      _____  ___  ___  _ __ ___   __\ \      / /  \/  |
 / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \ \ /\ / /| |\/| |
| (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/\ V  V / | |  | |
 \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___| \_/\_/  |_|  |_|

      Author:     psyGamer
      Repository: https://github.com/psyGamer/dotfiles
]]--

-- {{{ Modules
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

local wibox = require("wibox")

local beautiful = require("beautiful")

local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local global = require("global")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- }}}

-- {{{ Variable definitions
terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

theme = "arctic-night"

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/" .. theme .. "/theme.lua")
require("config")
require("layout.bar.status")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
--	awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
--	awful.layout.suit.corner.ne,
--	awful.layout.suit.corner.sw,
--	awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag(global.tags, s, awful.layout.layouts[1])

        if beautiful.at_screen_connect then
          beautiful.at_screen_connect(s)
        end
end)
-- }}}

require("misc.autostart")