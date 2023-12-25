https://github.com/Skyrat-SS13/Skyrat-tg/pull/22145

## Title: Delam SCRAM (Suppression System)

MODULE ID: DELAM_SCRAM

### Description:

Adds an emergency stop for the supermatter engine. Operable in the first 30 minutes, allows Engineering to screw up without admin intervention to delete the crystal.

### TG Proc Changes:

File Location | Changed TG Proc
------------- | ---------------
`code/modules/power/supermatter/supermatter.dm`
`/obj/machinery/power/supermatter_crystal/proc/count_down`

`code/modules/power/supermatter/supermatter_delamination/_sm_delam.dm`
`/datum/sm_delam/proc/delam_progress(obj/machinery/power/supermatter_crystal/sm)`

### TG File Changes:

- code/modules/power/supermatter/supermatter.dm
- code/modules/power/supermatter/supermatter_delamination/_sm_delam.dm

### Defines:

File Location | Defines
------------- | -------
code/__DEFINES/~skyrat_defines/signals.dm		| `#define COMSIG_MAIN_SM_DELAMINATING "delam_time"`

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:
- LT3
