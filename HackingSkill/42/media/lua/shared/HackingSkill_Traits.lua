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

    TraitFactory.sortList()
    BaseGameCharacterDetails.SetTraitDescription(masterHacker)
end

Events.OnGameBoot.Add(hackerTraits)