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
    ISBaseTimedAction.perform(self)
end

function HackingSkill_CheckBuildingAlarmAction:complete()
    local success = ZombRand(100) < self.chanceToDetect

    if not isClient() and not isServer() then
        if success and self.alarm then
            self.character:Say(getText("IGUI_HackingSkill_PlayerText_BuildingAlarm"))
        else
            self.character:Say(getText("IGUI_HackingSkill_PlayerText_NoAlarm"))
        end
    else
        sendServerCommand(self.character, "HackingSkill", "CheckBuildingAlarmResult", {
            success = success,
            alarm = self.alarm
        })
    end

    if success and self.alarm then
        HackingSkill_Utils.rememberBuildingAlarm(self.character, self.object)
    end

    if HackingSkill_Utils.isBuildingAlarmXPEnabled() then
        HackingSkill_API.addXP(self.character, success and 3 or 1)
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
    o.chanceToDetect = 25 + (skill * 7.5)

    o.alarm = HackingSkill_Utils.hasBuildingAlarm(object)

    o.maxTime = o:getDuration()

    return o
end