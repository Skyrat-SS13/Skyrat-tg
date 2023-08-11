https://github.com/Skyrat-SS13/Skyrat-tg/pull/870

## Title: Pixel shifting for RP positioning

MODULE ID: PIXEL_SHIFT

### Description:

Adds the ability for living mobs to shift their sprite to fit an RP situation better (standing against a wall for example). Not appended to proc due to it being a busy proc

### TG Proc/File Changes:

- N/A

### Modular Overrides:

- `modular_skyrat/master_files/code/datums/keybinding/mob.dm`: `var/list/hotkey_keys`
- `modular_skyrat/master_files/code/modules/mob/living/living.dm`: `proc/set_pull_offsets`, `proc/reset_pull_offsets`
- `modular_skyrat/master_files/code/modules/mob/living/living_movement.dm`: `proc/CanAllowThrough`

### Defines:

- `code/__DEFINES/~skyrat_defines/keybindings.dm`: `COMSIG_KB_MOB_PIXEL_SHIFT_DOWN`, `COMSIG_KB_MOB_PIXEL_SHIFT_UP`
- `code/__DEFINES/~skyrat_defines/living.dm`: `COMSIG_LIVING_SET_PULL_OFFSET`, `COMSIG_LIVING_RESET_PULL_OFFSETS`, `COMSIG_LIVING_CAN_ALLOW_THROUGH`, `COMPONENT_LIVING_PASSABLE`

### Included files that are not contained in this module:

- N/A

### Credits:

Azarak - Porting
Gandalf2k15 - Refactoring
Larentoun - Moved to Component
