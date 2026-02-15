-- HackingSkill_Main
local function updateWarning(playerIndex, playerObj)
    print("[EZPZBanking] Warning: This version of Hacking Skill is no longer supported. Please update to the newest version to get new features and continued support.")
end

Events.OnCreatePlayer.Add(updateWarning)