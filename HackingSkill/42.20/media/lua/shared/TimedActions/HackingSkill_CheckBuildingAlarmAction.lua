-- HackingSkill_CheckBuildingAlarmAction
require "TimedActions/ISBaseTimedAction"

HackingSkill_CheckBuildingAlarmAction = ISBaseTimedAction:derive("HackingSkill_CheckBuildingAlarmAction")

function HackingSkill_CheckBuildingAlarmAction:isValid()
    return true
end

function HackingSkill_CheckBuildingAlarmAction:waitToStart()
    self.character:faceThisObject(self.object)
    return self.character:shouldBeTurning()
end

function HackingSkill_CheckBuildingAlarmAction:update()
    self.character:faceThisObject(self.object)
end

function HackingSkill_CheckBuildingAlarmAction:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Mid")
end

function HackingSkill_CheckBuildingAlarmAction:stop()
    ISBaseTimedAction.stop(self)
end

function HackingSkill_CheckBuildingAlarmAction:perform()
    self.character:Say(self.message)
    if self.detected and self.alarm then
        HackingSkill_Utils.rememberBuildingAlarm(self.character, self.object)
    end
    ISBaseTimedAction.perform(self)
end

function HackingSkill_CheckBuildingAlarmAction:complete()
    if HackingSkill_Utils.isBuildingAlarmXPEnabled() then
        HackingSkill_API.addXP(self.character, self.xpToAdd)
    end
    return true
end

function HackingSkill_CheckBuildingAlarmAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 100
end

function HackingSkill_CheckBuildingAlarmAction:new(character, object)
    local o = ISBaseTimedAction.new(self, character)

    o.character = character
    o.object = object

    local skill = HackingSkill_API.getLevel(character)
    local chanceToDetect = 25 + (skill * 7.5)

    o.detected = ZombRand(100) < chanceToDetect
    o.alarm = HackingSkill_Utils.hasBuildingAlarm(object)

    o.message = getText("IGUI_HackingSkill_PlayerText_NoAlarm")
    o.xpToAdd = 1

    if o.detected and o.alarm then
        o.message = getText("IGUI_HackingSkill_PlayerText_BuildingAlarm")
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