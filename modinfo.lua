name 					= "Mermhouse Crafting"
author 					= "Alberto Pietralunga & mentalistpro"
version 				= "2.1.2"
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
	name = "mf_icon", 
	label = "Fishermerm's Hut icon",
	options = {
			  {description = "OFF", data = 0},
			  {description = "ON", data = 1},
	          },
	default = 1
	},
	{
	name = "mc_icon", 
	label = "Craftsmerm House icon",
	options = {
			  {description = "OFF", data = 0},
			  {description = "ON", data = 1},
	          },
	default = 1
	},
	{
	name = "mcf_icon", 
	label = "Craftsmerm Fishing House icon",
	options = {
			  {description = "OFF", data = 0},
			  {description = "ON", data = 1},
	          },
	default = 1
	},
	{
	name = "mw_icon", 
	label = "Merm Flort-ifications icon",
	options = {
			  {description = "OFF", data = 0},
			  {description = "ON", data = 1},
	          },
	default = 1
	},
}

