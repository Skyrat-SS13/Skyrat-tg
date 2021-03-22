## Title: Panic bunker

MODULE ID: PANICBUNKER

### Description:

Adds a system that uses a JSON file to enable bunker bypassing. This is a very much needed update.

### TG Proc Changes:

 .code\controllers\subsystem\persistence.dm > /datum/controller/subsystem/persistence/Initialize() & /datum/controller/subsystem/persistence/proc/CollectData()
.code\modules\client\client_procs.dm > /client/proc/set_client_age_from_db()


### Defines:

 - N/A

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:
Gandalf2k15 - Porting
