local wezterm = require("wezterm")

local M = {}



-- Font rotation list (installed via brew cask)
local fonts = {
    "SauceCodePro Nerd Font",
    "Verdana",
    "GoMono Nerd Font",
    "CascadiaCode",
    "Geist"
    }

-- Cache file to persist font index
local font_cache_path = wezterm.config_dir .. "/.font_index.txt"

-- Load font index from file or default to 1
local function read_font_index()
    local file = io.open(font_cache_path, "r")
    if file then
        local index = tonumber(file:read("*a"))
        file:close()
        if index and index >= 1 and index <= #fonts then
            return index
        end
    end 
    return 1
end


-- Save font index to file
local function save_font_index(index)
    local file = io.open(font_cache_path, "w")
    if file then
        file:write(tostring(index))
        file:close()
    end
end 

-- Track current font 
local current_index = read_font_index()
M.get_font = function()
    local family = fonts[current_index]
    return wezterm.font_with_fallback({
        { family = family, weight = "Regular" },
        "JetBrains Mono", -- fallback (optional)
        "FiraCode Nerd Font",
    }) 
end 




-- Rotate font on keybind 
M.next_font = function(window)
    current_index = (current_index % #fonts) + 1
    save_font_index(current_index)

    local family = fonts[current_index]
    local overrides = window:get_config_overrides() or {}

    overrides.font = wezterm.font_with_fallback({
        { family = family, weight = "Regular" },
        "JetBrains Mono",
        "FiraCode Nerd Font",
    })
    window:set_config_overrides(overrides)
    window:toast_notification("Font Switched", "Now using: " .. family, nil, 3000)
end

return M