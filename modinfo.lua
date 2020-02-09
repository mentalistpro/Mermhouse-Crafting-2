name 					= "[TEST] Mermhouse Crafting"
author 					= "Alberto Pietralunga and mentalistpro"
version 				= "2.0"
description				= "Crafting merm house structures."
forumthread 			= ""
api_version 			= 6

dont_starve_compatible 		= true
reign_of_giants_compatible 	= true
shipwrecked_compatible		= true
hamlet_compatible			= true

icon_atlas 				= "modicon.xml"
icon 					= "modicon.tex"

configuration_options = {
	{
	name = "m_icon", 
	label = "Mermhouse icon",
	options = {
			  {description = "OFF", data = 0},
			  {description = "ON", data = 1},
	          },
	default = 1
	},
	{
	name = "f_icon", 
	label = "Fishermerm's Hut icon",
	options = {
			  {description = "OFF", data = 0},
			  {description = "ON", data = 1},
	          },
	default = 1
	},
	{
	name = "c_icon", 
	label = "Craftedmerms House icon",
	options = {
			  {description = "OFF", data = 0},
			  {description = "ON", data = 1},
	          },
	default = 1
	},
	{
	name = "w_icon", 
	label = "Merm Flort-ifications icon",
	options = {
			  {description = "OFF", data = 0},
			  {description = "ON", data = 1},
	          },
	default = 1
	},
}

