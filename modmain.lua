local _G = GLOBAL
local Ingredient = _G.Ingredient
local IsDLCEnabled = _G.IsDLCEnabled
local Recipe = _G.Recipe
local RECIPETABS = _G.RECIPETABS
local RECIPE_GAME_TYPE = _G.RECIPE_GAME_TYPE
local STRINGS = _G.STRINGS
local TECH = _G.TECH

PrefabFiles = {
	"mermhouse_vaplacer", "mermhouse_swplacer", "mermhouse_crafted", "mermhouse_fisherplacer" 
}

Assets = {
	Asset("ATLAS", "images/inventoryimages/mermhouse_va.xml"),
	Asset("ATLAS", "images/inventoryimages/mermhouse_sw.xml"),
	Asset("ATLAS", "images/inventoryimages/mermhouse_crafted.xml"),
    Asset("ATLAS", "images/inventoryimages/mermhouse_fisher.xml"),
}

if STRINGS.CHARACTERS.WARLY == nil then STRINGS.CHARACTERS.WARLY = { DESCRIBE = {},	} end -- DLC002
if STRINGS.CHARACTERS.WATHGRITHR == nil then STRINGS.CHARACTERS.WATHGRITHR = { DESCRIBE = {}, }  end -- DLC001
if STRINGS.CHARACTERS.WEBBER == nil then STRINGS.CHARACTERS.WEBBER = { DESCRIBE = {}, }  end -- DLC001
if STRINGS.CHARACTERS.WINONA == nil then STRINGS.CHARACTERS.WINONA = { DESCRIBE = {}, } end -- DST
if STRINGS.CHARACTERS.WORMWOOD == nil then STRINGS.CHARACTERS.WORMWOOD = { DESCRIBE = {}, }  end -- DLC003
if STRINGS.CHARACTERS.WORTOX == nil then STRINGS.CHARACTERS.WORTOX = { DESCRIBE = {}, }  end -- DST
if STRINGS.CHARACTERS.WURT == nil then STRINGS.CHARACTERS.WURT = { DESCRIBE = {}, } end -- DST

if IsDLCEnabled(2) then	fish_type = "tropical_fish" else fish_type = "fish" end

-------------------------------------------------------------------------------------
--Mermhouse

if IsDLCEnabled(2) or IsDLCEnabled(3) then
	local mermhouse_sw = Recipe(
		"mermhouse_sw", 
		{
		Ingredient("boards", GetModConfigData("boards_m")), 
		Ingredient("rocks", GetModConfigData("rocks_m")), 
		Ingredient(fish_type, GetModConfigData("fish_m")*2),
		},
		RECIPETABS.TOWN, 
		TECH.SCIENCE_TWO,
		RECIPE_GAME_TYPE.COMMON,
		"mermhouse_sw_placer")
		
		mermhouse_sw.product = "mermhouse"		
		mermhouse_sw.atlas = "images/inventoryimages/mermhouse_sw.xml"

		STRINGS.NAMES.MERMHOUSE_SW = "Merm Hut"
		STRINGS.RECIPE_DESC.MERMHOUSE_SW = "A crowded domicile for mermaid men."

else
	local mermhouse_va = Recipe(
		"mermhouse_va", 
		{
		Ingredient("boards", GetModConfigData("boards_m")), 
		Ingredient("rocks", GetModConfigData("rocks_m")), 
		Ingredient(fish_type, GetModConfigData("fish_m")),
		Ingredient("froglegs", GetModConfigData("froglegs_m")),
		},
		RECIPETABS.TOWN, 
		TECH.SCIENCE_TWO,
		"mermhouse_placer")
		
		mermhouse_va.product = "mermhouse"
		mermhouse_va.atlas = "images/inventoryimages/mermhouse_va.xml"
		
		STRINGS.NAMES.MERMHOUSE_VA = "Mermhouse"
		STRINGS.RECIPE_DESC.MERMHOUSE_VA = "A crowded domicile for mermaid men."
end

-------------------------------------------------------------------------------------
--Craftsmerm House
	
local mermhouse_crafted = Recipe(
	"mermhouse_crafted", 
	{
	Ingredient("boards", GetModConfigData("boards_c")), 
	Ingredient("cutreeds", GetModConfigData("cutreeds_c")), 
	Ingredient(fish_type, GetModConfigData("fish_c")),
	},
	RECIPETABS.TOWN, 
	TECH.SCIENCE_TWO)
	
	mermhouse_crafted.placer = "mermhouse_crafted_placer"
	mermhouse_crafted.atlas = "images/inventoryimages/mermhouse_crafted.xml"
	if IsDLCEnabled(2) or IsDLCEnabled(3) then
		mermhouse_crafted.game_type = RECIPE_GAME_TYPE.COMMON
	end
	STRINGS.NAMES.MERMHOUSE_CRAFTED = "Craftsmerm House"
	STRINGS.RECIPE_DESC.MERMHOUSE_CRAFTED = "A home fit for a Merm."
	
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.MERMHOUSE_CRAFTED = {"It's actually kind of cute."}
	STRINGS.CHARACTERS.WARLY.DESCRIBE.MERMHOUSE_CRAFTED = {"Oh! It looks... very nice!"}
	STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.MERMHOUSE_CRAFTED = {"A home fit for a fish beast."}
	STRINGS.CHARACTERS.WAXWELL.DESCRIBE.MERMHOUSE_CRAFTED = {"It's slightly less offensive to my eyes than the others."}
	STRINGS.CHARACTERS.WEBBER.DESCRIBE.MERMHOUSE_CRAFTED = {"What a funny little house."}
	STRINGS.CHARACTERS.WENDY.DESCRIBE.MERMHOUSE_CRAFTED = {"It has not yet been touched by the ravages of time."}
	STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.MERMHOUSE_CRAFTED = {"It's good to see her doing something constructive."}
	STRINGS.CHARACTERS.WILLOW.DESCRIBE.MERMHOUSE_CRAFTED = {"Looks just as flammable as the old ones."}
	STRINGS.CHARACTERS.WINONA.DESCRIBE.MERMHOUSE_CRAFTED = {"Hm, I should teach that kid how to use a level."}
	STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.MERMHOUSE_CRAFTED = {"Is house for fish men!"}
	STRINGS.CHARACTERS.WOODIE.DESCRIBE.MERMHOUSE_CRAFTED = {"Reminds me of the first house we built, eh Lucy?"}
	STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.MERMHOUSE_CRAFTED = {"Glub Glub house"}
	STRINGS.CHARACTERS.WORTOX.DESCRIBE.MERMHOUSE_CRAFTED = {"An abode fit for a toad, hyuyu!"}
	STRINGS.CHARACTERS.WURT.DESCRIBE.MERMHOUSE_CRAFTED = {"Made it with own claws!"}
	STRINGS.CHARACTERS.WX78.DESCRIBE.MERMHOUSE_CRAFTED = {"IT IS UGLY"}
	
-------------------------------------------------------------------------------------
--Fishermerm House

if IsDLCEnabled(2) or IsDLCEnabled(3) then
	local mermhouse_fisher = Recipe(
		"mermhouse_fisher", 
		{
		Ingredient("boards", GetModConfigData("boards_f")), 
		Ingredient("rocks", GetModConfigData("rocks_f")), 
		Ingredient(fish_type, GetModConfigData("fish_f")),
		},
		RECIPETABS.TOWN, 
		TECH.SCIENCE_TWO,
		RECIPE_GAME_TYPE.COMMON,
		"mermhouse_fisher_placer")
		
	mermhouse_fisher.atlas = "images/inventoryimages/mermhouse_fisher.xml"
	STRINGS.NAMES.MERMHOUSE_FISHER = "Fishermerm's Hut"
	STRINGS.RECIPE_DESC.MERMHOUSE_FISHER = "A dwelling for fish mongers."
end