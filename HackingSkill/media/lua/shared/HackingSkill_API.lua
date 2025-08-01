-- HackingSkill_API
HackingSkill = {}

function HackingSkill.addXP(player, amount)
    player:getXp():AddXP(Perks.Hacking, amount)
end

function HackingSkill.getXP(player)
    return player:getXp():getXP(Perks.Hacking)
end

function HackingSkill.getXPToNextLevel(player)
    local currentXP = HackingSkill.getXP(player)
    local nextLevelXP = XPSystem.getInstance():getXPForLevel(player:getPerkLevel(Perks.Hacking) + 1)
    return nextLevelXP - currentXP
end

function HackingSkill.getLevel(player)
    return player:getPerkLevel(Perks.Hacking)
end

function HackingSkill.setLevel(player, level)
    player:getXp():setXPToLevel(Perks.Hacking, level)
end

function HackingSkill.isMaxLevel(player)
    return HackingSkill.getLevel(player) >= PerkFactory.getPerk(Perks.Hacking):getMaxLevel()
end

function HackingSkill.reset(player)
    HackingSkill.setLevel(player, 0)
    return true
end