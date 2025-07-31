-- HackingSkill_DisarmVehicleAlarmAction
require "TimedActions/ISBaseTimedAction"

HackingSkill_DisarmVehicleAlarmAction = ISBaseTimedAction:derive("HackingSkill_DisarmVehicleAlarmAction")

function HackingSkill_DisarmVehicleAlarmAction:isValid()
    return self.vehicle and HackingSkill_Utils.hasVehicleAlarm(self.vehicle)
end

function HackingSkill_DisarmVehicleAlarmAction:waitToStart()
    self.character:faceThisObject(self.vehicle)
    return self.character:shouldBeTurning()
end

function HackingSkill_DisarmVehicleAlarmAction:update()
    self.character:faceThisObject(self.vehicle)
end

function HackingSkill_DisarmVehicleAlarmAction:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Mid")
end

function HackingSkill_DisarmVehicleAlarmAction:stop()
    ISBaseTimedAction.stop(self)
end

function HackingSkill_DisarmVehicleAlarmAction:perform()
    local skill = HackingSkill.getLevel(self.character)
    local disarmChance = (skill * 8) + 10
    local success = ZombRand(100) < disarmChance
    local xpToAdd = 1

    if success then
        self.vehicle:setAlarmed(false)
        self.character:Say(getText("IGUI_HackingSkill_PlayerText_DisarmedAlarm"))
        xpToAdd = 10
    else
        self.character:Say(getText("IGUI_HackingSkill_PlayerText_FailedDisarm"))
        xpToAdd = 3
        if ZombRand(100) < 50 then
            self.vehicle:triggerAlarm()
        end
    end

    if HackingSkill_Utils.isVehicleAlarmXPEnabled() then
        HackingSkill.addXP(self.character, xpToAdd)
    end

    ISBaseTimedAction.perform(self)
end

function HackingSkill_DisarmVehicleAlarmAction:new(character, vehicle)
    local o = ISBaseTimedAction.new(self, character)
    setmetatable(o, self)
    self.__index = self

    o.character = character
    o.vehicle = vehicle
    o.maxTime = 150

    return o
end
