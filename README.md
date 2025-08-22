# Hacking Skill
We should have been in 1995. So many good options... Well, at least I have *WarGames* and *Sneakers*..I just hope the zombies don't ask you to play chess.\
Only on Steam's Workshop at: https://steamcommunity.com/sharedfiles/filedetails/?id=3539339798 \
If found elsewhere, please report.

## What This Mod Does
* Adds a new hacking skill and three new hacking-related traits to the game.
* Adds new Context Menu options to vehicles, doors, and windows. You can now check for active alarm systems and if they are present, you can attempt to disarm them. Be careful though, you might not always notice the alarm system.

Ultimately, this is a **framework**. It's here to allow other modders and myself to create.

## Modders

### API for Modders
These are the **official functions** your mod can call to interact with Hacking Skill.
You do **not** need to repack or include this mod to use them.

### Available Functions
> ⚠️ **Note:** Players with the `Tin Foil Hat` trait cannot gain XP or levels beyond 2 in the Hacking skill.  
> The API functions `addXP()` and `setLevel()` **enforce this automatically**.
``` lua
HackingSkill.addXP(player, amount)
-- Adds XP to the Hacking skill.
-- XP gain is blocked if the player has the Tin Foil Hat trait and level >= 2.

HackingSkill.getXP(player) -> number
-- Returns the player's current Hacking XP.

HackingSkill.getXPToNextLevel(player) -> number
-- Returns XP required for the next level.

HackingSkill.getLevel(player) -> number
-- Returns the player's current Hacking level.

HackingSkill.setLevel(player, level)
-- Sets the player's Hacking level directly (use with care).
-- If the player has the Tin Foil Hat trait, levels above 2 are clamped to 2.

HackingSkill.isMaxLevel(player) -> boolean
-- Returns true if the player has reached the max level.

HackingSkill.reset(player) -> boolean
-- Returns true after resetting the player's Hacking level to 0 (use with care).

HackingSkill.hasTinFoilHatTrait(player) -> boolean
-- Returns true if the player has the Tin Foil Hat trait.

HackingSkill.isBlockedByTinFoilHatTrait(player) -> boolean
-- Returns true if the player has the Tin Foil Hat trait and a Hacking level >= 2
```

### Optional Support
You don't need to declare this as a dependency.
Wrap your calls to check if the skill is present, to keep compatibility for players without Hacking Skill:
``` lua
 -- Safely grant 10 XP if Hacking Skill is installed.
if HackingSkill and Perks.Hacking then
    HackingSkill.addXP(player, 10)
end
```

### Announce you support Hacking Skill!
> This mod optionally supports the "Hacking Skill" mod. If Hacking Skill is installed, players can gain Hacking XP through relevant actions.

On steam you can replace "Hacking Skill" with `[url=https://steamcommunity.com/sharedfiles/filedetails/?id=3539339798]Hacking Skill[/url]` to provide a quick link.

## 🌐 Translation Progress
<!-- AUTO-GENERATED-TABLE:START -->
| Language                | Progress      | Completed | Status        |
|-------------------------|---------------|-----------|---------------|
| 🇺🇸 English              | ██████████ 100% | 31/31     | ✅ Done      |
| 🇦🇷 Argentina            | ░░░░░░░░░░ 0% | 0/31     | ❌ Not Started |
| 🏴 Catalan             | ░░░░░░░░░░ 0% | 0/31     | ❌ Not Started |
| 🇹🇼 Traditional Chinese  | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇨🇳 Simplified Chinese   | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇨🇿 Czech                | ░░░░░░░░░░ 0% | 0/31     | ❌ Not Started |
| 🇩🇰 Danish               | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇩🇪 German               | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇪🇸 Spanish              | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇫🇮 Finnish              | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇫🇷 French               | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇭🇺 Hungarian            | ░░░░░░░░░░ 0% | 0/31     | ❌ Not Started |
| 🇮🇩 Indonesian           | ░░░░░░░░░░ 0% | 0/31     | ❌ Not Started |
| 🇮🇹 Italian              | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇯🇵 Japanese             | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇰🇷 Korean               | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇳🇱 Dutch                | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇳🇴 Norwegian            | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇵🇭 Filipino             | ░░░░░░░░░░ 0% | 0/31     | ❌ Not Started |
| 🇵🇱 Polish               | ░░░░░░░░░░ 0% | 0/31     | ❌ Not Started |
| 🇵🇹 Portuguese           | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇧🇷 Brazilian Portuguese | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇷🇴 Romanian             | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇷🇺 Russian              | ██████████ 97% | 30/31     | 🔃 In Progress |
| 🇹🇭 Thai                 | ████████░░ 77% | 24/31     | 🔃 In Progress |
| 🇹🇷 Turkish              | ░░░░░░░░░░ 0% | 0/31     | ❌ Not Started |
| 🇺🇦 Ukrainian            | ██████████ 97% | 30/31     | 🔃 In Progress |
<!-- AUTO-GENERATED-TABLE:END -->

### Translation Notice
Translations are done via ChatGPT and checked with Google Translate, unless otherwise noted. I do my best, but I'm sure there are some errors. If you would like to contribute please get in touch.

## Support
Come find me on discord! Be sure to grab the Project Zomboid Modding Role once you arrive.\
[![Discord](https://raw.githubusercontent.com/Jusblazm/pz-archive/refs/heads/main/_imgs/discordinvite.png)](https://discord.gg/yqstRpuGXy)
