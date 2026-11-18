CoopMod: AI data for the co-op level Multi\BOS\COOP_Patrol_2.

The game's AI loader (Bos.dll 0x100AAF10) always looks for a level's AI files
in Levels\<level name>\AI\<level name>*.pdl/.fdl/.pcl/.mdl/.awl - the folder
layout of a campaign level - even when the level lives in Levels\Multi\BOS.
These are copies of Levels\Patrol_2\AI\patrol_2* renamed to coop_patrol_2*.
Without them the NPCs in COOP_Patrol_2 have no AI at all.
