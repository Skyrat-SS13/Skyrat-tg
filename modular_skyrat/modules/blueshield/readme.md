https://github.com/Skyrat-SS13/Skyrat-tg/pull/127

## Title: Blueshield

MODULE ID: BLUESHIELD

### Description:

Adds the blueshield job to the game. It does not however add the blueshield office to the map. This includes all the blueshields items and job descriptors.

### TG Proc Changes:

- code/modules/jobs/jobs.dm > GLOBAL_LIST_INIT(security_positions, list()
- code/modules/jobs/access.dm > /proc/get_all_accesses()

### Defines:

- #define JOB_DISPLAY_ORDER_BLUESHIELD 34
- #define ACCESS_BLUESHIELD 71

### Master file additions

- ./modular_skyrat/master_files/icons/mob/hud.dmi #NEW
- ./modular_skyrat/master_files/icons/clothing/hands.dmi #NEW
- ./modular_skyrat/master_files/icons/obj/clothing/gloves.dmi #NEW

### Included files that are not contained in this module:

- N/A

### Credits:

Gandalf2k15 - Porting
