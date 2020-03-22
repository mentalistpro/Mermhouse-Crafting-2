PrefabFiles = 
{
    "mermhouses",
    "mermheadplacer",
    "pigheadplacer"
}

Assets = 
{
    Asset("ATLAS", "images/inventoryimages/mermhouse.xml"),
    Asset("ATLAS", "images/inventoryimages/mermhouse_fisher.xml"),
    Asset("ATLAS", "images/inventoryimages/mermhouse_crafted.xml"),
    Asset("ATLAS", "images/inventoryimages/mermhouse_crafted_fisher.xml"),
    Asset("ATLAS", "images/inventoryimages/mermwatchtower.xml"),
    Asset("ATLAS", "images/inventoryimages/mermhead.xml"),
    Asset("ATLAS", "images/inventoryimages/pighead.xml"),
    Asset("ATLAS", "minimap/mermhouse.xml"),
    Asset("ATLAS", "minimap/mermhouse_tropical.xml"),
    Asset("ATLAS", "minimap/mermhouse_fisher.xml"),
    Asset("ATLAS", "minimap/mermhouse_crafted.xml"),
    Asset("ATLAS", "minimap/mermhouse_crafted_fisher.xml"),
    Asset("ATLAS", "minimap/mermwatchtower.xml"),
}

AddMinimapAtlas("minimap/mermhouse.xml")
AddMinimapAtlas("minimap/mermhouse_tropical.xml")
AddMinimapAtlas("minimap/mermhouse_fisher.xml")
AddMinimapAtlas("minimap/mermhouse_crafted.xml")
AddMinimapAtlas("minimap/mermhouse_crafted_fisher.xml")
AddMinimapAtlas("minimap/mermwatchtower.xml")

------------------------------------------------------------------------------------------------------------------------------

--[[CONTENT]]
--#1 Config
--#2 Recipes
--#3 Strings

------------------------------------------------------------------------------------------------------------------------------
--#1 Config

TUNING.MERMHOUSE_MINIMAP_ICON = GetModConfigData("icon")
--TUNING.MERMHOUSE_FISH_NUMBER = GetModConfigData("fish")

--Remove prefab dependencies, thus reduce log spam

local _ctor = Prefab._ctor
Prefab._ctor = function(self, ...)
    _ctor(self, ...)
    local k = 0
    for i, v in ipairs(self.deps) do
        if v == "mermhouse" or v == "mermhouse_fisher" or v == "mermhouse_crafted" or v == "mermhouse_crafted_fisher" or v == "mermwatchtower" then
            k = i
            break
        end
    end
    if k > 0 then
        table.remove(self.deps, k)
    end
end

------------------------------------------------------------------------------------------------------------------------------
--#2 Recipes

local _G = GLOBAL
local require = _G.require
local Ingredient = _G.Ingredient
local IsDLCEnabled = _G.IsDLCEnabled 
local Recipe = _G.Recipe
local RECIPETABS = _G.RECIPETABS
local RECIPE_GAME_TYPE = _G.RECIPE_GAME_TYPE
local TECH = _G.TECH

--Mermhouse

if IsDLCEnabled and ( IsDLCEnabled(2) or IsDLCEnabled(3) ) then
    local mermhouse = Recipe(                                 
        "mermhouse", 
        {
            Ingredient("boards", 4), 
            Ingredient("rocks", 9), 
            Ingredient("tropical_fish", 8)   
        },
        RECIPETABS.TOWN, TECH.SCIENCE_ONE, "shipwrecked")
        mermhouse.placer = "mermhouse_tropical_placer"
        mermhouse.atlas = "images/inventoryimages/mermhouse.xml"
end

local mermhouse = Recipe(                                 
    "mermhouse", 
    {
        Ingredient("boards", 4), 
        Ingredient("rocks", 9), 
        Ingredient("fish", 8)   
    },
    RECIPETABS.TOWN, TECH.SCIENCE_ONE)
    mermhouse.placer = "mermhouse_placer"
    mermhouse.atlas = "images/inventoryimages/mermhouse.xml"

--Fishermerm's Hut

if IsDLCEnabled and ( IsDLCEnabled(2) or IsDLCEnabled(3) ) then
    local mermhouse_fisher = Recipe(                                 
        "mermhouse_fisher", 
        {
            Ingredient("boards", 4), 
            Ingredient("rocks", 9), 
            Ingredient("tropical_fish", 8),
            Ingredient("fishingrod", 2)
        },
        RECIPETABS.TOWN, TECH.SCIENCE_ONE, "shipwrecked")
        mermhouse_fisher.placer = "mermhouse_fisher_placer"
        mermhouse_fisher.atlas = "images/inventoryimages/mermhouse_fisher.xml"
end

local mermhouse_fisher = Recipe(                                 
    "mermhouse_fisher", 
    {
        Ingredient("boards", 4), 
        Ingredient("rocks", 9), 
        Ingredient("fish", 8),
        Ingredient("fishingrod", 2)
    },
    RECIPETABS.TOWN, TECH.SCIENCE_ONE)
    mermhouse_fisher.placer = "mermhouse_fisher_placer"
    mermhouse_fisher.atlas = "images/inventoryimages/mermhouse_fisher.xml"

--Craftsmerm House

if IsDLCEnabled and ( IsDLCEnabled(2) or IsDLCEnabled(3) ) then
    local mermhouse_crafted = Recipe(                                 
        "mermhouse_crafted", 
        {
            Ingredient("boards", 4), 
            Ingredient("cutreeds", 3),
            Ingredient("tropical_fish", 2)
        },
        RECIPETABS.TOWN, TECH.SCIENCE_ONE, "shipwrecked")
        mermhouse_crafted.placer = "mermhouse_crafted_placer"
        mermhouse_crafted.atlas = "images/inventoryimages/mermhouse_crafted.xml"
end

local mermhouse_crafted = Recipe(                                 
    "mermhouse_crafted", 
    {
        Ingredient("boards", 4), 
        Ingredient("cutreeds", 3),
        Ingredient("fish", 2)
    },
    RECIPETABS.TOWN, TECH.SCIENCE_ONE)
    mermhouse_crafted.placer = "mermhouse_crafted_placer"
    mermhouse_crafted.atlas = "images/inventoryimages/mermhouse_crafted.xml"

--Craftsmerm Fishing House

if IsDLCEnabled and ( IsDLCEnabled(2) or IsDLCEnabled(3) ) then
    local mermhouse_crafted_fisher = Recipe( 
        "mermhouse_crafted_fisher", 
        {
            Ingredient("boards", 4), 
            Ingredient("cutreeds", 3),
            Ingredient("tropical_fish", 2),
            Ingredient("fishingrod", 2)
        },
        RECIPETABS.TOWN, TECH.SCIENCE_ONE, "shipwrecked")
        mermhouse_crafted_fisher.placer = "mermhouse_crafted_fisher_placer"
        mermhouse_crafted_fisher.atlas = "images/inventoryimages/mermhouse_crafted_fisher.xml"
end

local mermhouse_crafted_fisher = Recipe(
    "mermhouse_crafted_fisher", 
    {
        Ingredient("boards", 4), 
        Ingredient("cutreeds", 3),
        Ingredient("fish", 2),
        Ingredient("fishingrod", 2)
    },
    RECIPETABS.TOWN, TECH.SCIENCE_ONE)
    mermhouse_crafted_fisher.placer = "mermhouse_crafted_fisher_placer"
    mermhouse_crafted_fisher.atlas = "images/inventoryimages/mermhouse_crafted_fisher.xml"
 
--Merm Flort-ifications

local mermwatchtower = Recipe(                    
    "mermwatchtower", 
    {
        Ingredient("boards", 5), 
        Ingredient("tentaclespots", 1), 
        Ingredient("spear", 2)
    },
    RECIPETABS.TOWN, TECH.SCIENCE_TWO)

    if IsDLCEnabled and ( IsDLCEnabled(1) or IsDLCEnabled(2) or IsDLCEnabled(3) ) then
        mermwatchtower.game_type = "common"
    end 
    mermwatchtower.placer = "mermwatchtower_placer"
    mermwatchtower.atlas = "images/inventoryimages/mermwatchtower.xml"
 
--Merm Head

local mermhead = Recipe(           
    "mermhead", 
    {
        Ingredient("spoiled_food", 4), 
        Ingredient("twigs", 4), 
    },
    RECIPETABS.TOWN, TECH.SCIENCE_ONE)

    if IsDLCEnabled and ( IsDLCEnabled(1) or IsDLCEnabled(2) or IsDLCEnabled(3) ) then
        mermhead.game_type = "common"
    end 
    mermhead.placer = "mermhead_placer"
    mermhead.atlas = "images/inventoryimages/mermhead.xml"

AddPrefabPostInit("mermhead", 
    function(inst)
        inst.components.lootdropper:SetLoot({"spoiled_food", "twigs"}) --add on top of existing loot drop
    end
) 

--Pig Head

local pighead = Recipe(                             
    "pighead", 
    {
        Ingredient("pigskin", 4), 
        Ingredient("twigs", 4), 
    },
    RECIPETABS.TOWN, TECH.SCIENCE_ONE)

    if IsDLCEnabled and ( IsDLCEnabled(1) or IsDLCEnabled(2) or IsDLCEnabled(3) ) then
        pighead.game_type = "common" 
    end 
    pighead.placer = "pighead_placer"
    pighead.atlas = "images/inventoryimages/pighead.xml"

AddPrefabPostInit("pighead", 
    function(inst)
        inst.components.lootdropper:SetLoot({"pigskin", "twigs"}) --add on top of existing loot drop
    end
)

----------------------------------------------------------------------------------------------------------------------------
--#3 Strings

local _S = _G.STRINGS

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
if IsDLCEnabled and ( IsDLCEnabled(2) or IsDLCEnabled(3) ) then
    _S.NAMES.MERMHOUSE = "Merm Hut" 
end
_S.NAMES.MERMHOUSE = "Mermhouse" 

_S.RECIPE_DESC.MERMHOUSE = "A crowded domicile for mermaid men."

--Fishermerm's Hut

_S.NAMES.MERMHOUSE_FISHER = "Fishermerm's Hut"
_S.RECIPE_DESC.MERMHOUSE_FISHER = "A dwelling for fish mongers."

_S.CHARACTERS.GENERIC.DESCRIBE.MERMHOUSE_FISHER         = {"Who would live here?"}
_S.CHARACTERS.WAGSTAFF.DESCRIBE.MERMHOUSE_FISHER        = {"What are they getting up to in there?"}
_S.CHARACTERS.WALANI.DESCRIBE.MERMHOUSE_FISHER          = {"I could have sworn this was an outhouse."}
_S.CHARACTERS.WARLY.DESCRIBE.MERMHOUSE_FISHER           = {"Fisherfolk live here. I can smell it."}
_S.CHARACTERS.WATHGRITHR.DESCRIBE.MERMHOUSE_FISHER      = {"Is this dwelling made öf fish?"}
_S.CHARACTERS.WAXWELL.DESCRIBE.MERMHOUSE_FISHER         = {"They copied the pigs, but they're even less intelligent."}
_S.CHARACTERS.WEBBER.DESCRIBE.MERMHOUSE_FISHER          = {"Smells fishy."}
_S.CHARACTERS.WENDY.DESCRIBE.MERMHOUSE_FISHER           = {"Time has broken it down."}
_S.CHARACTERS.WHEELER.DESCRIBE.MERMHOUSE_FISHER         = {"Nice house. Could do with some air freshener though."}
_S.CHARACTERS.WILBA.DESCRIBE.MERMHOUSE_FISHER           = {"MERMAID MAN ABODES"}
_S.CHARACTERS.WICKERBOTTOM.DESCRIBE.MERMHOUSE_FISHER    = {"Obviously dilapidated."}
_S.CHARACTERS.WILLOW.DESCRIBE.MERMHOUSE_FISHER          = {"No one would care if this burned down."}
_S.CHARACTERS.WINONA.DESCRIBE.MERMHOUSE_FISHER          = {"I could disassemble that."}
_S.CHARACTERS.WOLFGANG.DESCRIBE.MERMHOUSE_FISHER        = {"The house was not strong enough."}
_S.CHARACTERS.WOODIE.DESCRIBE.MERMHOUSE_FISHER          = {"They're not the handiest."}
_S.CHARACTERS.WOODLEGS.DESCRIBE.MERMHOUSE_FISHER        = {"I don't trust 'em."}
_S.CHARACTERS.WORMWOOD.DESCRIBE.MERMHOUSE_FISHER        = {"Glub Glub Man home"}
_S.CHARACTERS.WORTOX.DESCRIBE.MERMHOUSE_FISHER          = {"A stinky structure, to be sure."}
_S.CHARACTERS.WURT.DESCRIBE.MERMHOUSE_FISHER            = {"Home is where the swamp is, flort."}
_S.CHARACTERS.WX78.DESCRIBE.MERMHOUSE_FISHER            = {"OUTDATED ABODE"}

--Craftsmerm House

_S.NAMES.MERMHOUSE_CRAFTED = "Craftsmerm House"
_S.RECIPE_DESC.MERMHOUSE_CRAFTED = "A home fit for a Merm."

_S.CHARACTERS.GENERIC.DESCRIBE.MERMHOUSE_CRAFTED        = {"It's actually kind of cute."}
_S.CHARACTERS.WARLY.DESCRIBE.MERMHOUSE_CRAFTED          = {"Oh! It looks... very nice!"}
_S.CHARACTERS.WATHGRITHR.DESCRIBE.MERMHOUSE_CRAFTED     = {"A home fit for a fish beast."}
_S.CHARACTERS.WAXWELL.DESCRIBE.MERMHOUSE_CRAFTED        = {"It's slightly less offensive to my eyes than the others."}
_S.CHARACTERS.WEBBER.DESCRIBE.MERMHOUSE_CRAFTED         = {"What a funny little house."}
_S.CHARACTERS.WENDY.DESCRIBE.MERMHOUSE_CRAFTED          = {"It has not yet been touched by the ravages of time."}
_S.CHARACTERS.WICKERBOTTOM.DESCRIBE.MERMHOUSE_CRAFTED   = {"It's good to see her doing something constructive."}
_S.CHARACTERS.WILLOW.DESCRIBE.MERMHOUSE_CRAFTED         = {"Looks just as flammable as the old ones."}
_S.CHARACTERS.WINONA.DESCRIBE.MERMHOUSE_CRAFTED         = {"Hm, I should teach that kid how to use a level."}
_S.CHARACTERS.WOLFGANG.DESCRIBE.MERMHOUSE_CRAFTED       = {"Is house for fish men!"}
_S.CHARACTERS.WOODIE.DESCRIBE.MERMHOUSE_CRAFTED         = {"Reminds me of the first house we built, eh Lucy?"}
_S.CHARACTERS.WORMWOOD.DESCRIBE.MERMHOUSE_CRAFTED       = {"Glub Glub house"}
_S.CHARACTERS.WORTOX.DESCRIBE.MERMHOUSE_CRAFTED         = {"An abode fit for a toad, hyuyu!"}
_S.CHARACTERS.WURT.DESCRIBE.MERMHOUSE_CRAFTED           = {"Made it with own claws!"}
_S.CHARACTERS.WX78.DESCRIBE.MERMHOUSE_CRAFTED           = {"IT IS UGLY"}

--Craftsmerm Fishing House

_S.NAMES.MERMHOUSE_CRAFTED_FISHER = "Craftsmerm Fishing House"
_S.RECIPE_DESC.MERMHOUSE_CRAFTED_FISHER = "A home fit for a Fisher."

_S.CHARACTERS.GENERIC.DESCRIBE.MERMHOUSE_CRAFTED        = {"It's actually kind of cute."}
_S.CHARACTERS.WARLY.DESCRIBE.MERMHOUSE_CRAFTED          = {"Oh! It looks... very nice!"}
_S.CHARACTERS.WATHGRITHR.DESCRIBE.MERMHOUSE_CRAFTED     = {"A home fit for a fish beast."}
_S.CHARACTERS.WAXWELL.DESCRIBE.MERMHOUSE_CRAFTED        = {"It's slightly less offensive to my eyes than the others."}
_S.CHARACTERS.WEBBER.DESCRIBE.MERMHOUSE_CRAFTED         = {"What a funny little house."}
_S.CHARACTERS.WENDY.DESCRIBE.MERMHOUSE_CRAFTED          = {"It has not yet been touched by the ravages of time."}
_S.CHARACTERS.WICKERBOTTOM.DESCRIBE.MERMHOUSE_CRAFTED   = {"It's good to see her doing something constructive."}
_S.CHARACTERS.WILLOW.DESCRIBE.MERMHOUSE_CRAFTED         = {"Looks just as flammable as the old ones."}
_S.CHARACTERS.WINONA.DESCRIBE.MERMHOUSE_CRAFTED         = {"Hm, I should teach that kid how to use a level."}
_S.CHARACTERS.WOLFGANG.DESCRIBE.MERMHOUSE_CRAFTED       = {"Is house for fish men!"}
_S.CHARACTERS.WOODIE.DESCRIBE.MERMHOUSE_CRAFTED         = {"Reminds me of the first house we built, eh Lucy?"}
_S.CHARACTERS.WORMWOOD.DESCRIBE.MERMHOUSE_CRAFTED       = {"Glub Glub house"}
_S.CHARACTERS.WORTOX.DESCRIBE.MERMHOUSE_CRAFTED         = {"An abode fit for a toad, hyuyu!"}
_S.CHARACTERS.WURT.DESCRIBE.MERMHOUSE_CRAFTED           = {"Made it with own claws!"}
_S.CHARACTERS.WX78.DESCRIBE.MERMHOUSE_CRAFTED           = {"IT IS UGLY"}

--Merm Flort-ificationss

_S.NAMES.MERMWATCHTOWER = "Merm Flort-ifications"
_S.RECIPE_DESC.MERMWATCHTOWER = "True warriors live within."

_S.CHARACTERS.GENERIC.DESCRIBE.MERMWATCHTOWER       = {"A royal guard with no Royal to guard."}
_S.CHARACTERS.WARLY.DESCRIBE.MERMWATCHTOWER         = {"They don't look so friendly now..."}
_S.CHARACTERS.WATHGRITHR.DESCRIBE.MERMWATCHTOWER    = {"They are lost without their chieftain."}
_S.CHARACTERS.WAXWELL.DESCRIBE.MERMWATCHTOWER       = {"A kingdom without a king."}
_S.CHARACTERS.WEBBER.DESCRIBE.MERMWATCHTOWER        = {"We better not get too close..."}
_S.CHARACTERS.WENDY.DESCRIBE.MERMWATCHTOWER         = {"They fight without purpose..."}
_S.CHARACTERS.WICKERBOTTOM.DESCRIBE.MERMWATCHTOWER  = {"A crude, but effective fortification."}
_S.CHARACTERS.WILLOW.DESCRIBE.MERMWATCHTOWER        = {"I bet that would catch fire reeeal easy."}
_S.CHARACTERS.WINONA.DESCRIBE.MERMWATCHTOWER        = {"It looks kinda gloomy."}
_S.CHARACTERS.WOLFGANG.DESCRIBE.MERMWATCHTOWER      = {"Is tree full of fish!"}
_S.CHARACTERS.WOODIE.DESCRIBE.MERMWATCHTOWER        = {"Feels like they're waiting for something."}
_S.CHARACTERS.WORMWOOD.DESCRIBE.MERMWATCHTOWER      = {"Glub Glubs inside"}
_S.CHARACTERS.WORTOX.DESCRIBE.MERMWATCHTOWER        = {"Guards with no king, like puppets with no string."}
_S.CHARACTERS.WURT.DESCRIBE.MERMWATCHTOWER          = {"Royal guard need King to protect..."}
_S.CHARACTERS.WX78.DESCRIBE.MERMWATCHTOWER          = {"STATUS: INACTIVE"}

--Merm Head and Pig Head
_S.NAMES.MERMHEAD = "Merm Head"
_S.RECIPE_DESC.MERMHEAD = "A rotten head of a warrior."

_S.CHARACTERS.WINONA.DESCRIBE.MERMHEAD  = {  GENERIC = "I'd better hammer down that eyesore.",
                                            BURNT = "Hooboy, that's a powerful stench." }
_S.CHARACTERS.WORTOX.DESCRIBE.MERMHEAD  = {  GENERIC = "Yuck.",
                                            BURNT = "Goodbye, revolting pighead." }
_S.CHARACTERS.WURT.DESCRIBE.MERMHEAD    =   {  GENERIC = "Who do such thing...",
                                            BURNT = "Glurp..." }

_S.NAMES.PIGHEAD = "Pig Head"
_S.RECIPE_DESC.PIGHEAD = "Looks intact but rotten inside."

_S.CHARACTERS.WINONA.DESCRIBE.PIGHEAD   =  {  GENERIC = "I should hammer down that eyesore.",
                                            BURNT = "What a waste of materials." }
_S.CHARACTERS.WORTOX.DESCRIBE.PIGHEAD   =  {  GENERIC = "I guess there are more distasteful things than soul consumption.",
                                            BURNT = "So long, repulsive head." }
_S.CHARACTERS.WURT.DESCRIBE.PIGHEAD     =    {  GENERIC = "Ha ha!",
                                            BURNT = "Crispy Pig!"  }