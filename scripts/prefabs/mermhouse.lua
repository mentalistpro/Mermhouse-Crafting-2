
--//Add compatability with other mods - noted prefab/mermhouse, prefab/mermhouse_fisher in this local file.

--[[inst.userfunctions =     
{        
	FollowPlayer = FollowPlayer,        
	GetPeepChance = GetPeepChance,        
	SpawnTeen = SpawnTeen,        
	SpawnAdult = SpawnAdult,    
}

local prefabs = 
{
	"smallbird", 
	"teenbird"
}
for k,v in pairs(prefabs) do    
AddPrefabPostInit(v, 
	function(inst)       
		local OldFollowPlayer = inst.userfunctions.FollowPlayer       
		inst.userfunctions.FollowPlayer = function(inst)           
			--whatever you want to change it to          
			--if necessary, you can have it do the old thing by calling OldFollowPlayer(inst)        
		end    
	end)
end]]



local assets = 
{
    Asset("ANIM", "anim/merm_house.zip"),
    Asset("ANIM", "anim/mermhouse_crafted.zip"),
	if not (SaveGameIndex:IsModePorkland or SaveGameIndex:IsModeShipwrecked) then --prevent anim duplication from DLC0002 and DLC0003
		Asset("ANIM", "anim/merm_sw_house.zip"),
		Asset("ANIM", "anim/merm_fisherman_house.zip"),
	end
	Asset("MINIMAP_IMAGE", "mermhouse_tropical"),
    Asset("MINIMAP_IMAGE", "mermhouse_crafted"),
}

local prefabs =
{
    "merm",
	"mermfisher",
    "collapse_big",

    --loot:
    "boards",
    "rocks",
    "fish",
}

local loot =
{
    "boards",
    "rocks",
    "fish",
}

local crafted_loot = 
{
    "boards",
    "rocks",
    "tropical_fish",
}

local function StartSpawning(inst)
	if not inst:HasTag("burnt") then
		if inst.components.childspawner and GetSeasonManager() and not GetSeasonManager():IsWinter() then
			inst.components.childspawner:StartSpawning()
		end
	end
end

local function StopSpawning(inst)
	if not inst:HasTag("burnt") then
		if inst.components.childspawner then
			inst.components.childspawner:StopSpawning()
		end
	end
end

local function OnSpawned(inst, child)
	if not inst:HasTag("burnt") then
		inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")
		if GetClock():IsDay() and inst.components.childspawner and inst.components.childspawner:CountChildrenOutside() >= 1 and not child.components.combat.target then
	        StopSpawning(inst)
	    end
	end
end

local function OnGoHome(inst, child) 
	if not inst:HasTag("burnt") then
		inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")
		if inst.components.childspawner and inst.components.childspawner:CountChildrenOutside() < 1 then
	        StartSpawning(inst)
	    end
	end
end

local function onhammered(inst, worker)
	if inst:HasTag("fire") and inst.components.burnable then
        inst.components.burnable:Extinguish()
    end
    inst:RemoveComponent("childspawner")
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_big").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function onhit(inst, worker)
	if not inst:HasTag("burnt") then
	    if inst.components.childspawner then
	        inst.components.childspawner:ReleaseAllChildren(worker)
	    end
		inst.AnimState:PlayAnimation("hit")
		inst.AnimState:PushAnimation("idle")
	end
end

local function onignite(inst)
    if inst.components.childspawner then
        inst.components.childspawner:ReleaseAllChildren()
    end
end

local function onburntup(inst)
    inst.AnimState:PlayAnimation("burnt")
end

local function OnIsDay(inst)
	StopSpawning(inst) 
end

local function OnIsDusk(inst)
	if GetSeasonManager() and not GetSeasonManager():IsWinter() then
		inst.components.childspawner:ReleaseAllChildren()
	end
	StartSpawning(inst)	
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end
end

local function onload(inst, data)
    if data and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
end

--------------------------------------------------------------------------------------------------------
--MakeMermHouse

local function MakeMermHouse(name, postinit)
	local function fn()
		local inst = CreateEntity()
		local trans = inst.entity:AddTransform()
		local anim = inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		local minimap = inst.entity:AddMiniMapEntity()

		MakeObstaclePhysics(inst, 1)
		MakeSnowCovered(inst, .01)
		MakeMediumBurnable(inst, nil, nil, true)
		MakeLargePropagator(inst)
		inst:ListenForEvent("onignite", onignite)
		inst:ListenForEvent("burntup", onburntup)
		
		inst:AddTag("mermhouse")
		inst:AddTag("structure")

		inst:AddComponent("inspectable")
		inst:AddComponent("lootdropper")
		
		inst:AddComponent("childspawner")
		inst.components.childspawner:SetSpawnedFn(OnSpawned)
		inst.components.childspawner:SetGoHomeFn(OnGoHome)
		
		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
		inst.components.workable:SetWorkLeft(2)
		inst.components.workable:SetOnFinishCallback(onhammered)
		inst.components.workable:SetOnWorkCallback(onhit)
		
		inst:ListenForEvent("dusktime", OnIsDusk, GetWorld())
		inst:ListenForEvent("daytime", OnIsDay, GetWorld())
		StartSpawning(inst)

        inst.OnSave = onsave
        inst.OnLoad = onload

        if postinit ~= nil then
            postinit(inst)
        end
		
		return inst
	end

	return Prefab("common/objects/"..name, fn, assets, prefabs)
end

--------------------------------------------------------------------------------------------------------
--Mermhouse

local function mermhouse_postinit(inst)
	if SaveGameIndex:IsModeShipwrecked() or SaveGameIndex:IsModePorkland() then
		inst.MiniMapEntity:SetIcon("mermhouse_tropical.tex")
		inst.AnimState:SetBank("merm_sw_house")
		inst.AnimState:SetBuild("merm_sw_house")
		inst.AnimState:PlayAnimation("idle")		
	else
		inst.MiniMapEntity:SetIcon("mermhouse.tex")
		inst.AnimState:SetBank("merm_house")
		inst.AnimState:SetBuild("merm_house")
		inst.AnimState:PlayAnimation("idle")
	end
	
	inst.components.childspawner.childname = "merm"
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 4)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(4)
	inst.components.lootdropper:SetLoot(loot)
	--inst.components.childspawner.emergencychildname = "merm"
	--inst.components.childspawner:SetEmergencyRadius(15)	
    --inst.components.childspawner:SetMaxEmergencyChildren(3)
end

--------------------------------------------------------------------------------------------------------
--Craftsmerm House

local function mermhouse_crafted_postinit(inst)
    inst.MiniMapEntity:SetIcon("mermhouse_crafted.tex")
    inst.AnimState:SetBank("mermhouse_crafted")
    inst.AnimState:SetBuild("mermhouse_crafted")
    inst.AnimState:PlayAnimation("idle", true)
	
	inst.components.childspawner.childname = "merm"
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 2)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(1)
end

--------------------------------------------------------------------------------------------------------
--Fishermerm's Hut

local function mermhouse_fisher_postinit(inst)
    inst.MiniMapEntity:SetIcon("mermhouse_fisher.tex")
    inst.AnimState:SetBank("merm_fisherman_house")
    inst.AnimState:SetBuild("merm_fisherman_house")
    inst.AnimState:PlayAnimation("idle")

	inst.components.childspawner.childname = "mermfisher"
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 4)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(2)
end

--------------------------------------------------------------------------------------------------------

return MakeMermHouse("mermhouse", mermhouse_postinit),
       MakeMermHouse("mermhouse_crafted", mermhouse_crafted_postinit),
	   MakeMermHouse("mermhouse_fisher", mermhouse_fisher_postinit),
       MakePlacer("mermhouse_placer", "merm_house", "merm_house", "idle"),
       MakePlacer("mermhouse_crafted_placer", "mermhouse_crafted", "mermhouse_crafted", "idle"),
	   MakePlacer("mermhouse_fisher_placer", "merm_fisherman_house", "merm_fisherman_house", "idle")
