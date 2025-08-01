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
    local skill = HackingSkill.getLevel(self.character)
    local chanceToDetect = 25 + (skill * 7.5)
    local detected = ZombRand(100) < chanceToDetect
    local alarm = HackingSkill_Utils.hasVehicleAlarm(self.vehicle)

    local message = getText("IGUI_HackingSkill_PlayerText_NoAlarm")
    local xpToAdd = 1

    if detected and alarm then
        message = getText("IGUI_HackingSkill_PlayerText_VehicleAlarm")
        xpToAdd = 2
        HackingSkill_Utils.rememberVehicleAlarm(self.character, self.vehicle)
    elseif detected and not alarm then
        message = getText("IGUI_HackingSkill_PlayerText_NoAlarm")
        xpToAdd = 2
    elseif not detected and alarm then
        message = getText("IGUI_HackingSkill_PlayerText_NoAlarm")
        xpToAdd = 1
    end

    self.character:Say(message)

    if HackingSkill_Utils.isVehicleAlarmXPEnabled() then
        HackingSkill.addXP(self.character, xpToAdd)
    end

    ISBaseTimedAction.perform(self)
end

function HackingSkill_CheckVehicleAlarmAction:new(character, vehicle)
    local o = ISBaseTimedAction.new(self, character)
    setmetatable(o, self)
    self.__index = self

    o.character = character
    o.vehicle = vehicle
    o.maxTime = 100

    return o
end
