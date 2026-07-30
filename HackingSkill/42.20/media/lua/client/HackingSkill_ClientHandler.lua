Events.OnServerCommand.Add(function(module, command, args)
    if module == "HackingSkill" and command == "BypassResult" then
        if args.success then
            getPlayer():Say(getText("IGUI_HackingSkill_PlayerText_DoorUnlockSuccess"))
        else
            getPlayer():Say(getText("IGUI_HackingSkill_PlayerText_DoorUnlockFailed"))
        end
    end
end)