-- HackingSkill_DisarmBuildingAlarmAction
require "TimedActions/ISBaseTimedAction"

HackingSkill_DisarmBuildingAlarmAction = ISBaseTimedAction:derive("HackingSkill_DisarmBuildingAlarmAction")

function HackingSkill_DisarmBuildingAlarmAction:isValid()
    return self.object and HackingSkill_Utils.hasBuildingAlarm(self.object)
end

function HackingSkill_DisarmBuildingAlarmAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 150
end

function HackingSkill_DisarmBuildingAlarmAction:waitToStart()
    self.character:faceThisObject(self.object)
    return self.character:shouldBeTurning()
end

function HackingSkill_DisarmBuildingAlarmAction:update()
    self.character:faceThisObject(self.object)
end

function HackingSkill_DisarmBuildingAlarmAction:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Mid")
end

function HackingSkill_DisarmBuildingAlarmAction:stop()
    ISBaseTimedAction.stop(self)
end

function HackingSkill_DisarmBuildingAlarmAction:perform()
    self.character:Say(self.message)
    if self.success then
        HackingSkill_Utils.disableBuildingAlarm(self.object)
    end
    ISBaseTimedAction.perform(self)
end

function HackingSkill_DisarmBuildingAlarmAction:complete()
    if HackingSkill_Utils.isBuildingAlarmXPEnabled() then
        HackingSkill.addXP(self.character, self.xpToAdd)
    end
    return true
end

function HackingSkill_DisarmBuildingAlarmAction:new(character, object)
    local o = ISBaseTimedAction.new(self, character)

    o.character = character
    o.object = object

    local skill = HackingSkill.getLevel(character)
    local disarmChance = (skill * 8) + 10

    o.success = ZombRand(100) < disarmChance

    o.message = getText("IGUI_HackingSkill_PlayerText_FailedDisarm")
    o.xpToAdd = 1

    if o.success then
        o.message = getText("IGUI_HackingSkill_PlayerText_DisarmedAlarm")
        o.xpToAdd = 6
    else
        local maybeChance = math.max(10, 90 - (skill * 10))
        if ZombRand(100) < maybeChance then
            o.message = getText("IGUI_HackingSkill_PlayerText_MaybeDisarmed")
        else
            o.message = getText("IGUI_HackingSkill_PlayerText_FailedDisarm")
        end
        o.xpToAdd = 3
    end

    o.maxTime = o:getDuration()

    return o
end
