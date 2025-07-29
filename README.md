# Hacking Skill
We should have been in 1995. So many good options... Well, at least I have WarGames and Sneakers..I just hope the zombies don't ask you to play chess.\
Only on Steam's Workshop at: NOT RELEASED YET\
If found elsewhere, please report.

## What This Mod Does
Adds a new hacking skill and two new hacking-related traits to the game. Project Zomboid, due to being based in 1993 has very few hacking options, so as of this moment the mod adds very little, by itself, outside of the skill and traits themselves.\
Ultimately, this is a **framework**. It's here to allow other modders and myself to create.

## Modders
You do **not** need to repack this skill into your mod to make use of it. You don't even need to require it if you don't want to.\
All you have to do is call `HackingSkill.addXP(player, amount)` to give players experience, if they have the mod installed. The framework will take care of the rest. I recommend wrapping your call for safety so that there are no gamebreaking bugs for users not using this mod.

Here's an example call:
``` lua
if HackingSkill and Perks.Hacking then
    HackingSkill.addXP(player, 10) -- gives the player 2.5XP
end
```
Project Zomboid deals with XP in .25XP. That means 1 = .25XP, 2 = .5XP, 4 = 1XP, etc.

# Hacking Skill
We should have been in 1995. So many good options... Well, at least I have WarGames and Sneakers..I just hope the zombies don't ask you to play chess.\
Only on Steam's Workshop at: \
If found elsewhere, please report.

## What This Mod Does
Adds a new hacking skill and two new hacking-related traits to the game. Project Zomboid, due to being based in 1993 has very few hacking options, so as of this moment the mod adds very little, by itself, outside of the skill and traits themselves.\
Ultimately, this is a **framework**. It's here to allow other modders and myself to create.

## Modders
You do **not** need to repack this skill into your mod to make use of it. You don't even need to require it if you don't want to.\
All you have to do is call `HackingSkill.addXP(player, amount)` to give players experience, if they have the mod installed. The framework will take care of the rest. I recommend wrapping your call for safety so that there are no gamebreaking bugs for users not using this mod.

Here's an example call:
``` lua
if HackingSkill and Perks.Hacking then
    HackingSkill.addXP(player, 10) -- gives the player 2.5XP
end
```
Project Zomboid deals with XP in .25XP. That means 1 = .25XP, 2 = .5XP, 4 = 1XP, etc.

## 🌐 Translation Progress
<!-- AUTO-GENERATED-TABLE:START -->
| Language                | Progress      | Completed | Status        |
|-------------------------|---------------|-----------|---------------|
| 🇺🇸 English              | ██████████ 100% | 15/15     | ✅ Done      |
| 🇦🇷 Argentina            | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🏴 Catalan             | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇹🇼 Traditional Chinese  | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇨🇳 Simplified Chinese   | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇨🇿 Czech                | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇩🇰 Danish               | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇩🇪 German               | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇪🇸 Spanish              | ██████░░░░ 60% | 9/15     | 🔃 In Progress |
| 🇫🇮 Finnish              | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇫🇷 French               | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇭🇺 Hungarian            | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇮🇩 Indonesian           | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇮🇹 Italian              | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇯🇵 Japanese             | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇰🇷 Korean               | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇳🇱 Dutch                | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇳🇴 Norwegian            | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇵🇭 Filipino             | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇵🇱 Polish               | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇵🇹 Portuguese           | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇧🇷 Brazilian Portuguese | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇷🇴 Romanian             | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇷🇺 Russian              | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇹🇭 Thai                 | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇹🇷 Turkish              | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
| 🇺🇦 Ukrainian            | ░░░░░░░░░░ 0% | 0/15     | ❌ Not Started |
<!-- AUTO-GENERATED-TABLE:END -->

## Support
Come find me on discord! Be sure to grab the Project Zomboid Modding Role once you arrive.\
[![Discord](https://raw.githubusercontent.com/Jusblazm/pz-archive/refs/heads/main/_imgs/discordinvite.png)](https://discord.gg/yqstRpuGXy)
