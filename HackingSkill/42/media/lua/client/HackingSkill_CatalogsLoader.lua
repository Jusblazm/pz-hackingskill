-- HackingSkill_CatalogsLoader
if getActivatedMods():contains("\\JusMailOrderCatalogs") then
    local registrar = require("MailOrderCatalogs_CatalogRegistrar")

    Events.OnGameStart.Add(function()
        local site = require("catalogs/hackingskill_com")
        local catalog = "Base.HackingSkillCatalog"
        registrar.registerWebsite(site, catalog)
    end)
end