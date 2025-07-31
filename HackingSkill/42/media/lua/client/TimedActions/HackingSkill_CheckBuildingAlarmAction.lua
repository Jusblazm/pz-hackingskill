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
    local skill = HackingSkill.getLevel(self.character)
    local chanceToDetect = 25 + (skill * 7.5)
    local detected = ZombRand(100) < chanceToDetect
    local alarm = HackingSkill_Utils.hasBuildingAlarm(self.object)

    local message = getText("IGUI_HackingSkill_PlayerText_NoAlarm")
    local xpToAdd = 1

    if detected and alarm then
        message = getText("IGUI_HackingSkill_PlayerText_BuildingAlarm")
        xpToAdd = 2
        HackingSkill_Utils.rememberBuildingAlarm(self.character, self.object)
    elseif detected and not alarm then
        message = getText("IGUI_HackingSkill_PlayerText_NoAlarm")
        xpToAdd = 2
    elseif not detected and alarm then
        message = getText("IGUI_HackingSkill_PlayerText_NoAlarm")
        xpToAdd = 1
    end

    self.character:Say(message)

    if HackingSkill_Utils.isBuildingAlarmXPEnabled() then
        HackingSkill.addXP(self.character, xpToAdd)
    end
    
    ISBaseTimedAction.perform(self)
end

function HackingSkill_CheckBuildingAlarmAction:new(character, object)
    local o = ISBaseTimedAction.new(self, character)
    setmetatable(o, self)
    self.__index = self

    o.character = character
    o.object = object
    o.maxTime = 100

    return o
end