--[[	Main configuration
                                            __        ____  __ 
  __ ___      _____  ___  ___  _ __ ___   __\ \      / /  \/  |
 / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \ \ /\ / /| |\/| |
| (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/\ V  V / | |  | |
 \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___| \_/\_/  |_|  |_|

	Author: 	psyGamer
	Repository: https://github.com/psyGamer/dotfiles
]]--

-- {{{ Library definitions
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.    
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Modules
local bindings = require("bindings")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- }}}

-- {{{ Variable definitions
modkey = "Mod4" -- Super (Windows) key

terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

theme = "arctic-night"

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/" .. theme .. "/theme.lua")

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

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({ preset = naughty.config.presets.critical,
					 title = "Oops, there were errors during startup!",
					 text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({ preset = naughty.config.presets.critical,
						 title = "Oops, an error happened!",
						 text = tostring(err) })
		in_error = false
	end)
end
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
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
end)
-- }}}

-- {{{ Set keybindings
root.buttons(bindings.mouse.global)
root.keys(bindings.keyboard.global)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{ rule = { },
	  properties = { border_width = beautiful.border_width,
					 border_color = beautiful.border_normal,
					 focus = awful.client.focus.filter,
					 raise = true,
					 keys = bindings.keyboard.client,
					 buttons = bindings.mouse.client,
					 screen = awful.screen.preferred,
					 placement = awful.placement.no_overlap+awful.placement.no_offscreen
	 }
	},

	-- Floating clients.
	{ rule_any = {
		instance = {
		  "DTA",  -- Firefox addon DownThemAll.
		  "copyq",	-- Includes session name in class.
		  "pinentry",
		},
		class = {
		  "Arandr",
		  "Blueman-manager",
		  "Gpick",
		  "Kruler",
		  "MessageWin",  -- kalarm.
		  "Sxiv",
		  "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
		  "Wpa_gui",
		  "veromix",
		  "xtightvncviewer"},

		-- Note that the name property shown in xprop might be set slightly after creation of the client
		-- and the name shown there might not match defined rules here.
		name = {
		  "Event Tester",  -- xev.
		},
		role = {
		  "AlarmWindow",  -- Thunderbird's calendar.
		  "ConfigManager",	-- Thunderbird's about:config.
		  "pop-up",		  -- e.g. Google Chrome's (detached) Developer Tools.
		}
	  }, properties = { floating = true }},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = {type = { "normal", "dialog" }
	  }, properties = { titlebars_enabled = true }
	},

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--	 properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup
	  and not c.size_hints.user_position
	  and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end

	awful.titlebar(c,{size=10})
	awful.titlebar.hide(c)
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({ }, 1, function()
			c:emit_signal("request::activate", "titlebar", {raise = true})
			awful.mouse.client.move(c)
		end),
		awful.button({ }, 3, function()
			c:emit_signal("request::activate", "titlebar", {raise = true})
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c) : setup {
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout	= wibox.layout.fixed.horizontal
		},
		{ -- Middle
			{ -- Title
				align  = "center",
				widget = awful.titlebar.widget.titlewidget(c)
			},
			buttons = buttons,
			layout	= wibox.layout.flex.horizontal
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton (c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton	 (c),
			awful.titlebar.widget.ontopbutton	 (c),
			awful.titlebar.widget.closebutton	 (c),
			layout = wibox.layout.fixed.horizontal()
		},
		layout = wibox.layout.align.horizontal
	}
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Autostart Progams
-- Disable KDE keybindings
awful.spawn.with_shell("systemctl --user mask --runtime plasma-kglobalaccel.service")

-- Compositing & Wallpaper
awful.spawn.with_shell("picom")
awful.spawn.with_shell("nitrogen --restore")

awful.spawn.with_shell("~/.scripts/startup.sh") -- TODO Remove personal stuff
-- }}}
