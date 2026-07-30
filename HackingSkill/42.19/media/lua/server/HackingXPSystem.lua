-- HackingXPSystem
function addSkillBooks()
    SkillBook["Hacking"] = {}
    SkillBook["Hacking"].perk = Perks.Hacking
    SkillBook["Hacking"].maxMultiplier1 = 3
    SkillBook["Hacking"].maxMultiplier2 = 5
    SkillBook["Hacking"].maxMultiplier3 = 8
    SkillBook["Hacking"].maxMultiplier4 = 12
    SkillBook["Hacking"].maxMultiplier5 = 16
end

Events.OnGameStart.Add(addSkillBooks)