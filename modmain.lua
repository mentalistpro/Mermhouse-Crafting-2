local _G = GLOBAL
local _S = _G.STRINGS
local Ingredient = _G.Ingredient
local IsDLCEnabled = _G.IsDLCEnabled 
local PrefabExists = _G.PrefabExists
local Recipe = _G.Recipe
local RECIPETABS = _G.RECIPETABS
local RECIPE_GAME_TYPE = _G.RECIPE_GAME_TYPE
local TECH = _G.TECH

PrefabFiles = 
{
	"mermhouse"
}

Assets = 
{
	Asset("ATLAS", "images/inventoryimages/mermhouse.xml"),
    Asset("ATLAS", "images/inventoryimages/mermhouse_fisher.xml"),
	Asset("ATLAS", "images/inventoryimages/mermhouse_crafted.xml"),
	Asset("ATLAS", "images/inventoryimages/mermwatchtower.xml"),
	Asset("ATLAS", "minimap/mermhouse.xml"),
	Asset("ATLAS", "minimap/mermhouse_tropical.xml"),
	Asset("ATLAS", "minimap/mermhouse_fisher.xml"),
	Asset("ATLAS", "minimap/mermhouse_crafted.xml"),
	Asset("ATLAS", "minimap/mermwatchtower.xml")
}

AddMinimapAtlas("minimap/mermhouse.xml")
AddMinimapAtlas("minimap/mermhouse_tropical.xml")
AddMinimapAtlas("minimap/mermhouse_fisher.xml")
AddMinimapAtlas("minimap/mermhouse_crafted.xml")
AddMinimapAtlas("minimap/mermwatchtower.xml")

------------------------------------------------------------------------------------------------------------------------------

--//CONTENT//
--#1 Config
--#2 Recipes
--#3 Strings

------------------------------------------------------------------------------------------------------------------------------
--#1 Config

--Wurt related
--ingredients and merm spawn no/rate

TUNING.MOD_MERMHOUSE_MINIMAP = GetModConfigData("m_icon")
TUNING.MOD_MERMHOUSE_FISHER_MINIMAP = GetModConfigData("f_icon")
TUNING.MOD_MERMHOUSE_CRAFTED_MINIMAP = GetModConfigData("c_icon")
TUNING.MOD_MERMWATCHTOWER_MINIMAP = GetModConfigData("w_icon")

------------------------------------------------------------------------------------------------------------------------------
--#2 Recipes

--//Mermhouse//
	
local x = {"fish", "tropical_fish"}
local y = {"rog", "shipwrecked", "porkland", "common"}
local z = {"mermhouse_placer", "mermhouse_tropical_placer"}
local mermhouse_atlas = "images/inventoryimages/mermhouse.xml"

if IsDLCEnabled(2) or IsDLCEnabled(3) then
	local mermhouse_rog = Recipe(
		"mermhouse", 
		{
		Ingredient("boards", 4), 
		Ingredient("rocks", 9), 
		Ingredient(x[1], 8)
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE,
		y[1], z[1])
		mermhouse_rog.atlas = mermhouse_atlas
		
	local mermhouse_sw = Recipe(
		"mermhouse", 
		{
		Ingredient("boards", 4), 
		Ingredient("rocks", 9), 
		Ingredient(x[2], 8)
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE,
		y[2], z[2])
		mermhouse_sw.atlas = mermhouse_atlas

	local mermhouse_ham = Recipe(
		"mermhouse", 
		{
		Ingredient("boards", 4), 
		Ingredient("rocks", 9), 
		Ingredient(x[1], 8)
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE,
		y[3], z[2])
		mermhouse_ham.atlas = mermhouse_atlas

else
	local mermhouse_ham = Recipe(
		"mermhouse", 
		{
		Ingredient("boards", 4), 
		Ingredient("rocks", 9), 
		Ingredient(x[1], 8)
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE, 
		z[1])
		mermhouse.atlas = mermhouse_atlas
end
		
--//Fishermerm's Hut//

	--[[local mermhouse_fisher = Recipe(
		"mermhouse_fisher", 
		{
		Ingredient("boards", 4), 
		Ingredient("rocks", 9), 
		Ingredient("fish", 8),
		Ingredient("fishingrod",2)
		},
		RECIPETABS.TOWN, 
		TECH.SCIENCE_ONE)

		mermhouse_fisher.placer = "mermhouse_fisher_placer"
		mermhouse_fisher.atlas = "images/inventoryimages/mermhouse_fisher.xml"
		if IsDLCEnabled(3) then
			mermhouse_fisher.game_type = "hamlet" 
		elseif IsDLCEnabled(2) then
			mermhouse_fisher.game_type = "rog"
		end

	local mermhouse_fisher_sw = Recipe(
		"mermhouse_fisher", 
		{
		Ingredient("boards", 4), 
		Ingredient("rocks", 9), 
		Ingredient("tropical_fish", 8),
		Ingredient("fishingrod",2)
		},
		RECIPETABS.TOWN, 
		TECH.SCIENCE_ONE,
		"shipwrecked",
		"mermhouse_fisher_placer",
		"images/inventoryimages/mermhouse_fisher.xml")

	--//Craftsmerm House//

	local mermhouse_crafted = Recipe(
		"mermhouse_crafted", 
		{
		Ingredient("boards", 4), 
		Ingredient("cutreeds", 6), 
		Ingredient("fish", 4)
		},
		RECIPETABS.TOWN, 
		TECH.SCIENCE_ONE)
		
		mermhouse_crafted.placer = "mermhouse_crafted_placer"
		mermhouse_crafted.atlas = "images/inventoryimages/mermhouse_crafted.xml"	
		if IsDLCEnabled(3) then
			mermhouse_crafted.game_type = "hamlet" 
		elseif IsDLCEnabled(2) then
			mermhouse_crafted.game_type = "rog"
		end

	local mermhouse_crafted_sw = Recipe(
		"mermhouse_crafted", 
		{
		Ingredient("boards", 4), 
		Ingredient("cutreeds", 6), 
		Ingredient("tropical_fish", 4)
		},
		RECIPETABS.TOWN, 
		TECH.SCIENCE_ONE,
		"shipwrecked",
		"mermhouse_crafted_placer",
		"images/inventoryimages/mermhouse_crafted.xml")]]

	--//Merm Flort-ifications//

	local mermwatchtower = Recipe(
		"mermwatchtower", 
		{
		Ingredient("boards", 5), 
		Ingredient("tentaclespots", 2), 
		Ingredient("spear", 4)
		},
		RECIPETABS.TOWN, 
		TECH.SCIENCE_ONE)
		
		mermwatchtower.placer = "mermwatchtower_placer"
		mermwatchtower.atlas = "images/inventoryimages/mermwatchtower.xml"
		if IsDLCEnabled(3) or IsDLCEnabled(2) then
			mermwatchtower.game_type = "common" 
		end

----------------------------------------------------------------------------------------------------------------------------
--#3 Strings

if _S.CHARACTERS.WALANI == nil then _S.CHARACTERS.WALANI = { DESCRIBE = {},} end -- DLC002
if _S.CHARACTERS.WARBUCKS == nil then _S.CHARACTERS.WARBUCKS = { DESCRIBE = {},} end -- DLC003
if _S.CHARACTERS.WARLY == nil then _S.CHARACTERS.WARLY = { DESCRIBE = {},} end -- DLC002
if _S.CHARACTERS.WATHGRITHR == nil then _S.CHARACTERS.WATHGRITHR = { DESCRIBE = {},} end -- DLC001
if _S.CHARACTERS.WEBBER == nil then _S.CHARACTERS.WEBBER = { DESCRIBE = {},} end -- DLC001
if _S.CHARACTERS.WHEELER == nil then _S.CHARACTERS.WHEELER = { DESCRIBE = {},} end -- DLC003
if _S.CHARACTERS.WILBA == nil then _S.CHARACTERS.WILBA = { DESCRIBE = {},} end -- DLC003
if _S.CHARACTERS.WINONA == nil then _S.CHARACTERS.WINONA = { DESCRIBE = {},} end -- DST
if _S.CHARACTERS.WOODLEGS == nil then _S.CHARACTERS.WOODLEGS = { DESCRIBE = {},} end -- DLC002
if _S.CHARACTERS.WORMWOOD == nil then _S.CHARACTERS.WORMWOOD = { DESCRIBE = {},} end -- DLC003
if _S.CHARACTERS.WORTOX == nil then _S.CHARACTERS.WORTOX = { DESCRIBE = {},} end -- DST
if _S.CHARACTERS.WURT == nil then _S.CHARACTERS.WURT = { DESCRIBE = {},} end -- DST

--//Mermhouse//
local IsSurvivalGameMode = not PrefabExists("volcano") and not PrefabExists("pig_palace")

if IsSurvivalGameMode then 
	_S.NAMES.MERMHOUSE = "Mermhouse" 
else 
	_S.NAMES.MERMHOUSE = "Merm Hut" 
end
_S.RECIPE_DESC.MERMHOUSE = "A crowded domicile for mermaid men."

--//Fishermerm's Hut//

_S.NAMES.MERMHOUSE_FISHER = "Fishermerm's Hut"
_S.RECIPE_DESC.MERMHOUSE_FISHER = "A dwelling for fish mongers."

_S.CHARACTERS.GENERIC.DESCRIBE.MERMHOUSE_FISHER = {"Who would live here?"}
_S.CHARACTERS.WAGSTAFF.DESCRIBE.MERMHOUSE_FISHER = {"What are they getting up to in there?"}
_S.CHARACTERS.WALANI.DESCRIBE.MERMHOUSE_FISHER = {"I could have sworn this was an outhouse."}
_S.CHARACTERS.WARLY.DESCRIBE.MERMHOUSE_FISHER = {"Fisherfolk live here. I can smell it."}
_S.CHARACTERS.WATHGRITHR.DESCRIBE.MERMHOUSE_FISHER = {"Is this dwelling made öf fish?"}
_S.CHARACTERS.WAXWELL.DESCRIBE.MERMHOUSE_FISHER = {"They copied the pigs, but they're even less intelligent."}
_S.CHARACTERS.WEBBER.DESCRIBE.MERMHOUSE_FISHER = {"Smells fishy."}
_S.CHARACTERS.WENDY.DESCRIBE.MERMHOUSE_FISHER = {"Time has broken it down."}
_S.CHARACTERS.WHEELER.DESCRIBE.MERMHOUSE_FISHER = {"Nice house. Could do with some air freshener though."}
_S.CHARACTERS.WILBA.DESCRIBE.MERMHOUSE_FISHER = {"MERMAID MAN ABODES"}
_S.CHARACTERS.WICKERBOTTOM.DESCRIBE.MERMHOUSE_FISHER = {"Obviously dilapidated."}
_S.CHARACTERS.WILLOW.DESCRIBE.MERMHOUSE_FISHER = {"No one would care if this burned down."}
_S.CHARACTERS.WINONA.DESCRIBE.MERMHOUSE_FISHER = {"I could disassemble that."}
_S.CHARACTERS.WOLFGANG.DESCRIBE.MERMHOUSE_FISHER = {"The house was not strong enough."}
_S.CHARACTERS.WOODIE.DESCRIBE.MERMHOUSE_FISHER = {"They're not the handiest."}
_S.CHARACTERS.WOODLEGS.DESCRIBE.MERMHOUSE_FISHER = {"I don't trust 'em."}
_S.CHARACTERS.WORMWOOD.DESCRIBE.MERMHOUSE_FISHER = {"Glub Glub Man home"}
_S.CHARACTERS.WORTOX.DESCRIBE.MERMHOUSE_FISHER = {"A stinky structure, to be sure."}
_S.CHARACTERS.WURT.DESCRIBE.MERMHOUSE_FISHER = {"Home is where the swamp is, flort."}
_S.CHARACTERS.WX78.DESCRIBE.MERMHOUSE_FISHER = {"OUTDATED ABODE"}

--//Craftsmerm House//

_S.NAMES.MERMHOUSE_CRAFTED = "Craftsmerm House"
_S.RECIPE_DESC.MERMHOUSE_CRAFTED = "A home fit for a Merm."

_S.CHARACTERS.GENERIC.DESCRIBE.MERMHOUSE_CRAFTED = {"It's actually kind of cute."}
_S.CHARACTERS.WARLY.DESCRIBE.MERMHOUSE_CRAFTED = {"Oh! It looks... very nice!"}
_S.CHARACTERS.WATHGRITHR.DESCRIBE.MERMHOUSE_CRAFTED = {"A home fit for a fish beast."}
_S.CHARACTERS.WAXWELL.DESCRIBE.MERMHOUSE_CRAFTED = {"It's slightly less offensive to my eyes than the others."}
_S.CHARACTERS.WEBBER.DESCRIBE.MERMHOUSE_CRAFTED = {"What a funny little house."}
_S.CHARACTERS.WENDY.DESCRIBE.MERMHOUSE_CRAFTED = {"It has not yet been touched by the ravages of time."}
_S.CHARACTERS.WICKERBOTTOM.DESCRIBE.MERMHOUSE_CRAFTED = {"It's good to see her doing something constructive."}
_S.CHARACTERS.WILLOW.DESCRIBE.MERMHOUSE_CRAFTED = {"Looks just as flammable as the old ones."}
_S.CHARACTERS.WINONA.DESCRIBE.MERMHOUSE_CRAFTED = {"Hm, I should teach that kid how to use a level."}
_S.CHARACTERS.WOLFGANG.DESCRIBE.MERMHOUSE_CRAFTED = {"Is house for fish men!"}
_S.CHARACTERS.WOODIE.DESCRIBE.MERMHOUSE_CRAFTED = {"Reminds me of the first house we built, eh Lucy?"}
_S.CHARACTERS.WORMWOOD.DESCRIBE.MERMHOUSE_CRAFTED = {"Glub Glub house"}
_S.CHARACTERS.WORTOX.DESCRIBE.MERMHOUSE_CRAFTED = {"An abode fit for a toad, hyuyu!"}
_S.CHARACTERS.WURT.DESCRIBE.MERMHOUSE_CRAFTED = {"Made it with own claws!"}
_S.CHARACTERS.WX78.DESCRIBE.MERMHOUSE_CRAFTED = {"IT IS UGLY"}

--//Merm Flort-ificationss//

_S.NAMES.MERMWATCHTOWER = "Merm Flort-ifications"
_S.RECIPE_DESC.MERMWATCHTOWER = "."
