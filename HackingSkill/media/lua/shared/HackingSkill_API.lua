-- HackingSkill_API
HackingSkill = {}

function HackingSkill.addXP(player, amount)
    if not HackingSkill.isBlockedByTinFoilHatTrait(player) then
        player:getXp():AddXP(Perks.Hacking, amount)
    end
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
    if level > 2 then
        if HackingSkill.hasTinFoilHatTrait(player) then
            player:getXp():setXPToLevel(Perks.Hacking, 2)
        end
    else
        player:getXp():setXPToLevel(Perks.Hacking, level)
    end
end

function HackingSkill.isMaxLevel(player)
    return HackingSkill.getLevel(player) >= PerkFactory.getPerk(Perks.Hacking):getMaxLevel()
end

function HackingSkill.reset(player)
    HackingSkill.setLevel(player, 0)
    return true
end

function HackingSkill.hasTinFoilHatTrait(player)
    return player:HasTrait("TinFoilHat")
end

function HackingSkill.isBlockedByTinFoilHatTrait(player)
    return HackingSkill.hasTinFoilHatTrait(player) and HackingSkill.getLevel(player) >= 2
end