-- HackingSkill_CatalogsLoader
local gameVersion = getCore():getVersionNumber()
local MailOrderCatalogs = nil

if gameVersion and tonumber(gameVersion) >= 42 then
    MailOrderCatalogs = "\\JusMailOrderCatalogs"
else
    MailOrderCatalogs = "JusMailOrderCatalogs"
end

if getActivatedMods():contains(MailOrderCatalogs) then
    local registrar = require("MailOrderCatalogs_CatalogRegistrar")

    local function registerCatalogs()
        local site = require("catalogs/hackingskill_com")
        local catalog = "Base.HackingSkillCatalog"
        registrar.registerWebsite(site, catalog)
    end
    Events.OnInitGlobalModData.Add(registerCatalogs)
    Events.OnGameStart.Add(registerCatalogs)
end