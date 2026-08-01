-- HackingSkill_ContextMenu
local HackingSkill_Utils = require("HackingSkill_Utils")

local function onFillWorldObjectContextMenu(playerIndex, context, worldObjects, test)
    local player = getSpecificPlayer(playerIndex)
 
    -- standard doors and windows
    for _, obj in ipairs(worldObjects) do
        if HackingSkill_Utils.isDoorOrWindow(obj) then
            local knowsAlarm = HackingSkill_Utils.knowsBuildingAlarm(player, obj)
            local hasAlarm = HackingSkill_Utils.hasBuildingAlarm(obj)

            if not knowsAlarm then
                -- let player check for an alarm
                context:addOption(getText("ContextMenu_HackingSkill_CheckForAlarm"), obj, function()
                    if obj:getSquare() and luautils.walkAdjWindowOrDoor(player, obj:getSquare(), obj) then
                        ISTimedActionQueue.add(HackingSkill_CheckBuildingAlarmAction:new(player, obj))
                    end
                end)
            elseif knowsAlarm and hasAlarm then
                -- player knows there is an alarm
                context:addOption(getText("ContextMenu_HackingSkill_DisarmAlarm"), obj, function()
                    if obj:getSquare() and luautils.walkAdjWindowOrDoor(player, obj:getSquare(), obj) then
                        ISTimedActionQueue.add(HackingSkill_DisarmBuildingAlarmAction:new(player, obj))
                    end
                end)
            end
            break
        end
    end

    -- security doors
    for _, obj in ipairs(worldObjects) do
        if instanceof(obj, "IsoDoor") then
            local sprite = obj:getSprite()
            if sprite then
                local spriteName = sprite:getName()
                
                if spriteName and HackingSkill_Utils.isValidElectronicDoorSprite(spriteName) then
                    if HackingSkill_Utils.isDoorPowered(obj) then
                        if obj:isLocked() then
                            context:addOption(getText("ContextMenu_HackingSkill_HackDoor"), obj, function()
                                if obj:getSquare() and luautils.walkAdjWindowOrDoor(player, obj:getSquare(), obj) then
                                    ISTimedActionQueue.add(HackingSkill_BypassSecurityDoorLockAction:new(player, obj))
                                end
                            end)
                        end
                    end
                end
                break
            end
        end
    end

    -- vehicles
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
                            if obj:getSquare() and luautils.walkAdj(player, obj:getSquare()) then
                                ISTimedActionQueue.add(HackingSkill_CheckVehicleAlarmAction:new(player, vehicle))
                            end
                        end)
                    elseif knowsAlarm and hasAlarm then
                        -- player knows there is an alarm
                        context:addOption(getText("ContextMenu_HackingSkill_DisarmAlarm"), vehicle, function()
                            if obj:getSquare() and luautils.walkAdj(player, obj:getSquare()) then
                                ISTimedActionQueue.add(HackingSkill_DisarmVehicleAlarmAction:new(player, vehicle))
                            end
                        end)
                    end
                    break
                end
            end
        end
    end
end

Events.OnFillWorldObjectContextMenu.Add(onFillWorldObjectContextMenu)