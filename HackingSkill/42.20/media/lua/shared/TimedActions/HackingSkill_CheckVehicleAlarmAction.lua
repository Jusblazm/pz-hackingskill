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
    ISBaseTimedAction.perform(self)
end

function HackingSkill_CheckVehicleAlarmAction:complete()
    local success = ZombRand(100) < self.chanceToDetect

    if not isClient() and not isServer() then
        if success and self.alarm then
            self.character:Say(getText("IGUI_HackingSkill_PlayerText_VehicleAlarm"))
        else
            self.character:Say(getText("IGUI_HackingSkill_PlayerText_NoAlarm"))
        end
    else
        sendServerCommand(self.character, "HackingSkill", "CheckVehicleAlarmResult", {
            success = success,
            alarm = self.alarm
        })
    end

    if success and self.alarm then
        HackingSkill_Utils.rememberVehicleAlarm(self.character, self.vehicle)
    end

    if HackingSkill_Utils.isVehicleAlarmXPEnabled() then
        HackingSkill_API.addXP(self.character, success and 3 or 1)
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

    local skill = HackingSkill_API.getLevel(character)
    o.chanceToDetect = 25 + (skill * 7.5)

    o.alarm = HackingSkill_Utils.hasVehicleAlarm(vehicle)

    o.maxTime = o:getDuration()
    
    return o
end