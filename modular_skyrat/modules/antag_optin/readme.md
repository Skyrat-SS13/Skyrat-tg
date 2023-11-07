

https://github.com/Skyrat-SS13/Skyrat-tg/pull/24381

## \<Title Antagonist Opt In>

Module ID: ANTAG_OPTIN <!-- Uppercase, UNDERSCORE_CONNECTED name of your module, that you use to mark files. This is so people can case-sensitive search for your edits, if any. -->

### Description:


Adds functionality to allow players to 'opt-in' to being an antagonist's mechanical target, with three different levels of involvement - being temporarily inconvenienced, killed, and round removed. Command roles & security are automatically opted-in to at least 'KILL' level. Additionally, contractor & heretic have their objectives adjusted to only have command staff & security as their targets

### TG Proc/File Changes:

- Changes in several antag files (will list later)
- examine_tgui.dm (Adds opt in info to OOC examine info)
- objective.dm (target selection stuff)
<!-- If you edited any core procs, you should list them here. You should specify the files and procs you changed.
E.g: 
- `code/modules/mob/living.dm`: `proc/overriden_proc`, `var/overriden_var`
-->

### Modular Overrides:

- N/A
<!-- If you added a new modular override (file or code-wise) for your module, you should list it here. Code files should specify what procs they changed, in case of multiple modules using the same file.
E.g: 
- `modular_skyrat/master_files/sound/my_cool_sound.ogg`
- `modular_skyrat/master_files/code/my_modular_override.dm`: `proc/overriden_proc`, `var/overriden_var`
-->

### Defines:

- antag_opt_in - lives in ~skyrat_defines located in __DEFINES folder. Defines named YES_KILL, YES_TEMP, YES_ROUND_REMOVE, and NOT_TARGET - used for managing opt in stuff. 
<!-- If you needed to add any defines, mention the files you added those defines in, along with the name of the defines. -->

### Included files that are not contained in this module:

- N/A
<!-- Likewise, be it a non-modular file or a modular one that's not contained within the folder belonging to this specific module, it should be mentioned here. Good examples are icons or sounds that are used between multiple modules, or other such edge-cases. -->

### Credits:

A large amount of the code here is graciously borrowed from the Effigy server's antag opt-in code, found at: effigy-se/effigy-se#427 Many thanks to them.
