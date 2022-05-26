--[[    Window rules
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
local beautiful = require("beautiful")

local ruled = require("ruled")
-- }}}

ruled.client.connect_signal("request::rules", function()

    -- All clients will match this rule.
    ruled.client.append_rule {
        id = "global",
        rule = { },
        properties = { 
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
          }
    }

    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule { 
        id = "titlebars",
        rule_any = { type = { "normal", "dialog" } }, 
        properties = { titlebars_enabled = true }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id = "floating",
        rule_any = {
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
        }, 
         properties = { floating = true }
    }
end)