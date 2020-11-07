## Title: Alerts

MODULE ID: ALERTS

### Description:

Adds new alert levels, and some extra details regarding the alerts

### TG Proc Changes:
- EDIT: code/controllers/subsystem/shuttle.dm > /datum/controller/subsystem/shuttle/proc/canRecall()
- EDIT: code/game/machinery/computer/communications.dm  > /obj/machinery/computer/communications/Topic(), /obj/machinery/computer/communications/ui_interact()
- EDIT: code/modules/mob/dead/new_player/new_player.dm > /mob/dead/new_player/proc/LateChoices()
- MOVED: code/modules/security_levels/security_levels.dm > about the entire file

### Defines:

 ./code/__DEFINES/misc.dm > moved alert defines to:  code/__DEFINES/~skyrat_defines/security_alerts.dm 

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:
Azarak - Porting
Afya - OG code
