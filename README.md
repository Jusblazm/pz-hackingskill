# Hacking Skill
We should have been in 1995. So many good options... Well, at least I have *WarGames* and *Sneakers*..I just hope the zombies don't ask you to play chess.\
Only on Steam's Workshop at: NOT RELEASED YET\
If found elsewhere, please report.

## What This Mod Does
Adds a new hacking skill and two new hacking-related traits to the game. Project Zomboid, due to being based in 1993 has very few hacking options, so as of this moment the mod adds nothing outside of the skill and traits.\
Ultimately, this is a **framework**. It's here to allow other modders and myself to create.

## Modders
You do **not** need to repack this skill into your mod to make use of it.

### Available Functions
``` lua
HackingSkill.addXP(player, amount)
-- Adds XP to the Hacking skill.

HackingSkill.getXP(player) -> int
-- Returns the player's current Hacking XP.

HackingSkill.getXPToNextLevel(player) -> int
-- Returns the amount of XP needed to reach the next level.

HackingSkill.getLevel(player) -> int
-- Returns the player's current Hacking level.

HackingSkill.setLevel(player, level)
-- Sets the player's Hacking level directly (use with care).

HackingSkill.isMaxLevel(player) -> boolean
-- Returns true if the player has reached the max level.

HackingSkill.reset(player) -> boolean
-- Resets the player's Hacking level to 0 (use with care).
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

On steam you can replace "Hacking Skill" with `[url=]Hacking Skill[/url]` to provide a quick link.

## 🌐 Translation Progress
<!-- AUTO-GENERATED-TABLE:START -->
| Language                | Progress      | Completed | Status        |
|-------------------------|---------------|-----------|---------------|
| 🇺🇸 English              | ██████████ 100% | 26/26     | ✅ Done      |
| 🇦🇷 Argentina            | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🏴 Catalan             | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇹🇼 Traditional Chinese  | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇨🇳 Simplified Chinese   | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇨🇿 Czech                | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇩🇰 Danish               | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇩🇪 German               | ███░░░░░░░ 27% | 7/26     | 🔃 In Progress |
| 🇪🇸 Spanish              | ██████░░░░ 58% | 15/26     | 🔃 In Progress |
| 🇫🇮 Finnish              | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇫🇷 French               | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇭🇺 Hungarian            | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇮🇩 Indonesian           | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇮🇹 Italian              | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇯🇵 Japanese             | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇰🇷 Korean               | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇳🇱 Dutch                | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇳🇴 Norwegian            | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇵🇭 Filipino             | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇵🇱 Polish               | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇵🇹 Portuguese           | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇧🇷 Brazilian Portuguese | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇷🇴 Romanian             | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇷🇺 Russian              | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇹🇭 Thai                 | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇹🇷 Turkish              | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
| 🇺🇦 Ukrainian            | ░░░░░░░░░░ 0% | 0/26     | ❌ Not Started |
<!-- AUTO-GENERATED-TABLE:END -->

### Translation Notice
Translations are done via ChatGPT and checked with Google Translate, unless otherwise noted. I do my best, but I'm sure there are some errors. If you would like to contribute please get in touch.

## Support
Come find me on discord! Be sure to grab the Project Zomboid Modding Role once you arrive.\
[![Discord](https://raw.githubusercontent.com/Jusblazm/pz-archive/refs/heads/main/_imgs/discordinvite.png)](https://discord.gg/yqstRpuGXy)
