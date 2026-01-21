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
    self.character:Say(self.message)
    --[[ 
        I'm 99% sure triggerAlarm is client-side
        even though TIS uses it server-side
        so for now, its in both actions
    ]]
    if self.success then
        self.vehicle:setAlarmed(false)
    else
        if self.triggerAlarm then
            self.vehicle:triggerAlarm()
            self.vehicle:setPreviouslyEntered(true)
        end
    end
    ISBaseTimedAction.perform(self)
end

function HackingSkill_DisarmVehicleAlarmAction:complete()
    if self.success then
        self.vehicle:setAlarmed(false)
    else
        if self.triggerAlarm then
            self.vehicle:triggerAlarm()
            self.vehicle:setPreviouslyEntered(true)
        end
    end

    if HackingSkill_Utils.isVehicleAlarmXPEnabled() then
        HackingSkill_API.addXP(self.character, self.xpToAdd)
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
    local disarmChance = 10 + (skill * 8)

    o.success = ZombRand(100) < disarmChance
    o.triggerAlarm = false

    o.message = getText("IGUI_HackingSkill_PlayerText_FailedDisarm")
    o.xpToAdd = 1

    if o.success then
        o.message = getText("IGUI_HackingSkill_PlayerText_DisarmedAlarm")
        o.xpToAdd = 6
    else
        local maybeChance = math.max(10, 90 - (skill * 10))
        local maybe = (ZombRand(100) < maybeChance)

        if maybe then 
            o.message = getText("IGUI_HackingSkill_PlayerText_MaybeDisarmed")
        else
            o.message = getText("IGUI_HackingSkill_PlayerText_FailedDisarm")
        end

        o.xpToAdd = 3

        local alarmChance = HackingSkill_Utils.getAdjustedAlarmChance(character, 40)
        if ZombRand(100) < alarmChance then
            o.triggerAlarm = true
        end
    end

    o.maxTime = o:getDuration()

    return o
end
