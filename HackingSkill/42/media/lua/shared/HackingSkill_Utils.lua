HackingSkill_Utils = {}

function HackingSkill_Utils.isDoorOrWindow(obj)
    return instanceof(obj, "IsoDoor") or instanceof(obj, "IsoWindow")
end

function HackingSkill_Utils.hasBuildingAlarm(obj)
    if not obj then return false end

    -- check both squares
    local sq1 = obj:getSquare()
    local sq2 = obj.getOppositeSquare and obj:getOppositeSquare()

    local building1 = sq1 and sq1:getBuilding()
    local building2 = sq2 and sq2:getBuilding()

    local def1 = building1 and building1:getDef()
    local def2 = building2 and building2:getDef()

    return (def1 and def1:isAlarmed()) or (def2 and def2:isAlarmed())
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


return HackingSkill_Utils
