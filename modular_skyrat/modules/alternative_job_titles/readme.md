## Title: Alternative Job Titles

MODULE ID: ALTERNATIVE_JOB_TITLES

### Description:

Adds functionality to custom job titles, making them show up in manifests, ID's and announcements.
Unfortunately, all 3 of the categories are not set up to be very modular, so this almost entirely consists of TG proc changes.

### TG Proc Changes:

- ./code/controllers/subsystem/job.dm > /datum/controller/subsystem/job/proc/EquipRank()
- ./code/datums/datacore.dm > /datum/datacore/proc/get_manifest(), /datum/datacore/proc/get_manifest_html(), /datum/datacore/proc/manifest_inject()
- ./code/modules/admin/verbs/admingame.dm > /client/proc/respawn_character()
- ./code/modules/jobs/job_types/_job.dm > /datum/job/proc/announce_job(), /datum/job/proc/announce_head()
- ./code/modules/mob/dead/new_player/new_player.dm > /mob/dead/new_player/proc/AttemptLateSpawn()

### Defines:

- N/A

### Included files that are not contained in this module:

- ./tgui/packages/tgui/interfaces/CrewManifest.js
- ./tgui/packages/tgui/interfaces/NtosCrewManifest.js

### Credits:
Tastyfish
