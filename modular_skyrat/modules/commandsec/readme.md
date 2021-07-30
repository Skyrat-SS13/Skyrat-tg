https://github.com/Skyrat-SS13/Skyrat-tg/pull/127

## Title: Command Secretary

MODULE ID: COMMAND SECRETARY

### Description:

Adds the Command Secretary job to the game. This includes all the Command Secretary's items and job descriptors.

### TG Proc Changes:

- code/modules/jobs/jobs.dm > GLOBAL_LIST_INIT(security_positions, list()
- code/modules/jobs/access.dm > /proc/get_all_accesses()

### Defines:

- #define JOB_DISPLAY_ORDER_BLUESHIELD 34
- #define ACCESS_BLUESHIELD 71

### Master file additions


### Included files that are not contained in this module:

- N/A

### Credits:

Viro - Porting
