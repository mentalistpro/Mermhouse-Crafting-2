name                        = "Mermhouse Crafting"
author                      = "Alberto Pietralunga & mentalistpro"
version                     = "2.3"
description                 = "Crafting merm house structures."
forumthread                 = ""
api_version                 = 6
priorty                     = 0     --load before Clever Disguise
dont_starve_compatible      = true
reign_of_giants_compatible  = true
shipwrecked_compatible      = true
hamlet_compatible           = true
icon_atlas                  = "modicon.xml"
icon                        = "modicon.tex"

--tweak config behaviours (not implemented yet)
local function simpleopt(x)
    return {description = x, data = x}
end

local function append(t, x)
    t[#t + 1] = x
    return t
end

local function range(a, b, step)
    local opts = {}
    for x = a, b, step do
        append(opts, simpleopt(x))
    end
    if #opts > 0 then
        local fdata = opts[#opts].data
        if fdata < b and fdata + step - b < 1e-10 then
            append(opts, simpleopt(b))
        end
    end
    return opts
end

--Configurables
configuration_options = {
    {
    name = "marsh_only",
    label = "Marsh ground",
    options = {
              {description = "YES", data = 0},
              {description = "NO", data = 1},
              },
    default = 0
    },

    {
    name = "minimap_icon",
    label = "Minimap icon",
    options = {
              {description = "YES", data = 0},
              {description = "NO", data = 1},
              },
    default = 0
    },
}

