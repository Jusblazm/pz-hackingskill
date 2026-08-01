Events.OnServerCommand.Add(function(module, command, args)
    if module == "HackingSkill" then
        if command == "BypassResult" then
            if args.success then
                getPlayer():Say(getText("IGUI_HackingSkill_PlayerText_DoorUnlockSuccess"))
            else
                getPlayer():Say(getText("IGUI_HackingSkill_PlayerText_DoorUnlockFailed"))
            end
        elseif command == "CheckBuildingAlarmResult" then
            if args.success and args.alarm then
                getPlayer():Say(getText("IGUI_HackingSkill_PlayerText_BuildingAlarm"))
            else
                getPlayer():Say(getText("IGUI_HackingSkill_PlayerText_NoAlarm"))
            end
        elseif command == "CheckVehicleAlarmResult" then
            if args.success and args.alarm then
                getPlayer():Say(getText("IGUI_HackingSkill_PlayerText_VehicleAlarm"))
            else
                getPlayer():Say(getText("IGUI_HackingSkill_PlayerText_NoAlarm"))
            end
        elseif command == "DisableBuildingAlarmResult" or command == "DisableVehicleAlarmResult" then
            if args.success then
                getPlayer():Say(getText("IGUI_HackingSkill_PlayerText_DisarmedAlarm"))
            elseif ZombRand(100) < args.maybeChance then
                getPlayer():Say(getText("IGUI_HackingSkill_PlayerText_MaybeDisarmed"))
            else
                getPlayer():Say(getText("IGUI_HackingSkill_PlayerText_FailedDisarm"))
            end
        end
    end
end)