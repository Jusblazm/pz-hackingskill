-- HackingSkill_SimpleSkillBooksPatch
local function patchHackingBooksIfModPresent()
    if getActivatedMods():contains("SimpleSkillBooks") then
        print("[Hacking Skill] General: Simple Skill Books is active, patching hacking books")

        local patchItem = function(itemName, data)
            local item = ScriptManager.instance:getItem(itemName)
            if item then
                for k, v in pairs(data) do
                    item:DoParam(tostring(k) .. " = " .. tostring(v))
                end
            else
                print("[Hacking Skill] Warning: Item not found -> " .. itemName)
            end
        end

        patchItem("Base.BookHacking1", {
            Weight = 0.1,
            NumberOfPages = 10
        })
        patchItem("Base.BookHacking2", {
            Weight = 0.25,
            NumberOfPages = 50
        })
        patchItem("Base.BookHacking3", {
            Weight = 0.75,
            NumberOfPages = 175
        })
        patchItem("Base.BookHacking4", {
            Weight = 1.5,
            NumberOfPages = 500
        })
        patchItem("Base.BookHacking5", {
            Weight = 2,
            NumberOfPages = 800
        })

        if SkillBook then
            if not SkillBook["Hacking"] then
                print("[Hacking Skill] General: Successfully converted hacking books to Simple Skill Books")
                SkillBook["Hacking"] = {
                    perk = Perks.Hacking
                }
            end
        else
            print("[Hacking Skill] Warning: SkillBook table not found")
        end
    else
        print("[Hacking Skill] General: Simple Skill Books is not installed")
    end
end

Events.OnGameStart.Add(patchHackingBooksIfModPresent)