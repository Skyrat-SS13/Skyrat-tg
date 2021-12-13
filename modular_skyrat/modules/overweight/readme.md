## Title: Overweight quirk

MODULE ID: Overweight

### Description:

Adds an overweight quirk that makes your character permanently fat.
Overweight quirk makes your character...
- Move a bit slower
- Harder to throw*
- Slower to drag*
- Take longer to pick up
- Take longer to stand up
- Take longer to climb tables
- Get somewhat different text when they become fat
- Get a somewhat lesser slowdown when they're fat
- Always have the 'looks very chubby' examine text
- Make chairs creak under your weight
- Get fatigued by running.

In addition, getting fat while also being overweight makes your character...
- Unable to be picked up*
- Even slower to drag*
- Take even longer to stand back up
- Unable to climb tables
- Damage chairs just by sitting on them
- Get even more fatigued when running, and able to stamcrit yourself

(* means it is negated if an oversized character is doing the thing to them)

Also fixes how people could still carry oversized people if they had latex/nitrile gloves, so this could work properly with that.

Also sorta refactors oversized's pull-slowdown to work properly with this.

### TG Proc Changes:

File Location | Changed TG Proc
------------- | ---------------
code\modules\mob\living\carbon\carbon.dm | `/mob/living/carbon/throw_item(atom/target)`
code\modules\mob\living\carbon\human\human.dm | `/mob/living/carbon/human/proc/fireman_carry(mob/living/carbon/target)`
code\modules\surgery\organs\stomach\_stomach.dm | `/obj/item/organ/stomach/proc/handle_hunger(mob/living/carbon/human/human, delta_time, times_fired)`
code\modules\mob\living\carbon\human\examine.dm | `/mob/living/carbon/human/examine(mob/user)`
code\modules\mob\living\living_movement.dm | `/mob/living/proc/update_pull_movespeed()`
code\modules\mob\living\living.dm | `/mob/living/proc/get_up(instant = FALSE)`
code\datums\elements\climbable.dm | `/datum/element/climbable/proc/climb_structure(atom/climbed_thing, mob/living/user, params)`
code\game\objects\structures\beds_chairs\chair.dm | `/obj/structure/chair/post_buckle_mob(mob/living/M)`


### TG File Changes:

- code\modules\mob\living\carbon\carbon.dm
- code\modules\mob\living\carbon\human\human.dm
- code\modules\surgery\organs\stomach\_stomach.dm
- code\modules\mob\living\carbon\human\examine.dm
- code\modules\mob\living\living_movement.dm
- code\modules\mob\living\living.dm
- code\datums\elements\climbable.dm
- code\game\objects\structures\beds_chairs\chair.dm

### Defines:

File Location | Defines
------------- | -------
modular_skyrat\modules\overweight\code\overweight_quirk.dm | `#define OVERWEIGHT_SPEED_SLOWDOWN`
modular_skyrat\modules\overweight\code\overweight_quirk.dm | `#define OVERWEIGHT_STAMINA_LOSS`
modular_skyrat\modules\overweight\code\overweight_quirk.dm | `#define OVERWEIGHT_AND_FAT_STAMINA_LOSS`
modular_skyrat\modules\overweight\code\overweight_quirk.dm | `#define OVERWEIGHT_STAMINA_DAMAGE_CAP`
modular_skyrat\modules\overweight\code\overweight_quirk.dm | `#define OVERWEIGHT_AND_FAT_CHAIR_COMPLAIN_CHANCE`
modular_skyrat\modules\overweight\code\overweight_quirk.dm | `#define OVERWEIGHT_AND_FAT_CHAIR_DAMAGE_MULTIPLIER`
code\__DEFINES\~skyrat_defines\traits.dm | `#define TRAIT_OVERWEIGHT`
code\__DEFINES\~skyrat_defines\mobs.dm | `#define PULL_OVERWEIGHT_SLOWDOWN`
code\__DEFINES\~skyrat_defines\combat.dm | `#define GET_UP_OVERWEIGHT`
code\__DEFINES\~skyrat_defines\combat.dm | `#define GET_UP_OVERWEIGHT_AND_FAT`


### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:
- Superlagg - Code
