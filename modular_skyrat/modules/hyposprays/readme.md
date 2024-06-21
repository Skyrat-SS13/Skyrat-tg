Original PR: https://github.com/Skyrat-SS13/Skyrat-tg/pull/1929

## Title: Hyposprays

MODULE ID: HYPOSPRAYS

### Description:

Gives Medical back its Hyposprays. Oldbase stuff is good.

### TG Proc Changes:

- CMO's locker now contains a new object, the CMO's Hypospray Kit. Old Hypospray has been commented out.
- Chemistry lockers now contain two boxes of Standard Hypospray Kits.
- Medical belts can carry the Mk II Hyposprays, vials, and Hypospray Kits.
- Adds CAT_HYPOS to ``code/_globalvars/lists/reagents.dm`` to allow vials to be printed from chem dispensers.
- Bluespace technicans get combat hypospray kits for QOL and testing.

### Defines:

- #define HYPO_SPRAY 0
- #define HYPO_INJECT 1
- #define WAIT_SPRAY 25
- #define WAIT_INJECT 25
- #define SELF_SPRAY 15
- #define SELF_INJECT 15
- #define DELUXE_WAIT_SPRAY 0
- #define DELUXE_WAIT_INJECT 5
- #define DELUXE_SELF_SPRAY 10
- #define DELUXE_SELF_INJECT 10
- #define COMBAT_WAIT_SPRAY 0
- #define COMBAT_WAIT_INJECT 0
- #define COMBAT_SELF_SPRAY 0
- #define COMBAT_SELF_INJECT 0

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:

ShadeAware - Porting
CliffracerX - Tweaks & new sprites