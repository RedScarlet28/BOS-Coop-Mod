CoopMod: AI data for the co-op level Multi\BOS\COOP_Patrol.

The game's AI loader (Bos.dll 0x100AAF10) always looks for a level's AI files
in Levels\<level name>\AI\<level name>*.pdl/.fdl/.pcl/.mdl/.awl - the folder
layout of a campaign level - even when the level lives in Levels\Multi\BOS.
These are copies of Multi\BOS\COOP_Patrol\AI\coop_patrol* (= Patrol_1's AI
data). Without them the NPCs in COOP_Patrol have no AI at all.
