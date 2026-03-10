-- HackingBooks_Distributions
require "Items/ProceduralDistributions"

local bookWeights = {
    ["Base.BookHacking1"] = 2.0,
    ["Base.BookHacking2"] = 1.5,
    ["Base.BookHacking3"] = 1.0,
    ["Base.BookHacking4"] = 0.5,
    ["Base.BookHacking5"] = 0.2,
}

local locationMultipliers = {
    ["UniversityLibraryBooks"] = 2.5,
    ["BookstoreComputer"] = 2.0,
    ["BookstoreFantasySciFi"] = 2.0,
    ["LibraryBooks"] = 1.5,
    ["BookstoreBooks"] = 1.0,
    ["CrateBooks"] = 0.8,
    ["SafehouseBookShelf"] = 0.6,
    ["PostOfficeBooks"] = 0.5,
    ["LivingRoomShelf"] = 0.5,
    ["CrateBooksSchool"] = 0.4,
    ["ClassroomMisc"] = 0.2,
    ["SafehouseFireplace"] = 0.2,
    ["ClassroomSecondaryMisc"] = 0.1,
    ["SafehouseFireplace_Late"] = 0.1,
}

local setSpawnLocations = {
    ["UniversityLibraryBooks"] = 0.2,
    ["BookstoreComputer"] = 0.1,
    ["LibraryBooks"] = 0.05,
}

for location, baseWeight in pairs(setSpawnLocations) do
    local items = ProceduralDistributions.list[location] and ProceduralDistributions.list[location].items
    if items then
        table.insert(items, "Base.BookHackingSet")
        table.insert(items, baseWeight)
    end
end

for location, multiplier in pairs(locationMultipliers) do
    local dist = ProceduralDistributions.list[location]
    if dist and dist.items then
        local items = dist.items
        for book, baseWeight in pairs(bookWeights) do
            local finalWeight = baseWeight * multiplier
            table.insert(items, book)
            table.insert(items, finalWeight)
        end
    end
end