https://github.com/Skyrat-SS13/Skyrat-tg/pull/

## Title: AI Encryptionkey

MODULE ID: AI_ENCRYPTIONKEY

### Description:
Adds the possibility to insert/remove encryptionkeys in the AI Core

### TG Proc/File Changes:
code/game/objects/items/devices/radio/headset.dm : `proc/screwdriver_act (check to make sure you cant remove special ai encryptionkey)`
code/modules/mob/living/silicon/ai/ai.dm : `proc/verb/deploy_to_shell (add/remove cores key to shell)`
code/modules/mob/living/silicon/ai/examine.dm : `examine(if/not key exist)`
code/modules/mob/living/silicon/robot/robot_defense.dm : `proc/attackby encryptionkey (if its a shell, it will not let you add a key)`

### Defines:

### Credits:
Couchdog~
