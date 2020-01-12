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
	if not (IsDLCEnabled(2) or IsDLCEnabled(3)) then --not replace existing mermfisher prefab in DLC0002/DLC0003
		--"mermfisher"
	end
}

Assets = 
{
	Asset("ATLAS", "images/inventoryimages/mermhouse.xml"),
    Asset("ATLAS", "images/inventoryimages/mermhouse_fisher.xml"),
	Asset("ATLAS", "images/inventoryimages/mermhouse_crafted.xml"),
	Asset("ATLAS", "minimap/mermhouse.xml"),
	Asset("ATLAS", "minimap/mermhouse_tropical.xml"),
	Asset("ATLAS", "minimap/mermhouse_crafted.xml"),
	Asset("ATLAS", "minimap/mermhouse_fisher.xml"),
}

AddMinimapAtlas("minimap/mermhouse.xml")
AddMinimapAtlas("minimap/mermhouse_tropical.xml")
AddMinimapAtlas("minimap/mermhouse_crafted.xml")
AddMinimapAtlas("minimap/mermhouse_fisher.xml")

if IsDLCEnabled(2) then	fish_type = "tropical_fish" else fish_type = "fish" end

------------------------------------------------------------------------------------------------------------------------------
--Recipe

local mermhouse = Recipe(
	"mermhouse", 
	{
	Ingredient("boards", GetModConfigData("boards_m")), 
	Ingredient("rocks", GetModConfigData("rocks_m")), 
	Ingredient(fish_type, GetModConfigData("fish_m")*2),
	},
	RECIPETABS.TOWN, 
	TECH.SCIENCE_ONE)
	mermhouse.placer = "mermhouse_placer"
	mermhouse.atlas = "images/inventoryimages/mermhouse.xml"
	if IsDLCEnabled(2) or IsDLCEnabled(3) then
		mermhouse.game_type = "common"
	end
	
local mermhouse_crafted = Recipe(
	"mermhouse_crafted", 
	{
	Ingredient("boards", GetModConfigData("boards_c")), 
	Ingredient("cutreeds", GetModConfigData("cutreeds_c")), 
	Ingredient(fish_type, GetModConfigData("fish_c")),
	},
	RECIPETABS.TOWN, 
	TECH.SCIENCE_ONE)
	mermhouse_crafted.placer = "mermhouse_crafted_placer"
	mermhouse_crafted.atlas = "images/inventoryimages/mermhouse_crafted.xml"
	if IsDLCEnabled(2) or IsDLCEnabled(3) then
		mermhouse_crafted.game_type = "common"
	end
	
local mermhouse_fisher = Recipe(
	"mermhouse_fisher", 
	{
	Ingredient("boards", GetModConfigData("boards_f")), 
	Ingredient("rocks", GetModConfigData("rocks_f")), 
	Ingredient(fish_type, GetModConfigData("fish_f")),
	},
	RECIPETABS.TOWN, 
	TECH.SCIENCE_ONE,
	RECIPE_GAME_TYPE.COMMON)
	mermhouse_fisher.placer = "mermhouse_fisher_placer"
	mermhouse_fisher.atlas = "images/inventoryimages/mermhouse_fisher.xml"
	if IsDLCEnabled(2) or IsDLCEnabled(3) then
		mermhouse_crafted.game_type = "common"
	end

----------------------------------------------------------------------------------------------------------------------------
--Strings

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

--Mermhouse
local IsVan = not (IsDLCEnabled(2) or IsDLCEnabled(3)) and not PrefabExists("acorn")
local IsRog = PrefabExists("acorn")

if IsVan or IsRog then 
	_S.NAMES.MERMHOUSE = "Mermhouse" 
else 
	_S.NAMES.MERMHOUSE = "Merm Hut" 
end
_S.RECIPE_DESC.MERMHOUSE = "A crowded domicile for mermaid men."

--Mermhouse_crafted
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

--Mermhouse_fisher
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
