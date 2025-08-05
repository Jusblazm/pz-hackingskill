-- HackingSkill_Traits
require "NPCs/MainCreationMethods"

local hackerTraits = function()
    local amateurHacker = TraitFactory.addTrait(
        "AmateurHacker", -- type
        getText("UI_trait_AmateurHacker"), -- name
        2, -- cost
        getText("UI_trait_AmateurHacker_Description"), -- description
        false, -- is profession?
        false -- remove in MP?
    )
    amateurHacker:addXPBoost(Perks.Hacking, 1)
    BaseGameCharacterDetails.SetTraitDescription(amateurHacker)

    local masterHacker = TraitFactory.addTrait(
        "MasterHacker", -- type
        getText("UI_trait_MasterHacker"), -- name 
        6, -- cost
        getText("UI_trait_MasterHacker_Description"), -- description
        false, -- is profession?
        false -- remove in MP?
    )
    masterHacker:addXPBoost(Perks.Hacking, 3)
    BaseGameCharacterDetails.SetTraitDescription(masterHacker)

    local tinFoilHat = TraitFactory.addTrait(
        "TinFoilHat", -- type
        getText("UI_trait_TinFoilHat"), -- name
        -3, -- cost
        getText("UI_trait_TinFoilHat_Description"), -- description
        false, -- is profession?
        false -- remove in MP?
    )
    BaseGameCharacterDetails.SetTraitDescription(tinFoilHat)

    TraitFactory.sortList()
end

Events.OnGameBoot.Add(hackerTraits)