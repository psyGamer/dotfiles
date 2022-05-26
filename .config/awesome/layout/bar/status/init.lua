--[[    Statusbar
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
local lain      = require("lain")
local dpi       = beautiful.xresources.apply_dpi

local helper = require("helper")
-- }}}

local clock = require("layout.widget.clock")

-- mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
--                                      menu = mymainmenu })

-- -- Create a textclock widget
-- mytextclock = wibox.widget.textclock()

-- -- Create a wibox for each screen and add it
-- local taglist_buttons = gears.table.join(
--     awful.button({ }, 1, function(t) t:view_only() end),
--     awful.button({ modkey }, 1, function(t)
--         if client.focus then
--             client.focus:move_to_tag(t)
--         end
--     end),
--     awful.button({ }, 3, awful.tag.viewtoggle),
--     awful.button({ modkey }, 3, function(t)
--         if client.focus then
--             client.focus:toggle_tag(t)
--         end
--     end),
--     awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
--     awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
--                 )

-- local tasklist_buttons = gears.table.join(
--     awful.button({ }, 1, function (c)
--         if c == client.focus then
--             c.minimized = true
--         else
--             c:emit_signal(
--                 "request::activate",
--                 "tasklist",
--                 {raise = true}
--             )
--         end
--     end),
--     awful.button({ }, 3, function()	awful.menu.client_list({ theme = { width = 250 } })	end),
--     awful.button({ }, 4, function()	awful.client.focus.byidx( 1)	end),
--     awful.button({ }, 5, function()	awful.client.focus.byidx(-1) end))

-- local volume = lain.widget.pulsebar()
-- local cpu = lain.widget.cpu {
--     settings = function()
--         widget:set_markup("Cpu " .. cpu_now.usage)
--     end
-- }

-- local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
-- local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
-- local cw = calendar_widget()

-- local date_time = wibox.widget{
--     {
--         widget = wibox.widget.textclock,
--         format = "%H:%M",
--         font = "sans Bold 12",
--         valign = "center",
--         align = "center"
--     },
--     {
--         widget = wibox.widget.textclock,
--         format = "%a, %e %B",
--         font = "sans Medium 11",
--         valign = "center",
--         align = "center"
--     },
--     layout = wibox.layout.fixed.horizontal,
--     spacing = dpi(8)
-- }

-- local bat_icon = wibox.widget{
--     markup = "<span foreground='" .. "#1a1a1a" .. "'></span>",
--     font = "Material Icons Round " .. "10",
--     align = "center",
--     valign = "center",
--     widget = wibox.widget.textbox
-- }

-- local battery_progress = wibox.widget{
--     color				= "#69ee69",
--     background_color	= "#eeeeee" .. "00",
--     forced_width        = dpi(27),
--     border_width        = dpi(0.5),
--     border_color        = "#eeeeee" .. "A6",
--     paddings             = dpi(2),
--     bar_shape           = rrect(dpi(2)),
--     shape				= rrect(dpi(4)),
--     value               = 70,
--     max_value 			= 100,
--     widget              = wibox.widget.progressbar,
-- }

-- local battery_border_thing = wibox.widget{
--         wibox.widget.textbox,
--         widget = wibox.container.background,
--         border_width        = dpi(0),
--         bg = "#eeeeee" .. "A6",
--         forced_width = dpi(9.4),
--         forced_height = dpi(9.4),
--         shape = function(cr, width, height)
--             gears.shape.pie(cr,width, height, 0, math.pi)
--         end
-- }

-- local battery = wibox.widget{
--     {
--         {
--             {
--                 battery_border_thing,
--                 direction = "south",
--                 widget = wibox.container.rotate
--             },
--             {
--                 battery_progress,
--                 direction = "east",
--                 widget = wibox.container.rotate()
--             },
--             layout = wibox.layout.fixed.vertical,
--             spacing = dpi(-4)
--         },
--         {
--             bat_icon,
--             margins = {top = dpi(3)},
--             widget = wibox.container.margin,
--         },
--         layout = wibox.layout.stack,
--     },
--     widget = wibox.container.margin,
--     margins = {left = dpi(7.47),right = dpi(7.47)}
-- }

-- awesome.connect_signal("signal::battery", function(value, state)
--     battery_progress.value = value


--     if state == 1 then
--         bat_icon.visible = true
--     else
--         bat_icon.visible = false
--     end

-- end)

-- mytextclock:connect_signal("button::press",
--     function(_, _, _, button)
--         if button == 1 then cw.toggle() end
--     end)

awful.screen.connect_for_each_screen(function(s)
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen	= s,
        filter	= awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen	= s,
        filter	= awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    --s.status_bar = awful.wibar({ position = "top", screen = s })
    s.status_bar = awful.wibar({
        screen      = s,
        visible     = true,
        ontop       = false,
        type        = "dock",
        width       = dpi(300),
        shape       = helper.rounded_rect(15),
        bg          =  "#eeeeee",
        -- height       = s.geometry.height - beautiful.useless_gap * 4
        height = dpi(60)
    })

    -- Add widgets to the wibox
    -- s.status_bar:setup {
    -- 	layout = wibox.layout.align.horizontal,
    -- 	{ -- Left widgets
    -- 		layout = wibox.layout.fixed.horizontal,
    -- 		s.mytaglist,
    -- 	},
    -- 	{ -- Middle widgets
    -- 		layout = wibox.layout.fixed.horizontal,
    -- 		cpu.widget,
    -- 		brightness_widget{
    -- 			type = 'icon_and_text',
    -- 			program = 'light',
    -- 			step = 2,
    --   		},
    -- 		clock
    -- 	},
    -- 	{ -- Right widgets
    -- 		layout = wibox.layout.fixed.horizontal,
    -- 		wibox.widget.systray(),
    -- 		mytextclock,
    -- 		s.mylayoutbox,
    -- 		brightness_widget()
    -- 	},
    -- }
    s.status_bar:setup {
        layout = wibox.layout.flex.horizontal,
        --date_time,
        clock
    }
end)
