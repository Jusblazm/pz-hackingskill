-- HackingClothing_Distributions
require "Items/ProceduralDistributions"

local clothes = {
    "Base.HackerHoodieDown"
}

----------------------------------------
-- Procedural Distributions
----------------------------------------

local baseWeight = 1

local locationMultipliers = {
    ["BedroomDresser"] = 1,
    ["ClothingRack"] = 0.5,
    ["ClothingStorageAllShirts"] = 5,
    ["ClothingStoresJumpers"] = 4,
    ["CrateClothesRandom"] = 2,
    ["CrateRandomJunk"] = 0.4,
    ["DresserGeneric"] = 0.25,
    ["LaundryLoad5"] = 5,
    ["LaundryLoad6"] = 0.5,
    ["LivingRoomWardrobe"] = 0.5,
    ["PrisonIntakeLockers"] = 4,
    ["SeasonalWorkerLockers"] = 2,
    ["UniversitySideTable"] = 1,
    ["UniversityWardrobe"] = 1,
    ["WardrobeGeneric"] = 1
}

for location, multiplier in pairs(locationMultipliers) do
    local dist = ProceduralDistributions.list[location]
    if dist and dist.items then
        local items = dist.items
        for _, article in ipairs(clothes) do
            table.insert(items, article)
            table.insert(items, baseWeight * multiplier)
        end
    end
end