local assets =
{
    Asset("ANIM", "anim/merm_house.zip"),
    Asset("ANIM", "anim/mermhouse_crafted.zip"),
    Asset("MINIMAP_IMAGE", "mermhouse_crafted"),
}

local prefabs =
{
    "merm",
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

local function onhammered(inst, worker)
    inst:RemoveComponent("childspawner")
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_big").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
        if inst.components.childspawner ~= nil then
            inst.components.childspawner:ReleaseAllChildren(worker)
        end
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle")
    end
end

local function StartSpawning(inst)
    if not inst:HasTag("burnt") and 
		GetSeasonManager() and 
        not GetSeasonManager():IsWinter() and
        inst.components.childspawner ~= nil then
        inst.components.childspawner:StartSpawning()
    end
end

local function StopSpawning(inst)
    if not inst:HasTag("burnt") and inst.components.childspawner ~= nil then
        inst.components.childspawner:StopSpawning()
    end
end

local function OnSpawned(inst, child)
    if not inst:HasTag("burnt") then
        inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")
        if GetClock():IsDay() and
            inst.components.childspawner ~= nil and
            inst.components.childspawner:CountChildrenOutside() >= 1 and
            child.components.combat.target == nil then
            StopSpawning(inst)
        end
    end
end

local function OnGoHome(inst, child)
    if not inst:HasTag("burnt") then
        inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")
        if inst.components.childspawner ~= nil and
            inst.components.childspawner:CountChildrenOutside() < 1 then
            StartSpawning(inst)
        end
    end
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
        data.burnt = true
    end
end

local function onload(inst, data)
    if data ~= nil and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
end

local function onignite(inst)
    if inst.components.childspawner ~= nil then
        inst.components.childspawner:ReleaseAllChildren()
    end
end

local function onburntup(inst)
    inst.AnimState:PlayAnimation("burnt")
end

local function MakeMermHouse(name, common_postinit, master_postinit)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
		local minimap = inst.entity:AddMiniMapEntity()
		minimap:SetIcon( "icemachine.tex" )

        MakeObstaclePhysics(inst, 1)

        inst:AddTag("structure")

        if common_postinit ~= nil then
            common_postinit(inst)
        end

        inst:AddComponent("lootdropper")
        inst.components.lootdropper:SetLoot(loot)
		
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(2)
        inst.components.workable:SetOnFinishCallback(onhammered)
        inst.components.workable:SetOnWorkCallback(onhit)

        inst:AddComponent("childspawner")
        inst.components.childspawner.childname = "merm"
        inst.components.childspawner:SetSpawnedFn(OnSpawned)
        inst.components.childspawner:SetGoHomeFn(OnGoHome)

		inst:ListenForEvent("dusktime", function() 
			if GetSeasonManager() and not GetSeasonManager():IsWinter() then
				inst.components.childspawner:ReleaseAllChildren()
			end
			StartSpawning(inst)
		end, GetWorld())
		inst:ListenForEvent("daytime", function() StopSpawning(inst) end , GetWorld())
		StartSpawning(inst)

        MakeMediumBurnable(inst, nil, nil, true)
        MakeLargePropagator(inst)
        inst:ListenForEvent("onignite", onignite)
        inst:ListenForEvent("burntup", onburntup)

        inst:AddComponent("inspectable")

        inst.OnSave = onsave
        inst.OnLoad = onload

        if master_postinit then
            master_postinit(inst)
        end

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

local function onbuilt(inst)
    inst.SoundEmitter:PlaySound("dontstarve/characters/wurt/merm/hut/place")
    inst.AnimState:PlayAnimation("place")
end

local function mermhouse_crafted_common(inst)
    inst.MiniMapEntity:SetIcon("mermhouse_crafted.png")
    inst.AnimState:SetBank("mermhouse_crafted")
    inst.AnimState:SetBuild("mermhouse_crafted")
    inst.AnimState:PlayAnimation("idle", true)
end


local function mermhouse_crafted_master(inst)
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 2)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(1)

    inst:ListenForEvent("onbuilt", onbuilt)
end

return 	MakeMermHouse("mermhouse_crafted", mermhouse_crafted_common, mermhouse_crafted_master),
		MakePlacer("common/mermhouse_crafted_placer", "mermhouse_crafted", "mermhouse_crafted", "idle")