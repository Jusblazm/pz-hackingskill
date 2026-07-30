-- HackingSkill_GydeTraitMagazines

--[[
    this patch adds a trait magazine for Hacking Skill
    traits in the same style as Gyde's Trait Magazines
]]

local function addCreditCardThiefMagazine()

    if not getActivatedMods():contains("\\GydeTraitMags") then
        print("[HackingSkill] General: Gyde Trait Magazines is not installed")
        return
    end

    if not GydeTraitMags or not GydeTraitMags.magazineTraits then
        print("[HackingSkill] General: Gyde Trait Magazines detected, but tables not yet available")
        return
    end

    GydeTraitMags.magazineTraits["Base.AmateurHackerMagazine"] = HackingSkillTraits.AmateurHacker
    GydeTraitMags.magazineTraits["Base.MasterHackerMagazine"] = HackingSkillTraits.MasterHacker
    -- GydeTraitMags.magazineTraits["Base.TinFoilHatMagazine"] = HackingSkillTraits.TinFoilHat
    print("[HackingSkill] General: Gyde Trait Magazines detected, creating multiple Trait Magazines")
end

Events.OnGameBoot.Add(addCreditCardThiefMagazine)