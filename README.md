# Hacking Skill
We should have been in 1995. So many good options... Well, at least I have *WarGames* and *Sneakers*..I just hope the zombies don't ask you to play chess.\
Only on Steam's Workshop at: https://steamcommunity.com/sharedfiles/filedetails/?id=3539339798 \
If found elsewhere, please report.

## What This Mod Does
* Adds a new hacking skill and two new hacking-related traits to the game.
* Adds new Context Menu options to vehicles, doors, and windows. You can now check for active alarm systems and if they are present, you can attempt to disarm them. Be careful though, you might not always notice the alarm system.

Ultimately, this is a **framework**. It's here to allow other modders and myself to create.

## Modders
You do **not** need to repack this skill into your mod to make use of it.

### Available Functions
> ⚠️ **Note:** Players with the `Tin Foil Hat` trait cannot gain XP or levels beyond 2 in the Hacking skill.  
> The functions `addXP()` and `setLevel()` enforce this automatically.
``` lua
HackingSkill.addXP(player, amount)
-- Adds XP to the Hacking skill.
-- XP gain is blocked if the player has the Tin Foil Hat trait and is level 2 or higher.

HackingSkill.getXP(player) -> int
-- Returns the player's current Hacking XP.

HackingSkill.getXPToNextLevel(player) -> int
-- Returns the amount of XP needed to reach the next level.

HackingSkill.getLevel(player) -> int
-- Returns the player's current Hacking level.

HackingSkill.setLevel(player, level)
-- Sets the player's Hacking level directly (use with care).
-- Levels above 2 are ignored if the player has the Tin Foil Hat trait.

HackingSkill.isMaxLevel(player) -> boolean
-- Returns true if the player has reached the max level.

HackingSkill.reset(player) -> boolean
-- Returns true after resetting the player's Hacking level to 0 (use with care).

HackingSkill.hasTinFoilHatTrait(player) -> boolean
-- Returns true if the player has the Tin Foil Hat trait.

HackingSkill.isBlockedByTinFoilHatTrait(player) -> boolean
-- Returns true if the player has the Tin Foil Hat trait and a Hacking level of 2.
```

### Optional Support
This mod is set up to be supported optionally. Meaning you do not need to require it as a dependency, but can take advantage of it if it's present.

To safely support the Hacking skill without causing errors for users who don’t have it installed, wrap your calls with this pattern:
``` lua
 -- Give 10 XP to the Hacking skill if the player has the Hacking Skill installed.
if HackingSkill and Perks.Hacking then
    HackingSkill.addXP(player, 10)
end
```
This ensures compatibility while allowing enhanced features for players who have Hacking Skill installed and active.

### Announce you support Hacking Skill!
> This mod optionally supports the "Hacking Skill" mod. If Hacking Skill is installed, players can gain Hacking XP through relevant actions.

On steam you can replace "Hacking Skill" with `[url=https://steamcommunity.com/sharedfiles/filedetails/?id=3539339798]Hacking Skill[/url]` to provide a quick link.

## 🌐 Translation Progress
<!-- AUTO-GENERATED-TABLE:START -->
| Language                | Progress      | Completed | Status        |
|-------------------------|---------------|-----------|---------------|
| 🇺🇸 English              | ██████████ 100% | 30/30     | ✅ Done      |
| 🇦🇷 Argentina            | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🏴 Catalan             | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🇹🇼 Traditional Chinese  | █████████░ 93% | 28/30     | 🔃 In Progress |
| 🇨🇳 Simplified Chinese   | █████████░ 93% | 28/30     | 🔃 In Progress |
| 🇨🇿 Czech                | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🇩🇰 Danish               | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🇩🇪 German               | █████████░ 93% | 28/30     | 🔃 In Progress |
| 🇪🇸 Spanish              | █████░░░░░ 50% | 15/30     | 🔃 In Progress |
| 🇫🇮 Finnish              | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🇫🇷 French               | █████████░ 93% | 28/30     | 🔃 In Progress |
| 🇭🇺 Hungarian            | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🇮🇩 Indonesian           | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🇮🇹 Italian              | █████████░ 93% | 28/30     | 🔃 In Progress |
| 🇯🇵 Japanese             | █████████░ 93% | 28/30     | 🔃 In Progress |
| 🇰🇷 Korean               | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🇳🇱 Dutch                | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🇳🇴 Norwegian            | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🇵🇭 Filipino             | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🇵🇱 Polish               | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🇵🇹 Portuguese           | █████████░ 93% | 28/30     | 🔃 In Progress |
| 🇧🇷 Brazilian Portuguese | █████████░ 93% | 28/30     | 🔃 In Progress |
| 🇷🇴 Romanian             | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🇷🇺 Russian              | █████████░ 93% | 28/30     | 🔃 In Progress |
| 🇹🇭 Thai                 | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🇹🇷 Turkish              | ░░░░░░░░░░ 0% | 0/30     | ❌ Not Started |
| 🇺🇦 Ukrainian            | █████████░ 93% | 28/30     | 🔃 In Progress |
<!-- AUTO-GENERATED-TABLE:END -->

### Translation Notice
Translations are done via ChatGPT and checked with Google Translate, unless otherwise noted. I do my best, but I'm sure there are some errors. If you would like to contribute please get in touch.

### Translation Credits
A hearty thank you to everyone who contributed to translations for Hacking Skill. If a language is listed here it has been or is being translated by someone!\
🇪🇸 Spanish: [Wondermama1](https://www.twitch.tv/wondermama1)

## Support
Come find me on discord! Be sure to grab the Project Zomboid Modding Role once you arrive.\
[![Discord](https://raw.githubusercontent.com/Jusblazm/pz-archive/refs/heads/main/_imgs/discordinvite.png)](https://discord.gg/yqstRpuGXy)
