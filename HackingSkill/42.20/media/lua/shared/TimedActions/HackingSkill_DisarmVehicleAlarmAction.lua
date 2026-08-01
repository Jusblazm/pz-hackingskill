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
    ISBaseTimedAction.perform(self)
end

function HackingSkill_DisarmVehicleAlarmAction:complete()
    local success = ZombRand(100) < self.disarmChance
    local triggerAlarm = ZombRand(100) < self.alarmChance

    if not isClient() and not isServer() then
        if success then
            self.character:Say(getText("IGUI_HackingSkill_PlayerText_DisarmedAlarm"))
        elseif ZombRand(100) < self.maybeChance then
            self.character:Say(getText("IGUI_HackingSkill_PlayerText_MaybeDisarmed"))
        else
            self.character:Say(getText("IGUI_HackingSkill_PlayerText_FailedDisarm"))
        end
    else
        sendServerCommand(self.character, "HackingSkill", "DisableVehicleAlarmResult", {
            success = success,
            maybeChance = self.maybeChance
        })
    end
        
    if not success and triggerAlarm then
        self.vehicle:triggerAlarm()
        self.vehicle:setPreviouslyEntered(true)
    end

    if success then
        self.vehicle:setAlarmed(false)
    elseif triggerAlarm then
        self.vehicle:triggerAlarm()
        self.vehicle:setPreviouslyEntered(true)
    end

    if HackingSkill_Utils.isVehicleAlarmXPEnabled() then
        HackingSkill_API.addXP(self.character, success and 6 or 3)
    end
    return true
end

function HackingSkill_DisarmVehicleAlarmAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 150
end

function HackingSkill_DisarmVehicleAlarmAction:new(character, vehicle)
    local o = ISBaseTimedAction.new(self, character)

    o.character = character
    o.vehicle = vehicle

    local skill = HackingSkill_API.getLevel(character)
    o.maybeChance = math.max(10, 90 - (skill * 10))
    o.disarmChance = 10 + (skill * 8)

    o.alarmChance = HackingSkill_Utils.getAdjustedAlarmChance(character, 40)
    o.maxTime = o:getDuration()

    return o
end