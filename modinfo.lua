name 						= "Mermhouses Crafting"
author 						= "Alberto Pietralunga and mentalistpro"
version 					= "1.3.5"
description					= "Crafting merm house structures."
forumthread 				= ""
api_version 				= 6

dont_starve_compatible 		= true
reign_of_giants_compatible 	= true
shipwrecked_compatible		= true
hamlet_compatible			= true

icon_atlas 					= "modicon.xml"
icon 						= "modicon.tex"


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

configuration_options = {
	{
    	name = "Mermhouse",
		label = "Mermhouse",
		default = "true",
		options = { {description = "-------", data = "true"} }
  	},
	
    	{
 		name = "boards_m", 
		label = "Boards",
		options = range(1, 20, 1),
		default = 4
		},

    	{
 		name = "rocks_m", 
		label = "Rocks",
		options = range(1, 20, 1),
		default = 9
		},

    	{
 		name = "fish_m", 
		label = "Fishes",
		options = range(1, 20, 1),
		default = 8
		},

    	{
 		name = "froglegs_m", 
		label = "Frog Legs",
		options = range(1, 20, 1),
		default = 8
		},
		
	{
		name = "Fishermerm's hut",
		label = "Fishermerm's hut",
		default = "true",
		options = { {description = "-------", data = "true"} }
  	},
	
    	{
		name = "boards_f", 
		label = "Boards",
		options = range(1, 20, 1),
		default = 4
		},

    	{
 		name = "rocks_f", 
		label = "Rocks",
		options = range(1, 20, 1),
		default = 9
		},


    	{
		name = "fish_f", 
		label = "Tropical fishes",
		options = range(1, 20, 1),
		default = 8
		},
		
	{
		name = "Craftsmerm House",
		label = "Craftsmerm House",
		default = "true",
		options = { {description = "-------", data = "true"} }
  	},
	
    	{
		name = "boards_c", 
		label = "Boards",
		options = range(1, 20, 1),
		default = 4
		},

    	{
 		name = "cutreeds_c", 
		label = "Cut Reeds",
		options = range(1, 20, 1),
		default = 3
		},


    	{
		name = "fish_c", 
		label = "Fishes",
		options = range(1, 20, 1),
		default = 2
		},
}
