local wezterm = require("wezterm")
local M = {}





-- Returns true if appearance is dark
M.is_dark = function()
    -- Get current appearance (light/dark)
    local appearance = wezterm.gui and wezterm.gui.get_appearance() or "Dark"
    return appearance and appearance:find("Dark") ~= nil
end 

-- Returns a random entry from a list-style table
M.get_random_entry = function(tbl)
    if not tbl or #tbl == 0 then
        return nil
    end
    math.randomseed(os.time())
    return tbl[math.random(1, #tbl)]
end

return M