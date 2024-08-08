https://github.com/NovaSector/NovaSector/pull/121

## \<Title Round Removal Opt In>

Module ID: RR_OPTIN

### Description:


Adds functionality to allow players to 'opt-in' to being an antagonist's mechanical target, and for round removal. Command roles & security are automatically opted-in, contractor & heretic have their objectives adjusted to only have command staff & security as their targets

### TG Proc/File Changes:

- Changes in several antag files (will list later)
- examine_tgui.dm (Adds opt in info to OOC examine info)
- objective.dm (target selection stuff)

### Modular Overrides:

- N/A

### Defines:

- rr_opt_in - lives in ~skyrat_defines located in __DEFINES folder. Defines named RR_OPT_IN, RR_OPT_OUT - used for managing opt in stuff.

### Included files that are not contained in this module:

- tgui\packages\tgui\interfaces\PreferencesMenu\preferences\features\character_preferences\skyrat\antag_optin.tsx

### Credits:

- niko - for doing stuff and taking over
- plum - the original author
