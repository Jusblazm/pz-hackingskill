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
    local skill = HackingSkill_API.getLevel(self.character)
    local disarmChance = (skill * 8) + 10
    local success = ZombRand(100) < disarmChance
    local xpToAdd = 1

    if success then
        HackingSkill_Utils.disableBuildingAlarm(self.object)
        self.character:Say(getText("IGUI_HackingSkill_PlayerText_DisarmedAlarm"))
        xpToAdd = 6
    else
        local maybeChance = math.max(10, 90 - (skill * 10))
        if ZombRand(100) < maybeChance then
            self.character:Say(getText("IGUI_HackingSkill_PlayerText_MaybeDisarmed"))
        else
            self.character:Say(getText("IGUI_HackingSkill_PlayerText_FailedDisarm"))
        end
        xpToAdd = 3
        -- if ZombRand(100) < 40 then
        --     local sq1 = self.object.getSquare and self.object:getSquare()
        --     local sq2 = self.object.getOppositeSquare and self.object:getOppositeSquare()

        --     local building1 = sq1 and sq1.getBuilding and sq1:getBuilding()
        --     local building2 = sq2 and sq2.getBuilding and sq2:getBuilding()

        --     local building = building1 or building2
        --     if building and building.TriggerAlarm then
        --         building:TriggerAlarm()
        --     end
        -- end
    end

    if HackingSkill_Utils.isBuildingAlarmXPEnabled() then
        HackingSkill_API.addXP(self.character, xpToAdd)
    end

    ISBaseTimedAction.perform(self)
end

function HackingSkill_DisarmBuildingAlarmAction:new(character, object)
    local o = ISBaseTimedAction.new(self, character)
    setmetatable(o, self)
    self.__index = self

    o.character = character
    o.object = object
    o.maxTime = 150

    return o
end
