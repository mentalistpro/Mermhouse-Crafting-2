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
    "merm",
    "mermfisher",
    "collapse_big",

    --loot:
    "boards",
    "rocks",
    "fish",
    "tropical_fish"
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
        if inst.components.childspawner then
            inst.components.childspawner:ReleaseAllChildren()
        end
    end
    StartSpawning(inst) 
end

--------------------------------------------------------------------------------------------------------

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
        
        inst:AddComponent("inspectable")
        inst:AddComponent("lootdropper")
        
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetOnFinishCallback(onhammered)
        inst.components.workable:SetOnWorkCallback(onhit)

        inst:ListenForEvent("dusktime", OnIsDusk, GetWorld())
        inst:ListenForEvent("daytime", OnIsDay, GetWorld())
        StartSpawning(inst)

        MakeMediumBurnable(inst, nil, nil, true)
        MakeLargePropagator(inst)
        inst:ListenForEvent("onignite", onignite)
        inst:ListenForEvent("burntup", onburntup)   

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
--Mermhouse

local function mermhouse_postinit(inst)
    local minimap = inst.entity:AddMiniMapEntity()

    if SaveGameIndex:IsModeShipwrecked() or SaveGameIndex:IsModePorkland() then
        if TUNING.MERMHOUSE_MINIMAP == 1 then
            minimap:SetIcon( "mermhouse_tropical.tex" )
        end
        inst.AnimState:SetBank("mermhouse_tropical")
        inst.AnimState:SetBuild("mermhouse_tropical")
        inst.AnimState:PlayAnimation("idle")
    else
        if TUNING.MERMHOUSE_MINIMAP == 1 then
            minimap:SetIcon( "mermhouse.tex" )
        end
        inst.MiniMapEntity:SetIcon("mermhouse.tex")
        inst.AnimState:SetBank("merm_house")
        inst.AnimState:SetBuild("merm_house")
        inst.AnimState:PlayAnimation("idle")
    end
    
    if SaveGameIndex:IsModeShipwrecked() then
        inst.components.lootdropper:SetLoot(sw_loot)
    else
        inst.components.lootdropper:SetLoot(loot)
    end
        
    inst.components.childspawner.childname = "merm"
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 4)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(4)
    
    inst.components.workable:SetWorkLeft(2)
end

--------------------------------------------------------------------------------------------------------
--Fishermerm's Hut

local function mermhouse_fisher_postinit(inst)
    local minimap = inst.entity:AddMiniMapEntity()

    if TUNING.MERMHOUSE_FISHER_MINIMAP == 1 then
        minimap:SetIcon( "mermhouse_fisher.tex" )
    end
    inst.AnimState:SetBank("mermhouse_fisher")
    inst.AnimState:SetBuild("mermhouse_fisher")
    inst.AnimState:PlayAnimation("idle")

    if SaveGameIndex:IsModeShipwrecked() then
        inst.components.lootdropper:SetLoot(sw_loot)
    else
        inst.components.lootdropper:SetLoot(loot)
    end

    if IsDLCEnabled(2) or IsDLCEnabled(3) then
        inst.components.childspawner.childname = "mermfisher"
    else
        inst.components.childspawner.childname = "merm"
    end
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 4) 
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(2)

    inst.components.workable:SetWorkLeft(2)
end


--------------------------------------------------------------------------------------------------------
--Craftsmerm House

local function mermhouse_crafted_postinit(inst)
    local minimap = inst.entity:AddMiniMapEntity()

    if TUNING.MERMHOUSE_CRAFTED_MINIMAP == 1 then
        minimap:SetIcon( "mermhouse_crafted.tex" )
    end    
    inst.AnimState:SetBank("mermhouse_crafted")
    inst.AnimState:SetBuild("mermhouse_crafted")
    inst.AnimState:PlayAnimation("idle", true)
    
    inst.components.childspawner.childname = "merm"
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 2)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(1)

    inst.components.workable:SetWorkLeft(4)
end

--------------------------------------------------------------------------------------------------------
--Craftsmerm Fishing House

local function mermhouse_crafted_fisher_postinit(inst)
    local minimap = inst.entity:AddMiniMapEntity()

    if TUNING.MERMHOUSE_CRAFTED_FISHER_MINIMAP == 1 then
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

    inst.components.workable:SetWorkLeft(4)
end

--------------------------------------------------------------------------------------------------------
--Merm Flort-ifications

local function mermwatchtower_postinit(inst)
    local minimap = inst.entity:AddMiniMapEntity()

    if TUNING.MERMWATCHTOWER_MINIMAP == 1 then
        minimap:SetIcon( "mermwatchtower.tex" )
    end    
    inst.AnimState:SetBank("merm_guard_tower")
    inst.AnimState:SetBuild("mermwatchtower")
    inst.AnimState:PlayAnimation("idle")
    
    if TUNING.IsBMEnabled == 1 then
        inst.components.childspawner.childname = "mermguard"
    else
        inst.components.childspawner.childname = "merm"
    end
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 2)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(1)
    
    inst.components.workable:SetWorkLeft(4)
end

--------------------------------------------------------------------------------------------------------

return  MakeMermHouse("mermhouse", mermhouse_postinit),
        MakeMermHouse("mermhouse_fisher", mermhouse_fisher_postinit),
        MakeMermHouse("mermhouse_crafted", mermhouse_crafted_postinit),
        MakeMermHouse("mermhouse_crafted_fisher", mermhouse_crafted_fisher_postinit),
        MakeMermHouse("mermwatchtower", mermwatchtower_postinit),
        
        MakePlacer("mermhouse_placer", "merm_house", "merm_house", "idle"),
        MakePlacer("mermhouse_tropical_placer", "mermhouse_tropical", "mermhouse_tropical", "idle"),
        MakePlacer("mermhouse_fisher_placer", "mermhouse_fisher", "mermhouse_fisher", "idle"),
        MakePlacer("mermhouse_crafted_placer", "mermhouse_crafted", "mermhouse_crafted", "idle"),
        MakePlacer("mermhouse_crafted_fisher_placer", "mermhouse_crafted_fisher", "mermhouse_crafted_fisher", "idle"),
        MakePlacer("mermwatchtower_placer", "merm_guard_tower", "mermwatchtower", "idle")
        
        