-- HackingSkill_API
HackingSkill_API = {}

--- adds XP to the Hacking perk.
-- @param player (IsoPlayer) The player object.
-- @param amount (number) The amount of XP to add.
function HackingSkill_API.addXP(player, amount)
    if not HackingSkill_API.isBlockedByTinFoilHatTrait(player) then
        addXp(player, Perks.Hacking, amount)
    end
end

--- gets the current XP in the Hacking perk.
-- @param player (IsoPlayer) The player object.
-- @return (number) Current XP in Hacking.
function HackingSkill_API.getXP(player)
    return player:getXp():getXP(Perks.Hacking)
end


--- gets the amount of XP needed to reach the next level.
-- @param player (IsoPlayer) The player object.
-- @return (number) XP remaining until next level.
function HackingSkill_API.getXPToNextLevel(player)
    local currentXP = HackingSkill_API.getXP(player)
    local nextLevelXP = XPSystem.getInstance():getXPForLevel(player:getPerkLevel(Perks.Hacking) + 1)
    return nextLevelXP - currentXP
end

--- gets the player's current Hacking perk level.
-- @param player (IsoPlayer) The player object.
-- @return (number) Current level of Hacking.
function HackingSkill_API.getLevel(player)
    return player:getPerkLevel(Perks.Hacking)
end

--- sets the player's Hacking perk level.
-- if the player has the TinFoilHat trait, their max level is capped at 2.
-- @param player (IsoPlayer) The player object.
-- @param level (number) The desired level to set.
function HackingSkill_API.setLevel(player, level)
    if level > 2 then
        if HackingSkill_API.hasTinFoilHatTrait(player) then
            player:getXp():setXPToLevel(Perks.Hacking, 2)
        end
    else
        player:getXp():setXPToLevel(Perks.Hacking, level)
    end
end

--- checks if the player has reached the maximum Hacking level.
-- @param player (IsoPlayer) The player object.
-- @return (boolean) True if max level reached.
function HackingSkill_API.isMaxLevel(player)
    return HackingSkill_API.getLevel(player) >= PerkFactory.getPerk(Perks.Hacking):getMaxLevel()
end

--- resets the player's Hacking skill back to level 0.
-- @param player (IsoPlayer) The player object.
-- @return (boolean) Always returns true.
function HackingSkill_API.reset(player)
    HackingSkill_API.setLevel(player, 0)
    return true
end

--- checks if the player has the TinFoilHat trait.
-- @param player (IsoPlayer) The player object.
-- @return (boolean) True if player has the trait.
function HackingSkill_API.hasTinFoilHatTrait(player)
    return player:hasTrait(HackingSkillTraits.TinFoilHat)
end

--- checks if XP gain is blocked by TinFoilHat trait.
-- players with the trait are blocked from gaining XP past level 2.
-- @param player (IsoPlayer) The player object.
-- @return (boolean) True if XP is blocked.
function HackingSkill_API.isBlockedByTinFoilHatTrait(player)
    return HackingSkill_API.hasTinFoilHatTrait(player) and HackingSkill_API.getLevel(player) >= 2
end