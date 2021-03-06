local assets =
{
    Asset("ANIM", "anim/mermhouse.zip"),
    Asset("ANIM", "anim/mermhouse_tropical.zip"),
    Asset("ANIM", "anim/mermhouse_fisher.zip"),
    Asset("ANIM", "anim/mermhouse_crafted.zip"),
    Asset("ANIM", "anim/mermhouse_crafted_fisher.zip"),
    Asset("ANIM", "anim/mermwatchtower.zip")
}

local prefabs =
{
    "boards",
    "collapse_big",
    "cutreeds",
    "fishingrod",
    "fish",
    "tropical_fish",
    "tentaclespots",
    "rocks",
    "spear"
}

local loot =
{
    "boards",
    "rocks",
    "fish"
}

local sw_loot =
{
    "boards",
    "rocks",
    "tropical_fish"
}

local crafted_loot =
{
    "boards",
    "boards",
    "cutreeds",
    "cutreeds",
    "fish"
}

local crafted_sw_loot =
{
    "boards",
    "boards",
    "cutreeds",
    "cutreeds",
    "tropical_fish"
}

local tower_loot =
{
    "boards",
    "boards",
    "boards",
    "tentaclespots",
}


--------------------------------------------------------------------------------------------------------

--[[CONTENT]]
--#1 Physical properties
--#2 Spawning
--#3 fn
--#4 Mermhouse
--#5 Fishermerm's House
--#6 Craftsmerm House
--#7 Craftsmerm Fishing House
--#8 Merm Flort-ifications
--#9 MakeMermHouse

--------------------------------------------------------------------------------------------------------
--#1 Physical properties

local function onbuilt(inst)
    if GetPlayer():HasTag("mermbuilder") then
        if GetPlayer().mermbuilderfn then
            GetPlayer().mermbuilderfn(GetPlayer())
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

local function onMarsh(inst, pt)
    if GetWorld().Map:GetTileAtPoint(pt:Get()) == GROUND.MARSH or GetWorld().Map:GetTileAtPoint(pt:Get()) == GROUND.TIDALMARSH then
        return true
    else
        return false
    end
end

--------------------------------------------------------------------------------------------------------
--#2 Spawning

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

--------------------------------------------------------------------------------------------------------
--#3 fn()

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

local function MakeMermHouse(name, postinit)
    local function fn()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()

        MakeObstaclePhysics(inst, 1)

        inst:AddTag("mermhouse")
        inst:AddTag("structure")

        inst:AddComponent("childspawner")
        inst.components.childspawner:SetSpawnedFn(OnSpawned)
        inst.components.childspawner:SetGoHomeFn(OnGoHome)
        inst:ListenForEvent("dusktime",
            function()
                if not inst:HasTag("burnt") then
                    if GetSeasonManager() and not GetSeasonManager():IsWinter() then
                        inst.components.childspawner:ReleaseAllChildren()
                    end
                    StartSpawning(inst)
                end
            end,
        GetWorld())
        inst:ListenForEvent("daytime", function() StopSpawning(inst) end , GetWorld())
        StartSpawning(inst)

        inst:AddComponent("inspectable")
        inst:AddComponent("lootdropper")

        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetOnFinishCallback(onhammered)
        inst.components.workable:SetOnWorkCallback(onhit)

        MakeMediumBurnable(inst, nil, nil, true)
        MakeLargePropagator(inst)
        inst:ListenForEvent("onignite", onignite)
        inst:ListenForEvent("burntup", onburntup)
        inst:ListenForEvent("onbuilt", onbuilt)


        MakeSnowCovered(inst, .01)

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
--#4 Mermhouse

local function mermhouse_postinit(inst)
    local minimap = inst.entity:AddMiniMapEntity()

    if SaveGameIndex:IsModeShipwrecked() or SaveGameIndex:IsModePorkland() then
        if TUNING.MERMHOUSE_MINIMAP_ICON == 0 then
            minimap:SetIcon( "mermhouse_tropical.tex" )
        end
        inst.AnimState:SetBank("merm_sw_house")
        inst.AnimState:SetBuild("merm_sw_house_2")
        inst.AnimState:PlayAnimation("idle")
    else
        if TUNING.MERMHOUSE_MINIMAP_ICON == 0 then
            minimap:SetIcon( "mermhouse.tex" )
        end
        inst.MiniMapEntity:SetIcon("mermhouse.tex")
        inst.AnimState:SetBank("merm_house")
        inst.AnimState:SetBuild("merm_house_2")
        inst.AnimState:PlayAnimation("idle")
    end

    inst.components.childspawner.childname = "merm"
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 4)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(4)

    if SaveGameIndex and SaveGameIndex:IsModeShipwrecked() then
        inst.components.lootdropper:SetLoot(sw_loot)
    else
        inst.components.lootdropper:SetLoot(loot)
    end

    inst.components.workable:SetWorkLeft(2)
end

--------------------------------------------------------------------------------------------------------
--#5 Fishermerm's Hut

local function mermhouse_fisher_postinit(inst)
    local minimap = inst.entity:AddMiniMapEntity()

    if TUNING.MERMHOUSE_MINIMAP_ICON == 0 then
        minimap:SetIcon( "mermhouse_fisher.tex" )
    end
    inst.AnimState:SetBank("merm_fisherman_house")
    inst.AnimState:SetBuild("merm_fisherman_house_2")
    inst.AnimState:PlayAnimation("idle")

    if IsDLCEnabled(2) or IsDLCEnabled(3) then
        inst.components.childspawner.childname = "mermfisher"
    else
        inst.components.childspawner.childname = "merm"
    end
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 4)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(2)

    if SaveGameIndex and SaveGameIndex:IsModeShipwrecked() then
        inst.components.lootdropper:SetLoot(sw_loot)
    else
        inst.components.lootdropper:SetLoot(loot)
    end

    inst.components.workable:SetWorkLeft(2)
end


--------------------------------------------------------------------------------------------------------
--#6 Craftsmerm House

local function mermhouse_crafted_postinit(inst)
    local minimap = inst.entity:AddMiniMapEntity()

    if TUNING.MERMHOUSE_MINIMAP_ICON == 0 then
        minimap:SetIcon( "mermhouse_crafted.tex" )
    end
    inst.AnimState:SetBank("mermhouse_crafted")
    inst.AnimState:SetBuild("mermhouse_crafted_2")
    inst.AnimState:PlayAnimation("idle", true)

    inst.components.childspawner.childname = "merm"
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 2)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(1)

    if SaveGameIndex and SaveGameIndex:IsModeShipwrecked() then
        inst.components.lootdropper:SetLoot(crafted_sw_loot)
    else
        inst.components.lootdropper:SetLoot(crafted_loot)
    end

    inst.components.workable:SetWorkLeft(4)
end

--------------------------------------------------------------------------------------------------------
--#7 Craftsmerm Fishing House

local function mermhouse_crafted_fisher_postinit(inst)
    local minimap = inst.entity:AddMiniMapEntity()

    if TUNING.MERMHOUSE_MINIMAP_ICON == 0 then
        minimap:SetIcon( "mermhouse_crafted_fisher.tex" )
    end
    inst.AnimState:SetBank("mermhouse_crafted_fisher")
    inst.AnimState:SetBuild("mermhouse_crafted_fisher")
    inst.AnimState:PlayAnimation("idle")

    if IsDLCEnabled(2) or IsDLCEnabled(3) then
        inst.components.childspawner.childname = "mermfisher"
    else
        inst.components.childspawner.childname = "merm"
    end
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 2)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(1)

    if SaveGameIndex and SaveGameIndex:IsModeShipwrecked() then
        inst.components.lootdropper:SetLoot(crafted_sw_loot)
    else
        inst.components.lootdropper:SetLoot(crafted_loot)
    end

    inst.components.workable:SetWorkLeft(4)
end

--------------------------------------------------------------------------------------------------------
--#8 Merm Flort-ifications

local function mermwatchtower_postinit(inst)
    local minimap = inst.entity:AddMiniMapEntity()

    if TUNING.MERMHOUSE_MINIMAP_ICON == 0 then
        minimap:SetIcon( "mermwatchtower.tex" )
    end
    inst.AnimState:SetBank("merm_guard_tower")
    inst.AnimState:SetBuild("merm_guard_tower_2")
    inst.AnimState:PlayAnimation("idle")

    inst.components.childspawner.childname = "merm"
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 2)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(1)

    inst.components.lootdropper:SetLoot(tower_loot)

    inst.components.workable:SetWorkLeft(4)
end

--------------------------------------------------------------------------------------------------------
--#9 MakeMermHouse

return  MakeMermHouse("mermhouse", mermhouse_postinit),
        MakeMermHouse("mermhouse_fisher", mermhouse_fisher_postinit),
        MakeMermHouse("mermhouse_crafted", mermhouse_crafted_postinit),
        MakeMermHouse("mermhouse_crafted_fisher", mermhouse_crafted_fisher_postinit),
        MakeMermHouse("mermwatchtower", mermwatchtower_postinit),

        MakePlacer("mermhouse_placer", "merm_house", "merm_house_2", "idle"),
        MakePlacer("mermhouse_tropical_placer", "merm_sw_house", "merm_sw_house_2", "idle"),
        MakePlacer("mermhouse_fisher_placer", "merm_fisherman_house", "merm_fisherman_house_2", "idle"),
        MakePlacer("mermhouse_crafted_placer", "mermhouse_crafted", "mermhouse_crafted_2", "idle"),
        MakePlacer("mermhouse_crafted_fisher_placer", "mermhouse_crafted_fisher", "mermhouse_crafted_fisher", "idle"),
        MakePlacer("mermwatchtower_placer", "merm_guard_tower", "merm_guard_tower_2", "idle")
