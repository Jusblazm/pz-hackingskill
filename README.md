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
HackingSkill_API.addXP(player, amount)
-- Adds XP to the Hacking skill.
-- XP gain is blocked if the player has the Tin Foil Hat trait and level >= 2.

HackingSkill_API.getXP(player) -> number
-- Returns the player's current Hacking XP.

HackingSkill_API.getXPToNextLevel(player) -> number
-- Returns XP required for the next level.

HackingSkill_API.getLevel(player) -> number
-- Returns the player's current Hacking level.

HackingSkill_API.setLevel(player, level)
-- Sets the player's Hacking level directly (use with care).
-- If the player has the Tin Foil Hat trait, levels above 2 are clamped to 2.

HackingSkill_API.isMaxLevel(player) -> boolean
-- Returns true if the player has reached the max level.

HackingSkill_API.reset(player) -> boolean
-- Returns true after resetting the player's Hacking level to 0 (use with care).

HackingSkill_API.hasTinFoilHatTrait(player) -> boolean
-- Returns true if the player has the Tin Foil Hat trait.

HackingSkill_API.isBlockedByTinFoilHatTrait(player) -> boolean
-- Returns true if the player has the Tin Foil Hat trait and a Hacking level >= 2
```

### Optional Support
You don't need to declare this as a dependency.
Wrap your calls to check if the skill is present, to keep compatibility for players without Hacking Skill:
``` lua
 -- Safely grant 10 XP if Hacking Skill is installed.
if HackingSkill_API and Perks.Hacking then
    HackingSkill_API.addXP(player, 10)
end
```

### Announce you support Hacking Skill!
> This mod optionally supports the "Hacking Skill" mod. If Hacking Skill is installed, players can gain Hacking XP through relevant actions.

On steam you can replace "Hacking Skill" with `[url=https://steamcommunity.com/sharedfiles/filedetails/?id=3539339798]Hacking Skill[/url]` to provide a quick link.

## 🌐 Translation Progress
<!-- AUTO-GENERATED-TABLE:START -->
| Language                | Progress      | Completed | Status        |
|-------------------------|---------------|-----------|---------------|
| 🇺🇸 English              | ██████████ 100% | 62/62     | ✅ Done      |
| 🇦🇷 Argentina            | ██████░░░░ 61% | 38/62     | 🔃 In Progress |
| 🏴 Catalan             | ██████░░░░ 61% | 38/62     | 🔃 In Progress |
| 🇹🇼 Traditional Chinese  | █████████░ 87% | 54/62     | 🔃 In Progress |
| 🇨🇳 Simplified Chinese   | █████████░ 87% | 54/62     | 🔃 In Progress |
| 🇨🇿 Czech                | ██████░░░░ 61% | 38/62     | 🔃 In Progress |
| 🇩🇰 Danish               | ██████░░░░ 61% | 38/62     | 🔃 In Progress |
| 🇩🇪 German               | █████████░ 87% | 54/62     | 🔃 In Progress |
| 🇪🇸 Spanish              | █████████░ 87% | 54/62     | 🔃 In Progress |
| 🇫🇮 Finnish              | ██████░░░░ 61% | 38/62     | 🔃 In Progress |
| 🇫🇷 French               | ██████░░░░ 61% | 38/62     | 🔃 In Progress |
| 🇭🇺 Hungarian            | ██████░░░░ 61% | 38/62     | 🔃 In Progress |
| 🇮🇩 Indonesian           | ██████░░░░ 61% | 38/62     | 🔃 In Progress |
| 🇮🇹 Italian              | █████████░ 87% | 54/62     | 🔃 In Progress |
| 🇯🇵 Japanese             | █████████░ 87% | 54/62     | 🔃 In Progress |
| 🇰🇷 Korean               | █████████░ 87% | 54/62     | 🔃 In Progress |
| 🇳🇱 Dutch                | █████████░ 87% | 54/62     | 🔃 In Progress |
| 🇳🇴 Norwegian            | ██████░░░░ 61% | 38/62     | 🔃 In Progress |
| 🇵🇭 Filipino             | ██████░░░░ 61% | 38/62     | 🔃 In Progress |
| 🇵🇱 Polish               | ██████░░░░ 61% | 38/62     | 🔃 In Progress |
| 🇵🇹 Portuguese           | █████████░ 87% | 54/62     | 🔃 In Progress |
| 🇧🇷 Brazilian Portuguese | █████████░ 87% | 54/62     | 🔃 In Progress |
| 🇷🇴 Romanian             | ██████░░░░ 61% | 38/62     | 🔃 In Progress |
| 🇷🇺 Russian              | █████████░ 87% | 54/62     | 🔃 In Progress |
| 🇹🇭 Thai                 | ██████░░░░ 61% | 38/62     | 🔃 In Progress |
| 🇹🇷 Turkish              | ██████░░░░ 61% | 38/62     | 🔃 In Progress |
| 🇺🇦 Ukrainian            | █████████░ 87% | 54/62     | 🔃 In Progress |
<!-- AUTO-GENERATED-TABLE:END -->

### Translation Notice
Translations are provided by AI for your benefit. There are bound to be some errors. If you would like to contribute, please reach out to me; I will happily replace AI-generated translations.

## Support
Come find me on discord! Be sure to grab the Project Zomboid Modding Role once you arrive.\
[![Discord](https://raw.githubusercontent.com/Jusblazm/pz-archive/refs/heads/main/_imgs/discordinvite.png)](https://discord.gg/yqstRpuGXy)

A simple like and a favorite is more than enough, but if you would like to do more:\
[![Ko-fi](https://i.imgur.com/vs8dr3R.png)](https://ko-fi.com/jusblazm)
