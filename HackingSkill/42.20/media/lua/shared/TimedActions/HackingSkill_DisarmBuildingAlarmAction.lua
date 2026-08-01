-- HackingSkill_DisarmBuildingAlarmAction
require "TimedActions/ISBaseTimedAction"

HackingSkill_DisarmBuildingAlarmAction = ISBaseTimedAction:derive("HackingSkill_DisarmBuildingAlarmAction")

function HackingSkill_DisarmBuildingAlarmAction:isValid()
    return self.object and HackingSkill_Utils.hasBuildingAlarm(self.object)
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
    ISBaseTimedAction.perform(self)
end

function HackingSkill_DisarmBuildingAlarmAction:complete()
    local success = ZombRand(100) < self.disarmChance
    local maybeChance = math.max(10, 90 - (skill * 10))

    if not isClient() and not isServer() then
        if success then
            self.character:Say(getText("IGUI_HackingSkill_PlayerText_DisarmedAlarm"))
        elseif ZombRand(100) < maybeChance then
            self.characterSay(getText("IGUI_HackingSkill_PlayerText_MaybeDisarmed"))
        else
            self.characterSay(getText("IGUI_HackingSkill_PlayerText_FailedDisarm"))
        end
    else
        sendServerCommand(self.character, "HackingSkill", "DisableBuildingAlarmResult", {
            success = success,
            maybeChance = maybeChance
        })
    end

    if success then
        HackingSkill_Utils.disableBuildingAlarm(self.object)
    end

    if HackingSkill_Utils.isBuildingAlarmXPEnabled() then
        HackingSkill_API.addXP(self.character, success and 6 or 3)
    end
    return true
end

function HackingSkill_DisarmBuildingAlarmAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 150
end

function HackingSkill_DisarmBuildingAlarmAction:new(character, object)
    local o = ISBaseTimedAction.new(self, character)

    o.character = character
    o.object = object

    local skill = HackingSkill_API.getLevel(character)
    o.disarmChance = 10 + (skill * 8)

    o.maxTime = o:getDuration()

    return o
end