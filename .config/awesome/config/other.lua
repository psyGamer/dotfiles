--[[    Other settings
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

local wibox = require("wibox")

local beautiful = require("beautiful")
local dpi       = require("beautiful.xresources").apply_dpi

local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local helper = require("helper")
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

	-- Disable the titlebar
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

-- {{{ Rounded corners
local function enable_rounded_corners()
	-- if beautiful.rounded and beautiful.rounded > 0 then
	-- 	client.connect_signal("manage", function (c, startup)
	-- 		if not c.fullscreen and not c.maximized then
	-- 			c.shape = helper.rounded_rect(beautiful.rounded)
	-- 		end
	-- 	end)

	-- 	local function no_round_corners (c)
	-- 		if c.fullscreen then
	-- 			c.shape = nil
	-- 		elseif c.maximized then
	-- 			c.shape = helper.partially_rounded_rect(beautiful.rounded, true, true, false, false)
	-- 		else
	-- 			c.shape = helper.rounded_rect(beautiful.rounded)
	-- 		end
	-- 	end

	-- 	client.connect_signal("property::fullscreen", no_round_corners)
	-- 	client.connect_signal("property::maximized", no_round_corners)

	-- 	beautiful.snap_shape = helper.rounded_rect(beautiful.rounded)
	-- else
	-- 	beautiful.snap_shape = gears.shape.rectangle
	-- end
	-- Apply rounded corners to clients if needed
    if beautiful.border_radius and beautiful.border_radius > 0 then
        client.connect_signal("manage", function (c, startup)
            if not c.fullscreen and not c.maximized then
                c.shape = helper.rounded_rect(beautiful.border_radius)
            end
        end)

        -- Fullscreen and maximized clients should not have rounded corners
        local function no_round_corners (c)
            if c.fullscreen or c.maximized then
                c.shape = gears.shape.rectangle
            else
                c.shape = helper.rounded_rect(beautiful.border_radius)
            end
        end

        client.connect_signal("property::fullscreen", no_round_corners)
        client.connect_signal("property::maximized", no_round_corners)

        beautiful.snap_shape = helper.rounded_rect(beautiful.border_radius * 3)
    else
        beautiful.snap_shape = gears.shape.rectangle
    end
end
enable_rounded_corners()
-- }}}