<https://github.com/Skyrat-SS13/Skyrat-tg/pull/4032>

## Title: Stuff to accomodate multiple servers talking to the same database.

MODULE ID: MULTISERVER

### Description:

So far includes:  
Toggle between local and global bans.  
Ability to more easily organize statistics from separate servers in the database.  

It isn't coded in an idiotproof way, so make sure your configs and db are up to date before merging this.  

### TG Proc/File Changes:

- `**code/controllers/subsystem/blackbox.dm**` - added a column with server name in death logs and population statistics
- `**code/controllers/subsystem/dbcore.dm**` - added a column with server name in round logs
- `**code/modules/admin/IsBanned.dm**`, `**code/modules/admin/sql_ban_system.dm**` - a column with server name and tracking whether the bans are global, also altered the banning panel to allow global/local ban choices
- `**code/modules/admin/sql_message_system.dm**` - notes are cross-server, but now they track which server they were applied on
- `**code/modules/client/client_procs.dm**` - added a column with server name in server login logs
- `**code/__DEFINES/subsystems.dm**` - Increment minor version of DB schema


### Defines:

- #define DB_MINOR_VERSION 12 -> 13

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:
Implementing on Skyrat: Useroth

Heavily inspired by the solutions presented in the [BeeStation-Hornet codebase](https://github.com/BeeStation/BeeStation-Hornet)

Hard to really pinpoint all the original authors of the code due to the incredible web of ports involved in this, including some now removed code that was present in the tg codebase in the past, but I'll try the major ones who put the effort into porting or implementing it in the first place.  
Feel free to poke me if I omitted anyone.  

[MarkSuckeberg](https://github.com/MarkSuckerberg)  
[Crossedfall](https://github.com/Crossedfall)  
[qwertyqwerty](https://github.com/qwertyquerty)  

### Patch Log
PR: https://github.com/Skyrat-SS13/Skyrat-tg/pull/4785
