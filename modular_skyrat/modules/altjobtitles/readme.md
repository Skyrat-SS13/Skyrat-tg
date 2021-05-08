https://github.com/Skyrat-SS13/Skyrat-tg/pull/5150

## Title: Alternative Job Titles

MODULE ID: ALTJOBTITLES

### Description:

Ports alternative job titles from oldbase, making the necessary changes to make it actually work.

### TG Proc Changes:

- /proc/AnnounceArrival() - (code/_HELPERS/game.dm) - Moved to modular
- /datum/controller/subsystem/job/proc/EquipRank() - (code/controllers/subsystem/job.dm)
- /datum/datacore/proc/get_manifest() - (code/datums/datacore.dm) - Moved to modular
- /datum/datacore/proc/manifest_inject() - (code/datums/datacore.dm)
- /datum/crewmonitor/proc/update_data() - (code/game/machinery/computer/crew.dm)
- /datum/job/proc/equip() - (code/modules/jobs/job_types/_job.dm)
- /datum/outfit/job/post_equip() - (code/modules/jobs/job_types/_job.dm)
- /datum/job/proc/announce_head() - (code/modules/jobs/job_types/_job.dm) - Moved to modular
- /datum/job/security_officer/after_spawn() - (code/modules/jobs/job_types/security_officer.dm)

### Defines:
(i don't know if these count but)
- Global lists for each department's alt title (command_altttles, security_alttitles etc.)

### Master file additions

- N/A

### Edited files that are not contained in this module:

- modular_skyrat/master_files/code/modules/mob/living/dead/new_player/new_player.dm - Updated latejoin job selection
- modular_skyrat/modules/customization/modules/client/preferences.dm - Title selection
- modular_skyrat/modules/customization/modules/client/preferences_savefile.dm - Saving of title selection

### Credits:
FlamingLily - Porting and Refactoring

Azarak - OG code - https://github.com/Skyrat-SS13/Skyrat13/pull/1887

