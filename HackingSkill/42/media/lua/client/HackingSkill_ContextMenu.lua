-- HackingSkill_ContextMenu
local HackingSkill_Utils = require("HackingSkill_Utils")

local function onFillWorldObjectContextMenu(playerIndex, context, worldObjects, test)
    local player = getSpecificPlayer(playerIndex)
 
    for _, obj in ipairs(worldObjects) do
        if HackingSkill_Utils.isDoorOrWindow(obj) then
            local knowsAlarm = HackingSkill_Utils.knowsBuildingAlarm(player, obj)
            local hasAlarm = HackingSkill_Utils.hasBuildingAlarm(obj)

            if not knowsAlarm then
                -- let player check for an alarm
                context:addOption(getText("ContextMenu_HackingSkill_CheckForAlarm"), obj, function()
                    HackingSkill_Utils.walkToNearestLocationForTimedAction(player, obj, function()
                        ISTimedActionQueue.add(HackingSkill_CheckBuildingAlarmAction:new(player, obj))
                    end)
                end)
            elseif knowsAlarm and hasAlarm then
                -- player knows there is an alarm
                context:addOption(getText("ContextMenu_HackingSkill_DisarmAlarm"), obj, function()
                    HackingSkill_Utils.walkToNearestLocationForTimedAction(player, obj, function()
                        ISTimedActionQueue.add(HackingSkill_DisarmBuildingAlarmAction:new(player, obj))
                    end)
                end)
            end
            break
        end
    end

    for _, obj in ipairs(worldObjects) do
        if instanceof(obj, "IsoObject") then
            local square = obj:getSquare()
            if square then
                local vehicle = square:getVehicleContainer()
                if vehicle then
                    local knowsAlarm = HackingSkill_Utils.knowsVehicleAlarm(player, vehicle)
                    local hasAlarm = HackingSkill_Utils.hasVehicleAlarm(vehicle)

                    if not knowsAlarm then
                        -- let player check for an alarm
                        context:addOption(getText("ContextMenu_HackingSkill_CheckForAlarm"), vehicle, function()
                            local square = vehicle:getSquare()
                            local walkAction = ISWalkToTimedAction:new(player, square)
                            walkAction:setOnComplete(function()
                                ISTimedActionQueue.add(HackingSkill_CheckVehicleAlarmAction:new(player, vehicle))
                            end)
                            ISTimedActionQueue.add(walkAction)
                        end)
                    elseif knowsAlarm and hasAlarm then
                        -- player knows there is an alarm
                        context:addOption(getText("ContextMenu_HackingSkill_DisarmAlarm"), vehicle, function()
                            local square = vehicle:getSquare()
                            local walkAction = ISWalkToTimedAction:new(player, square)
                            walkAction:setOnComplete(function()
                                ISTimedActionQueue.add(HackingSkill_DisarmVehicleAlarmAction:new(player, vehicle))
                            end)
                            ISTimedActionQueue.add(walkAction)
                        end)
                    end
                    break
                end
            end
        end
    end
end

Events.OnFillWorldObjectContextMenu.Add(onFillWorldObjectContextMenu)