--[[	Keybindings
                                            __        ____  __ 
  __ ___      _____  ___  ___  _ __ ___   __\ \      / /  \/  |
 / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \ \ /\ / /| |\/| |
| (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/\ V  V / | |  | |
 \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___| \_/\_/  |_|  |_|

	Author: 	psyGamer
	Repository: https://github.com/psyGamer/dotfiles
]]--

-- {{{ Library definitions
-- Standard awesome library
local awful = require("awful")
local gears = require("gears")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Modules
local global = require("global")
-- }}}

-- {{{ Variable definitions
local modkey = global.modkey

local groupNames = {
	awesome  = "awesome",
	launcher = "Launcher",
	tag      = "Navigation",
	client   = "Client",
	screen   = "Screen",
	layout   = "Layout",
}
-- }}}

local bindings = { }

-- {{{ Mouse bindings
bindings.mouse = { 
	global = gears.table.join(
		awful.button({ }, 3, function() mymainmenu:toggle() end),
		awful.button({ }, 4, awful.tag.viewnext),
		awful.button({ }, 5, awful.tag.viewprev)
	),

	client = gears.table.join(
		awful.button({ }, 1, function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
		end),
		awful.button({ modkey }, 1, function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.move(c)
		end),
		awful.button({ modkey }, 3, function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.resize(c)
		end)
	)
}
-- }}}

-- {{{ Keyboard bindings
bindings.keyboard = {
	global = gears.table.join(
		-- {{{ awesome
		awful.key({ modkey,			  }, "Return", function() awful.spawn(terminal) end,
				  {description = "Open a terminal", group = groupNames.launcher }),
		awful.key({ modkey, "Control" }, "r", awesome.restart,
				  { description = "Reload awesome", group = groupNames.awesome }),
		awful.key({ modkey, "Shift"   }, "q", awesome.quit,
				  { description = "Quit awesome", group = groupNames.awesome }),

		awful.key({ modkey,			  }, "s",	   hotkeys_popup.show_help,
				  { description = "Show help", group = groupNames.awesome  }),
		-- }}}

		-- {{{ Launcher / Prompts
		awful.key({ modkey            }, "space", function() awful.spawn("/usr/bin/rofi -show drun -modi drun") end, 
				  { description = "Open application launcher", group = groupNames.launcher }),
		awful.key({ modkey, "Shift"   }, "space", function() awful.spawn("/usr/bin/rofi -show run -modi run") end, 
				  { description = "Open run launcher", group = groupNames.launcher }),
		-- }}}

		-- {{{ Layout navigation
		awful.key({ modkey,			  }, "Left",   awful.tag.viewprev,
				  { description = "View previous", group = groupNames.tag }),
		awful.key({ modkey,			  }, "Right",  awful.tag.viewnext,
				  { description = "View next", group = groupNames.tag }),
		awful.key({ modkey,			  }, "Escape", awful.tag.history.restore,
				  { description = "Go back",   group = groupNames.tag }),

		awful.key({ modkey,			  }, "j", function() awful.client.focus.byidx( 1) end,
				  { description = "Focus next by index",     group = groupNames.client }
		),
		awful.key({ modkey,			  }, "k", function() awful.client.focus.byidx(-1) end,
				  { description = "Focus previous by index", group = groupNames.client }
		),
		-- }}}

		-- {{{ Layout manipulation
		awful.key({ modkey, "Shift"   }, "j", function() awful.client.swap.byidx(	1)	  end,
				  { description = "Swap with next client by index", group = groupNames.client }),
		awful.key({ modkey, "Shift"   }, "k", function() awful.client.swap.byidx( -1)	  end,
				  { description = "Swap with previous client by index", group = groupNames.client }),
		awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative( 1) end,
				  { description = "Focus the next screen", group = groupNames.screen }),
		awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
				  { description = "Focus the previous screen", group = groupNames.screen }),
		awful.key({ modkey,			  }, "u", awful.client.urgent.jumpto,
				  { description = "Jump to urgent client", group = groupNames.client }),

		awful.key({ modkey,			  }, "l",	  function() awful.tag.incmwfact( 0.05)		  end,
				  { description = "Increase master width factor", group = groupNames.layout }),
		awful.key({ modkey,			  }, "h",	  function() awful.tag.incmwfact(-0.05)		  end,
				  { description = "Decrease master width factor", group = groupNames.layout }),
		awful.key({ modkey, "Shift"   }, "h",	  function() awful.tag.incnmaster( 1, nil, true) end,
				  { description = "Increase the number of master clients", group = groupNames.layout }),
		awful.key({ modkey, "Shift"   }, "l",	  function() awful.tag.incnmaster(-1, nil, true) end,
				  { description = "Decrease the number of master clients", group = groupNames.layout }),
		awful.key({ modkey, "Control" }, "h",	  function() awful.tag.incncol( 1, nil, true)	  end,
				  { description = "Increase the number of columns", group = groupNames.layout }),
		awful.key({ modkey, "Control" }, "l",	  function() awful.tag.incncol(-1, nil, true)	  end,
				  { description = "Decrease the number of columns", group = groupNames.layout }),
		awful.key({ modkey,			  }, "#", function() awful.layout.inc( 1)				  end,
				  { description = "Select next", group = groupNames.layout }),
		awful.key({ modkey, "Shift"   }, "#", function() awful.layout.inc(-1)				  end,
				  { description = "Select previous", group = groupNames.layout }),
		-- }}}

		-- {{{ Menubar
		awful.key({ modkey,			  }, "w", function() mymainmenu:show() end,
				  { description = "Show main menu", group = groupNames.awesome }),
		awful.key({ modkey }, "p", function() menubar.show() end,
				  { description = "show the menubar", group = groupNames.launcher }),
		-- }}}

		-- {{{ Media keys
		awful.key({ }, "XF86AudioPlay", function() awful.spawn("/usr/bin/playerctl play-pause") end),
		awful.key({ }, "XF86AudioNext", function() awful.spawn("/usr/bin/playerctl next", false) end),
		awful.key({ }, "XF86AudioPrev", function() awful.spawn("/usr/bin/playerctl previous", false) end),
		awful.key({ }, "XF86AudioStop", function() awful.spawn("/usr/bin/playerctl stop", false) end),
		-- }}}

		-- {{{ Utilities
		awful.key({ }, "Print", function() awful.spawn.with_shell("flameshot full -c -p /home/manuel/Bilder/Screenshots/") end)
		-- }}}
	),

	client = gears.table.join(
		awful.key({ modkey, "Shift"   }, "c",	   function (c) c:kill()						 end,
				  { description = "Close", group = groupNames.client }),
		awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle						,
				  { description = "Toggle floating", group = groupNames.client }),
		awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
				  { description = "Move to master", group = groupNames.client }),
		awful.key({ modkey,			  }, "o",	   function (c) c:move_to_screen()				 end,
				  { description = "Move to screen", group = groupNames.client }),
		awful.key({ modkey,			  }, "t",	   function (c) c.ontop = not c.ontop			 end,
				  { description = "Toggle keep on top", group = groupNames.client }),

		awful.key({ modkey,			  }, "n",
			function (c)
				-- The client currently has the input focus, so it cannot be
				-- minimized, since minimized clients can't have the focus.
				c.minimized = true
			end ,
			  { description = "Minimize", group = groupNames.client }),
		awful.key({ modkey,			  }, "m",
			function (c)
				c.maximized = not c.maximized
				c:raise()
			end ,
			  { description = "(Un)maximize", group = groupNames.client }),
		awful.key({ modkey, "Control" }, "m",
			function (c)
				c.maximized_vertical = not c.maximized_vertical
				c:raise()
			end ,
			  { description = "(Un)maximize vertically", group = groupNames.client }),
		awful.key({ modkey, "Shift"   }, "m",
			function (c)
				c.maximized_horizontal = not c.maximized_horizontal
				c:raise()
			end ,
			  { description = "(Un)maximize horizontally", group = groupNames.client }),

		awful.key({ modkey,			  }, "Tab",
			function()
				awful.client.focus.history.previous()
				if client.focus then
					client.focus:raise()
				end
			end,
				  { description = "Go back", group = groupNames.client} ),
		awful.key({ modkey, "Control" }, "n",
				function()
					local c = awful.client.restore()
					-- Focus restored client
					if c then
						c:emit_signal(
							"request::activate", "key.unminimize", {raise = true}
						)
					end
				end,
				  { description = "Restore minimized", group = groupNames.client }),
		awful.key({ modkey,			  }, "f",
			function (c)
				c.fullscreen = not c.fullscreen
				c:raise()
			end,
			{ description = "Toggle fullscreen", group = groupNames.client })
	)
}
-- }}}

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	bindings.keyboard.global = gears.table.join(bindings.keyboard.global,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9,
				  function()
						local screen = awful.screen.focused()
						local tag = screen.tags[i]
						if tag then
						   tag:view_only()
						end
				  end,
				  {description = "view tag #"..i, group = groupNames.tag}),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9,
				  function()
					  local screen = awful.screen.focused()
					  local tag = screen.tags[i]
					  if tag then
						 awful.tag.viewtoggle(tag)
					  end
				  end,
				  {description = "toggle tag #" .. i, group = groupNames.tag}),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
				  function()
					  if client.focus then
						  local tag = client.focus.screen.tags[i]
						  if tag then
							  client.focus:move_to_tag(tag)
						  end
					 end
				  end,
				  {description = "move focused client to tag #"..i, group = groupNames.tag}),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
				  function()
					  if client.focus then
						  local tag = client.focus.screen.tags[i]
						  if tag then
							  client.focus:toggle_tag(tag)
						  end
					  end
				  end,
				  {description = "toggle focused client on tag #" .. i, group = groupNames.tag})
	)
end

return bindings
