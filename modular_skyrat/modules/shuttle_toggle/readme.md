https://github.com/Skyrat-SS13/Skyrat-tg/pull/111

## Title: Togglable Emergency Shuttle

MODULE ID: SHUTTLE_TOGGLE

### Description:

Allows admins to toggle the emergnecy shuttle between disabled and enabled with two admin verbs. Also adds an option for admins when calling the shuttle to make it not-recallable.

### TG Proc Changes:

./code/controllers/subsystem/shuttle.dm > /datum/controller/subsystem/shuttle/proc/CheckAutoEvac()
./code/controllers/subsystem/shuttle.dm > /datum/controller/subsystem/shuttle/proc/block_recall(lockout_timer)
./code/controllers/subsystem/shuttle.dm > /datum/controller/subsystem/shuttle/proc/unblock_recall()
./code/controllers/subsystem/shuttle.dm > /datum/controller/subsystem/shuttle/proc/getShuttle(id)
./code/controllers/subsystem/shuttle.dm > /datum/controller/subsystem/shuttle/proc/canRecall()

./code/game/gamemodes/game_mode.dm > /datum/game_mode/proc/convert_roundtype()

./code/modules/admin/admin_verbs.dm > /world/proc/AVerbsAdmin()

./code/modules/admin/verbs/randomverbs.dm > /client/proc/admin_call_shuttle()
./code/modules/admin/verbs/randomverbs.dm > /client/proc/admin_cancel_shuttle()

./code/modules/shuttle/emergency.dm > /obj/machinery/computer/emergency_shuttle/ui_act()
./code/modules/shuttle/emergency.dm > /obj/docking_port/mobile/emergency/request()
./code/modules/shuttle/emergency.dm > /obj/docking_port/mobile/emergency/check()

./code/modules/shuttle/shuttle.dm > /obj/docking_port/mobile/proc/getModeStr()
./code/modules/shuttle/shuttle.dm > /obj/docking_port/mobile/proc/getTimerStr()

### Defines:

- ~skyrat_defines > #define SHUTTLE_DISABLED

### Included files that are not contained in this module:

- ./code/controllers/subsystem/shuttle.dm
- ./code/game/gamemodes/game_mode.dm
- ./code/modules/admin/admin_verbs.dm
- ./code/modules/admin/verbs/randomverbs.dm
- ./code/modules/shuttle/emergency.dm
- ./code/modules/shuttle/shuttle.dm

### Credits:

Gandalf2k15 - Creator
