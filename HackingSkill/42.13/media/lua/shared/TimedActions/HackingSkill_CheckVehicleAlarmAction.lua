-- HackingSkill_CheckVehicleAlarmAction
require "TimedActions/ISBaseTimedAction"

HackingSkill_CheckVehicleAlarmAction = ISBaseTimedAction:derive("HackingSkill_CheckVehicleAlarmAction")

function HackingSkill_CheckVehicleAlarmAction:isValid()
    return true
end

function HackingSkill_CheckVehicleAlarmAction:waitToStart()
    self.character:faceThisObject(self.vehicle)
    return self.character:shouldBeTurning()
end

function HackingSkill_CheckVehicleAlarmAction:update()
    self.character:faceThisObject(self.vehicle)
end

function HackingSkill_CheckVehicleAlarmAction:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Mid")
end

function HackingSkill_CheckVehicleAlarmAction:stop()
    ISBaseTimedAction.stop(self)
end

function HackingSkill_CheckVehicleAlarmAction:perform()
    self.character:Say(self.message)
    if self.detected and self.alarm then
        HackingSkill_Utils.rememberVehicleAlarm(self.character, self.vehicle)
    end
    ISBaseTimedAction.perform(self)
end

function HackingSkill_CheckVehicleAlarmAction:complete()
    if HackingSkill_Utils.isVehicleAlarmXPEnabled() then
        HackingSkill.addXP(self.character, self.xpToAdd)
    end
    return true
end

function HackingSkill_CheckVehicleAlarmAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 100
end

function HackingSkill_CheckVehicleAlarmAction:new(character, vehicle)
    local o = ISBaseTimedAction.new(self, character)

    o.character = character
    o.vehicle = vehicle

    local skill = HackingSkill.getLevel(character)
    local chanceToDetect = 25 + (skill * 7.5)

    o.detected = ZombRand(100) < chanceToDetect
    o.alarm = HackingSkill_Utils.hasVehicleAlarm(vehicle)

    o.message = getText("IGUI_HackingSkill_PlayerText_NoAlarm")
    o.xpToAdd  = 1

    if o.detected and o.alarm then
        o.message = getText("IGUI_HackingSkill_PlayerText_VehicleAlarm")
        o.xpToAdd = 2

    elseif o.detected and not o.alarm then
        o.message = getText("IGUI_HackingSkill_PlayerText_NoAlarm")
        o.xpToAdd = 2

    elseif not o.detected and o.alarm then
        o.message = getText("IGUI_HackingSkill_PlayerText_NoAlarm")
        o.xpToAdd = 1
    end

    o.maxTime = o:getDuration()
    
    return o
end
