-- HackingSkill_BypassSecurityDoorLockAction
require "TimedActions/ISBaseTimedAction"

HackingSkill_BypassSecurityDoorLockAction = ISBaseTimedAction:derive("HackingSkill_BypassSecurityDoorLockAction")

function HackingSkill_BypassSecurityDoorLockAction:isValid()
    return true
end

function HackingSkill_BypassSecurityDoorLockAction:waitToStart()
    self.character:faceThisObject(self.object)
    return self.character:shouldBeTurning()
end

function HackingSkill_BypassSecurityDoorLockAction:update()
    self.character:faceThisObject(self.object)
end

function HackingSkill_BypassSecurityDoorLockAction:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Mid")
end

function HackingSkill_BypassSecurityDoorLockAction:stop()
    ISBaseTimedAction.stop(self)
end

function HackingSkill_BypassSecurityDoorLockAction:perform()
    self.character:Say(self.message)
    ISBaseTimedAction.perform(self)
end

function HackingSkill_BypassSecurityDoorLockAction:complete()
    HackingSkill_API.addXP(self.character, self.xpToAdd)

    if self.hasHackingTool then
        HackingSkill_Utils.consumeHackingTool(self.character)
    end

    if self.success then
        self.object:setLocked(false)
        self.object:setLockedByKey(false)
    end
    return true
end

function HackingSkill_BypassSecurityDoorLockAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end

    local hackingLevel = HackingSkill_API.getLevel(self.character)
    local electricalLevel = self.character:getPerkLevel(Perks.Electricity)

    local effectiveness = (hackingLevel * 2) + electricalLevel
    local maxTime = 700
    local minTime = 150

    local duration = maxTime - ((effectiveness / 30) * (maxTime - minTime))

    if self.hasHackingTool then
        duration = duration * 0.7
    end
    duration = math.max(duration, 75)

    return math.floor(duration)
end

function HackingSkill_BypassSecurityDoorLockAction:new(character, object)
    local o = ISBaseTimedAction.new(self, character)

    o.character = character
    o.object = object
    o.hasHackingTool = HackingSkill_Utils.hasHackingTool(character)

    local skill = HackingSkill_API.getLevel(character)
    local unlockChance = 10 + (skill * 7)
    if o.hasHackingTool then
        unlockChance = unlockChance + 20
    end
    unlockChance = math.min(unlockChance, 90)

    o.success = ZombRand(100) < unlockChance

    o.message = getText("IGUI_HackingSkill_PlayerText_DoorUnlockFailed")
    o.xpToAdd = 1

    if o.success then
        o.message = getText("IGUI_HackingSkill_PlayerText_DoorUnlockSuccess")
        o.xpToAdd = 6
    end

    o.maxTime = o:getDuration()

    return o
end