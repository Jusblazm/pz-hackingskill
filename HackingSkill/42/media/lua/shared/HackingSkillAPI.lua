-- HackingSkillAPI
HackingSkill = {}

function HackingSkill.addXP(player, amount)
    player:getXp():AddXP(Perks.Hacking, amount)
end
