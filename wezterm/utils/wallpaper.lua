local wezterm = require("wezterm")
local h = require("utils/helpers")
local M = {}


M.get_wallpaper = function()
    local wallpaper_glob = wezterm.config_dir .. "/../assets/**"
    -- Get all matching files
    local matches = wezterm.glob(wallpaper_glob)
    local wallpapers = {}
    for _, path in ipairs(matches) do 
        if not string.match(path, "%.DS_Store$") then
            table.insert(wallpapers, path)
        end
    end
    -- Pick a random wallpapper
    local wallpaper = h.get_random_entry(wallpapers)
    return {
        source = { File = { path = wallpaper } },
        height = "Cover",
        width = "Cover",
        horizontal_align = "Left",
        repeat_x = "Repeat",
        repeat_y = "Repeat",
        opacity =  1,
        -- speed = 200,
    }
  end

  -- Keybind functionality 
  M.next_wallpaper = function(window)
    local overrides = window:get_config_overrides() or {}
    overrides.window_background_image = M.get_wallpaper()
    window:set_config_overrides(overrides)
    window:toast_notification("Wallpaper Changed", "A new wallpaper is now applied", nil, 3000)
  end 

  
  return M