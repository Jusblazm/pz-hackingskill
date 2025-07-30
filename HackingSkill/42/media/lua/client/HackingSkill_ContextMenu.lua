-- HackingSkill_ContextMenu
local HackingSkill_Utils = require("HackingSkill_Utils")

local function onFillWorldObjectContextMenu(playerIndex, context, worldObjects, test)
    local player = getSpecificPlayer(playerIndex)
 
    for _, obj in ipairs(worldObjects) do
        if HackingSkill_Utils.isDoorOrWindow(obj) then
            context:addOption(getText("ContextMenu_HackingSkill_CheckForAlarm"), obj, function()
                local sq1 = obj:getSquare()
                local sq2 = obj.getOppositeSquare and obj:getOppositeSquare() or nil

                local playerSquare = player:getSquare()
                local dist1 = sq1 and sq1:DistTo(playerSquare) or math.huge
                local dist2 = sq2 and sq2:DistTo(playerSquare) or math.huge

                local targetSquare = dist1 <= dist2 and sq1 or sq2
                local walkAction = ISWalkToTimedAction:new(player, targetSquare)
                walkAction:setOnComplete(function()
                    ISTimedActionQueue.add(HackingSkill_CheckBuildingAlarmAction:new(player, obj))
                end)
                ISTimedActionQueue.add(walkAction)
            end)
            break
        end
    end

    for _, obj in ipairs(worldObjects) do
        if instanceof(obj, "IsoObject") then
            local square = obj:getSquare()
            if square then
                local vehicle = square:getVehicleContainer()
                if vehicle then
                    context:addOption(getText("ContextMenu_HackingSkill_CheckForAlarm"), vehicle, function()
                        local square = vehicle:getSquare()
                        local walkAction = ISWalkToTimedAction:new(player, square)
                        walkAction:setOnComplete(function()
                            ISTimedActionQueue.add(HackingSkill_CheckVehicleAlarmAction:new(player, vehicle))
                        end)
                        ISTimedActionQueue.add(walkAction)
                    end)
                    break
                end
            end
        end
    end
end

Events.OnFillWorldObjectContextMenu.Add(onFillWorldObjectContextMenu)