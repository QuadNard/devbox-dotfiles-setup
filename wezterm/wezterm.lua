
-- Pull in the wezterm API
local wezterm = require 'wezterm'

local f = require("utils/font")

local w = require("utils/wallpaper")

local b = require("utils/background")

-- get just the wallpaper path string
local wallpaper_path = w.get_wallpaper()
  and w.get_wallpaper().source.File.path

-- This will hold the configuration 
local config = wezterm.config_builder()


-- General appearance and visuals 
config.window_background_opacity = 0.90

config.window_background_image = wallpaper_path 
config.window_background_image_hsb = b.get_background()






config.color_scheme = 'nightfox'
-- Font settings 
config.font_size = 16
config.line_height = 1.2
config.font = f.get_font()
-- Colors
config.colors = {
    cursor_bg = 'white',
    cursor_border = 'white',
}
-- Appearance 
config.window_decorations = 'RESIZE'
config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}

config.use_fancy_tab_bar = true
config.window_frame = {
    font = wezterm.font('Verdana', { weight = 'Bold' })
}
config.default_cursor_style = "BlinkingUnderline"
config.cursor_blink_rate = 500

config.colors = {
  tab_bar = {
    background = "#00141d", -- col_gray1

    active_tab = {
        bg_color = "#80bfff", -- col_gray2 (bright blue tab)
        fg_color = "#00141d", -- dark text on active tab
    },

    inactive_tab = {
        bg_color = "#1a1a1a", -- col_gray4
        fg_color = "#FFFFFF", -- col_gray3
    },

    new_tab = {
        bg_color = "#1a1a1a",
        fg_color = "#4fc3f7", -- col_barbie (for the "+" button)
    },
  },
}


-- Keybinds
config.leader = { key = "q", mods = "ALT", timeout_millieseconds = 2000 }
config.keys = {
   -- random font
   {
    mods: "LEADER",
    key = "Space",
    action = wezterm.action_callback(function(window, _)
       f.next_font(window)
    end),
   }, 
   -- random wallpaper
   {
     mods: "LEADER",
     key = "w",
     action = wezterm.action_callback(function(window, _)
        w.next_wallpaper(window)
     end),
   }, 
}



-- Terminal emulation
config.term = "xterm-256color"
config.max_fps = 144
config.animation_fps = 30 
config.prefer_egl = true 

return config 

