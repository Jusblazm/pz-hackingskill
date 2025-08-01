-- HackingSkill_SkillBookCourierPatch
local function patchSkillBookCourierIfModPresent()
    if getActivatedMods():contains("\\GanydeBielovzki's Skill Book Courier") then
        print("[Hacking Skill] General: Skill Book Courier is active, inserting hacking books in distribution list")

        if not SkillBookCourier_Distribution then
            print("[Hacking Skill] Warning: SkillBookCourier_Distribution not found")
            return
        end

        local hackingBooks = {
            "BookHacking1", 3,
            "BookHacking2", 2,
            "BookHacking3", 1.5,
            "BookHacking4", 1,
            "BookHacking5", 0.5,
        }

        for _, entry in ipairs(SkillBookCourier_Distribution) do
            local bag = entry.Bag_Skillz_Mail
            if bag and bag.items then
                for i = 1, #hackingBooks, 2 do
                    table.insert(bag.items, hackingBooks[i])
                    table.insert(bag.items, hackingBooks[i + 1])
                end
            end
        end

        print("[Hacking Skill] General: Successfully added hacking books to Courier bags")
    else
        print("[Hacking Skill] General: Skill Book Courier is not installed")
    end
end

Events.OnPostDistributionMerge.Add(patchSkillBookCourierIfModPresent)
