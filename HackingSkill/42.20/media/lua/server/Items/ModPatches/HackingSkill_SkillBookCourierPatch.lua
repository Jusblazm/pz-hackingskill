-- HackingSkill_SkillBookCourierPatch
local function patchSkillBookCourierIfModPresent()
    if not getActivatedMods():contains("GanydeBielovzki's Skill Book Courier") then
        print("[HackingSkill] General: Skill Book Courier is not installed")
        return
    end

    print("[HackingSkill] General: Skill Book Courier is active, inserting hacking books in distribution list")

    local hackingBooks = {
        "BookHacking1", 3,
        "BookHacking2", 2,
        "BookHacking3", 1.5,
        "BookHacking4", 1,
        "BookHacking5", 0.5,
    }

    local found = false

    for _, distTable in ipairs(Distributions or {}) do
        local bag = distTable.Bag_Skillz_Mail
        if bag and bag.items then
            found = true

            for _, value in ipairs(hackingBooks) do
                table.insert(bag.items, value)
            end

            break
        end
    end

    if found then
        print("[HackingSkill] General: Successfully added hacking books to Courier bags")
    else
        print("[HackingSkill] Warning: Bag_Skillz_Mail distribution not found")
    end
end

Events.OnPostDistributionMerge.Add(patchSkillBookCourierIfModPresent)