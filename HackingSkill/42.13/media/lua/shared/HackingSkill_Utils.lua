-- HackingSkill_Utils
HackingSkill_Utils = {}

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

function HackingSkill_Utils.walkToNearestLocationForTimedAction(player, object, callback)
    if not player or not object or not callback then return end

    local sq1 = object:getSquare()
    local sq2 = object.getOppositeSquare and object:getOppositeSquare() or nil
    local playerSquare = player:getSquare()
    local dist1 = sq1 and sq1:DistTo(playerSquare) or math.huge
    local dist2 = sq2 and sq2:DistTo(playerSquare) or math.huge
    local targetSquare = dist1 <= dist2 and sq1 or sq2
    if not targetSquare then return end

    local walkAction = ISWalkToTimedAction:new(player, targetSquare)
    walkAction:setOnComplete(function()
        callback()
    end)
    ISTimedActionQueue.add(walkAction)
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

return HackingSkill_Utils
