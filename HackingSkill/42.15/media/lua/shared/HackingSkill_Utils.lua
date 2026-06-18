-- HackingSkill_Utils
HackingSkill_Utils = {}

HackingSkill_Utils.validElectronicDoorSprites = {
    ["fixtures_doors_01_32"] = true,
    ["fixtures_doors_01_33"] = true,
}

HackingSkill_Utils.ElectronicDoorFacingDirections = {
    ["fixtures_doors_01_32"] = 1, -- West
    ["fixtures_doors_01_33"] = 2, -- North
}

function HackingSkill_Utils.isValidElectronicDoorSprite(spriteName)
    return HackingSkill_Utils.validElectronicDoorSprites[spriteName] == true
end

function HackingSkill_Utils.isDoorOrWindow(obj)
    return instanceof(obj, "IsoDoor") or instanceof(obj, "IsoWindow")
end

function HackingSkill_Utils.getBuildingDefs(obj)
    if not obj then return nil, nil end

    local sq1 = obj:getSquare()
    local sq2 = obj.getOppositeSquare and obj:getOppositeSquare()
    local building1 = sq1 and sq1:getBuilding()
    local building2 = sq2 and sq2:getBuilding()
    local def1 = building1 and building1:getDef()
    local def2 = building2 and building2:getDef()

    return def1, def2
end

function HackingSkill_Utils.hasBuildingAlarm(obj)
    local def1, def2 = HackingSkill_Utils.getBuildingDefs(obj)
    return (def1 and def1:isAlarmed()) or (def2 and def2:isAlarmed())
end

function HackingSkill_Utils.disableBuildingAlarm(obj)
    local def1, def2 = HackingSkill_Utils.getBuildingDefs(obj)
    local disabled = false

    if def1 and def1.isAlarmed and def1:isAlarmed() and def1.setAlarmed then
        def1:setAlarmed(false)
        disabled = true
    end

    if def2 and def2.isAlarmed and def2:isAlarmed() and def2.setAlarmed then
        def2:setAlarmed(false)
        disabled = true
    end
    return disabled
end

function HackingSkill_Utils.hasVehicleAlarm(vehicle)
    return vehicle and vehicle:isAlarmed()
end

function HackingSkill_Utils.isBuildingAlarmXPEnabled()
    return SandboxVars.HackingSkill and SandboxVars.HackingSkill.BuildingAlarms == true
end

function HackingSkill_Utils.isVehicleAlarmXPEnabled()
    return SandboxVars.HackingSkill and SandboxVars.HackingSkill.VehicleAlarms == true
end

function HackingSkill_Utils.hasHackingTool(player)
    local sandboxValue = SandboxVars.HackingSkill.HackingTools
    local inv = player:getInventory()

    local tools = { "Base.DIYPINBypassTool" }

    local function hasTool(fullType)
        local shortType = string.match(fullType, "[^.]+$")

        if sandboxValue == 1 then
            return inv:containsTypeRecurse(shortType)
        elseif sandboxValue == 2 then
            return inv:contains(fullType)
        elseif sandboxValue == 3 then
            local primary = player:getPrimaryHandItem()
            local secondary = player:getSecondaryHandItem()

            if primary and primary:getFullType() == fullType then
                return true
            end
            if secondary and secondary:getFullType() == fullType then
                return true
            end
        end
        return false
    end

    for _, toolType in ipairs(tools) do
        if hasTool(toolType) then
            return true
        end
    end
    return false
end

function HackingSkill_Utils.consumeHackingTool(player)
    local sandboxValue = SandboxVars.HackingSkill.HackingTools
    local inv = player:getInventory()

    local tools = { "Base.DIYPINBypassTool" }

    local function consume(fullType)
        local shortType = string.match(fullType, "[^.]+$")

        if sandboxValue == 1 then
            local item = inv:getFirstTypeRecurse(shortType)
            if item then 
                inv:Remove(item)
                sendRemoveItemFromContainer(inv, item)
                return true
            end
        elseif sandboxValue == 2 then
            local item = inv:FindAndReturn(fullType)
            if item then
                inv:Remove(item)
                sendRemoveItemFromContainer(inv, item)
                return true
            end
        elseif sandboxValue == 3 then
            local primary = player:getPrimaryHandItem()
            local secondary = player:getSecondaryHandItem()

            if primary and primary:getFullType() == fullType then
                inv:Remove(primary)
                sendRemoveItemFromContainer(inv, item)
                return true
            end
            if secondary and secondary:getFullType() == fullType then
                inv:Remove(secondary)
                sendRemoveItemFromContainer(inv, item)
                return true
            end
        end
        return false
    end

    for _, toolType in ipairs(tools) do
        if consume(toolType) then
            return true
        end
    end
    return false
end

function HackingSkill_Utils.stopWhenAdjacent(context)
    local p = context.player
    local o = context.object

    if not p or not o then return false end
    if p:getZ() ~= o:getZ() then return false end

    local dx = math.abs(p:getX() - o:getX())
    local dy = math.abs(p:getY() - o:getY())

    return (dx + dy) <= 1
end

function HackingSkill_Utils.getAdjustedAlarmChance(character, baseChance)
    local alarmChance = baseChance or 40

    if character:hasTrait(CharacterTrait.DEXTROUS) then
        alarmChance = alarmChance - 10
    end
    -- if character:hasTrait(CharacterTrait.LUCKY) then
    --     alarmChance = alarmChance - 15
    -- end
    if character:hasTrait(CharacterTrait.ALL_THUMBS) then
        alarmChance = alarmChance + 10
    end
    -- if character:hasTrait(CharacterTrait.UNLUCKY) then
    --     alarmChance = alarmChance + 15
    -- end

    alarmChance = math.max(0, math.min(100, alarmChance))
    return alarmChance
end

function HackingSkill_Utils.getPlayerKnownVehicleAlarms(player)
    local modData = player:getModData()
    modData.knownVehicleAlarms = modData.knownVehicleAlarms or {}
    return modData.knownVehicleAlarms
end

function HackingSkill_Utils.rememberVehicleAlarm(player, vehicle)
    if not player or not vehicle then return end
    local known = HackingSkill_Utils.getPlayerKnownVehicleAlarms(player)
    known[tostring(vehicle:getId())] = true
    player:transmitModData()
end

function HackingSkill_Utils.knowsVehicleAlarm(player, vehicle)
    if not player or not vehicle then return false end
    local known = HackingSkill_Utils.getPlayerKnownVehicleAlarms(player)
    return known and known[tostring(vehicle:getId())] == true
end

function HackingSkill_Utils.getBuildingID(object)
    if not object then return nil end

    local sq1 = object:getSquare()
    local sq2 = object.getOppositeSquare and object:getOppositeSquare()

    local building1 = sq1 and sq1:getBuilding()
    local building2 = sq2 and sq2:getBuilding()

    local id1 = building1 and building1:getID()
    local id2 = building2 and building2:getID()

    if id1 and id2 then
        return tostring(math.min(id1, id2))
    elseif id1 then
        return tostring(id1)
    elseif id2 then
        return tostring(id2)
    else
        return nil
    end
end

function HackingSkill_Utils.getPlayerKnownBuildingAlarms(player)
    local modData = player:getModData()
    modData.knownBuildingAlarms = modData.knownBuildingAlarms or {}
    return modData.knownBuildingAlarms
end

function HackingSkill_Utils.rememberBuildingAlarm(player, object)
    if not player or not object then return end
    local buildingID = HackingSkill_Utils.getBuildingID(object)
    if not buildingID then return end
    local known = HackingSkill_Utils.getPlayerKnownBuildingAlarms(player)
    known[buildingID] = true
    player:transmitModData()
end

function HackingSkill_Utils.knowsBuildingAlarm(player, object)
    if not player or not object then return false end
    local buildingID = HackingSkill_Utils.getBuildingID(object)
    if not buildingID then return false end
    local known = HackingSkill_Utils.getPlayerKnownBuildingAlarms(player)
    return known[buildingID] == true
end

local function isSquarePowered(square)
    return (
        (SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or
        (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and not square:isOutside())
    )
end

--[[ 
    possibly required for security doors in louisville checkpoint
    where they could be considered not part of the building
]]
local function isNearbySquarePowered(square, radius)
    if not square then return false end
    radius = radius or 1

    for dx = -radius, radius do
        for dy = -radius, radius do
            local checkSquare = getCell():getGridSquare(square:getX() + dx, square:getY() + dy, square:getZ())
            if checkSquare and isSquarePowered(checkSquare) then
                return true
            end
        end
    end
    return false
end

function HackingSkill_Utils.isDoorPowered(obj)
    if not obj then return false end
    local square = obj:getSquare()
    if not square then return false end
    return isNearbySquarePowered(square, 3)
end

return HackingSkill_Utils