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
    ISBaseTimedAction.perform(self)
end

function HackingSkill_BypassSecurityDoorLockAction:complete()
    local success = ZombRand(100) < self.unlockChance

    if not isClient() and not isServer() then
        if success then
            self.character:Say(getText("IGUI_HackingSkill_PlayerText_DoorUnlockSuccess"))
        else
            self.character:Say(getText("IGUI_HackingSkill_PlayerText_DoorUnlockFailed"))
        end
    else
        sendServerCommand(self.character, "HackingSkill", "BypassResult", {
            success = success
        })
    end

    HackingSkill_API.addXP(self.character, success and 6 or 1)

    if self.hasHackingTool then
        HackingSkill_Utils.consumeHackingTool(self.character)
    end

    if success then
        self.object:setLocked(false)
        self.object:setLockedByKey(false)
        self.object:syncIsoObject(false, 0, nil, nil)
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
    o.unlockChance = unlockChance
    
    o.maxTime = o:getDuration()

    return o
end