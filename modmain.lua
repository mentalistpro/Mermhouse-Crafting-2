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
	Asset("ATLAS", "images/inventoryimages/mermhouse_crafted_fisher.xml"),
	Asset("ATLAS", "images/inventoryimages/mermwatchtower.xml"),
	Asset("ATLAS", "minimap/mermhouse.xml"),
	Asset("ATLAS", "minimap/mermhouse_tropical.xml"),
	Asset("ATLAS", "minimap/mermhouse_fisher.xml"),
	Asset("ATLAS", "minimap/mermhouse_crafted.xml"),
	Asset("ATLAS", "minimap/mermhouse_crafted_fisher.xml"),
	Asset("ATLAS", "minimap/mermwatchtower.xml")
}

AddMinimapAtlas("minimap/mermhouse.xml")
AddMinimapAtlas("minimap/mermhouse_tropical.xml")
AddMinimapAtlas("minimap/mermhouse_fisher.xml")
AddMinimapAtlas("minimap/mermhouse_crafted.xml")
AddMinimapAtlas("minimap/mermhouse_crafted_fisher.xml")
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
TUNING.MOD_MERMHOUSE_FISHER_MINIMAP = GetModConfigData("mf_icon")
TUNING.MOD_MERMHOUSE_CRAFTED_MINIMAP = GetModConfigData("mc_icon")
TUNING.MOD_MERMHOUSE_CRAFTED_FISHER_MINIMAP = GetModConfigData("mcf_icon")
TUNING.MOD_MERMWATCHTOWER_MINIMAP = GetModConfigData("mw_icon")

------------------------------------------------------------------------------------------------------------------------------
--#2 Recipes

local f = {"fish", "tropical_fish"}
local g = {"rog", "shipwrecked", "porkland", "common"}
local p = {"mermhouse_placer", "mermhouse_tropical_placer", "mermhouse_fisher_placer", "mermhouse_crafted_placer", "mermhouse_crafted_fisher_placer", "mermwatchtower_placer"}
local mermhouse_atlas = "images/inventoryimages/mermhouse.xml"
local mermhouse_fisher_atlas = "images/inventoryimages/mermhouse_fisher.xml"
local mermhouse_crafted_atlas = "images/inventoryimages/mermhouse_crafted.xml"
local mermhouse_crafted_fisher_atlas = "images/inventoryimages/mermhouse_crafted_fisher.xml"
local mermwatchtower_atlas = "images/inventoryimages/mermwatchtower.xml"

--//Mermhouse//

if IsDLCEnabled(2) or IsDLCEnabled(3) then
	local mermhouse_rog = Recipe(							--register recipe at ROG world, so SW and HAM recipes won't replace ROG recipe.
		"mermhouse", 
		{
		Ingredient("boards", 4), 
		Ingredient("rocks", 9), 
		Ingredient(f[1], 8)									
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE, g[1], p[1])		
		mermhouse_rog.atlas = mermhouse_atlas
		
	local mermhouse_sw = Recipe(							--register recipe at SW world.
		"mermhouse", 
		{
		Ingredient("boards", 4), 
		Ingredient("rocks", 9), 
		Ingredient(f[2], 8)									
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE, g[2], p[2])		
		mermhouse_sw.atlas = mermhouse_atlas

	local mermhouse_ham = Recipe(							--register recipe at HAM world.
		"mermhouse", 
		{
		Ingredient("boards", 4), 
		Ingredient("rocks", 9), 
		Ingredient(f[1], 8)									
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE, g[3], p[2])		
		mermhouse_ham.atlas = mermhouse_atlas

else
	local mermhouse = Recipe(								--register recipe at Vanilla world.
		"mermhouse", 
		{
		Ingredient("boards", 4), 
		Ingredient("rocks", 9), 
		Ingredient(f[1], 8)									
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE, p[1])
		mermhouse.atlas = mermhouse_atlas
end
		
--//Fishermerm's Hut//

if IsDLCEnabled(2) or IsDLCEnabled(3) then
	local mermhouse_fisher = Recipe(						--register recipe at ROG/HAM world.
		"mermhouse_fisher", 
		{
		Ingredient("boards", 4), 
		Ingredient("rocks", 9), 
		Ingredient(f[1], 8),
		Ingredient("fishingrod",2)
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE, g[4], p[3])
		mermhouse_fisher.atlas = mermhouse_fisher_atlas
		
	local mermhouse_fisher_sw = Recipe(						--register recipe at SW world.
		"mermhouse_fisher", 
		{
		Ingredient("boards", 4), 
		Ingredient("rocks", 9), 
		Ingredient(f[2], 8),
		Ingredient("fishingrod",2)
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE, g[2], p[3])
		mermhouse_fisher_sw.atlas = mermhouse_fisher_atlas
else
	local mermhouse_fisher = Recipe(						--register recipe at Vanilla world.
		"mermhouse_fisher", 
		{
		Ingredient("boards", 4), 
		Ingredient("rocks", 9), 
		Ingredient(f[1], 8),
		Ingredient("fishingrod",2)
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE, p[3])
		mermhouse_fisher.atlas = mermhouse_fisher_atlas
end

--//Craftsmerm House//

if IsDLCEnabled(2) or IsDLCEnabled(3) then
	local mermhouse_crafted = Recipe(						--register recipe at ROG/HAM world.
		"mermhouse_crafted", 
		{
		Ingredient("boards", 4), 
		Ingredient("cutreeds", 3), 
		Ingredient(f[1], 2)
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE, g[4], p[4])
		mermhouse_crafted.atlas = mermhouse_crafted_atlas

	local mermhouse_crafted_sw = Recipe(					--register recipe at SW world.
		"mermhouse_crafted", 
		{
		Ingredient("boards", 4), 
		Ingredient("cutreeds", 3), 
		Ingredient(f[2], 2)
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE, g[2], p[4])
		mermhouse_crafted_sw.atlas = mermhouse_crafted_atlas
else
	local mermhouse_crafted = Recipe(						--register recipe at Vanilla world.
		"mermhouse_crafted", 
		{
		Ingredient("boards", 4), 
		Ingredient("cutreeds", 3), 
		Ingredient(f[1], 2)
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE, p[4])
		mermhouse_crafted.atlas = mermhouse_crafted_atlas	
end

--//Craftsmerm Fishing House//

if IsDLCEnabled(2) or IsDLCEnabled(3) then
	local mermhouse_crafted_fisher = Recipe(				--register recipe at ROG/HAM world.
		"mermhouse_crafted_fisher", 
		{
		Ingredient("boards", 4), 
		Ingredient("cutreeds", 3), 
		Ingredient(f[1], 2),
		Ingredient("fishingrod",2)
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE, g[4], p[5])
		mermhouse_crafted_fisher.atlas = mermhouse_crafted_fisher_atlas

	local mermhouse_crafted_fisher_sw = Recipe(					--register recipe at SW world.
		"mermhouse_crafted_fisher", 
		{
		Ingredient("boards", 4), 
		Ingredient("cutreeds", 3), 
		Ingredient(f[2], 2),
		Ingredient("fishingrod",2)
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE, g[2], p[5])
		mermhouse_crafted_fisher_sw.atlas = mermhouse_crafted_fisher_atlas
else
	local mermhouse_crafted_fisher = Recipe(						--register recipe at Vanilla world.
		"mermhouse_crafted_fisher", 
		{
		Ingredient("boards", 4), 
		Ingredient("cutreeds", 3), 
		Ingredient(f[1], 2),
		Ingredient("fishingrod",2)
		},
		RECIPETABS.TOWN, TECH.SCIENCE_ONE, p[5])
		mermhouse_crafted_fisher.atlas = mermhouse_crafted_fisher_atlas	
end

--//Merm Flort-ifications//

local mermwatchtower = Recipe(								--register recipe at Vanilla world.
	"mermwatchtower", 
	{
	Ingredient("boards", 5), 
	Ingredient("tentaclespots", 2), 
	Ingredient("spear", 4)
	},
	RECIPETABS.TOWN, TECH.SCIENCE_TWO)
	if IsDLCEnabled(2) or IsDLCEnabled(3) then				--register recipe at ROG/SW/HAM world.
		mermwatchtower.game_type = g[4] 
	end	
	mermwatchtower.placer = p[6]
	mermwatchtower.atlas = mermwatchtower_atlas

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
local IsSW = PrefabExists("volcano") 
local IsHAM = PrefabExists("pig_palace")

if IsSW or IsHAM then 
	_S.NAMES.MERMHOUSE = "Merm Hut" 
else
	_S.NAMES.MERMHOUSE = "Mermhouse" 
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

--//Craftsmerm Fishing House//

_S.NAMES.MERMHOUSE_CRAFTED_FISHER = "Craftsmerm Fishing House"
_S.RECIPE_DESC.MERMHOUSE_CRAFTED_FISHER = "A home fit for a Fisher."

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
_S.RECIPE_DESC.MERMWATCHTOWER = "True warriors live within."

_S.CHARACTERS.GENERIC.DESCRIBE.MERMWATCHTOWER = {"A royal guard with no Royal to guard."}
_S.CHARACTERS.WARLY.DESCRIBE.MERMWATCHTOWER = {"They don't look so friendly now..."}
_S.CHARACTERS.WATHGRITHR.DESCRIBE.MERMWATCHTOWER = {"They are lost without their chieftain."}
_S.CHARACTERS.WAXWELL.DESCRIBE.MERMWATCHTOWER = {"A kingdom without a king."}
_S.CHARACTERS.WEBBER.DESCRIBE.MERMWATCHTOWER = {"We better not get too close..."}
_S.CHARACTERS.WENDY.DESCRIBE.MERMWATCHTOWER = {"They fight without purpose..."}
_S.CHARACTERS.WICKERBOTTOM.DESCRIBE.MERMWATCHTOWER = {"A crude, but effective fortification."}
_S.CHARACTERS.WILLOW.DESCRIBE.MERMWATCHTOWER = {"I bet that would catch fire reeeal easy."}
_S.CHARACTERS.WINONA.DESCRIBE.MERMWATCHTOWER = {"It looks kinda gloomy."}
_S.CHARACTERS.WOLFGANG.DESCRIBE.MERMWATCHTOWER = {"Is tree full of fish!"}
_S.CHARACTERS.WOODIE.DESCRIBE.MERMWATCHTOWER = {"Feels like they're waiting for something."}
_S.CHARACTERS.WORMWOOD.DESCRIBE.MERMWATCHTOWER = {"Glub Glubs inside"}
_S.CHARACTERS.WORTOX.DESCRIBE.MERMWATCHTOWER = {"Guards with no king, like puppets with no string."}
_S.CHARACTERS.WURT.DESCRIBE.MERMWATCHTOWER = {"Royal guard need King to protect..."}
_S.CHARACTERS.WX78.DESCRIBE.MERMWATCHTOWER = {"STATUS: INACTIVE"}
