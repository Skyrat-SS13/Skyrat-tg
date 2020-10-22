https://github.com/Skyrat-SS13/Skyrat-tg/pull/<!--PR Number-->

## Title: <!--Title of your addition-->

MODULE ID: CULT_SACRIFICE

### Description:

Makes cult sacrifice no longer permanently kill the victim, and allows the minds of constructs to return to their original body upon death, makes shades a subtype of constructs and fixes a dividing by zero error in cult and crew number calculation.

### TG Proc Changes:

 /obj/effect/rune/convert/proc/do_sacrifice
 /datum/controller/subsystem/traumas/Initialize
 /obj/machinery/door/airlock/cult/allowed
 /obj/item/nullrod/scythe/talking/attack_self
 /obj/item/nullrod/scythe/talking/Destroy
 /obj/item/storage/book/bible/afterattack
 /datum/admins/Topic
 /datum/team/cult/proc/check_size
 /obj/effect/rune/attack_animal
 /obj/effect/rune/convert/invoke
 /obj/effect/rune/convert/proc/do_sacrifice
 /obj/item/soulstone/Destroy
 /obj/item/soulstone/proc/release_shades
 /obj/item/soulstone/proc/transfer_soul
 /proc/makeNewConstruct
 /obj/item/soulstone/proc/init_shade
 /obj/structure/closet/proc/trigger_spooky_trap
 /mob/living/carbon/examine
 /mob/proc/safe_animal




### Defines:

 code/__DEFINES/is_helpers.dm - Changed shade's path in isshade to make it a subtype of constructs
 code/__DEFINES/traits.dm - Adds a sacrificed trait
 code/_globalvars/traits.dm - Adds a sacrificed trait
<!-- If you needed to add any defines, mention the files you added those defines in -->

### Master file additions

 modular_skyrat\modules\cult_sacrifice\code\modules\mob\living\simple_animal\constructs.dm
 modular_skyrat\modules\cult_sacrifice\code\modules\mob\living\simple_animal\shade.dm
 code/__DEFINES/is_helpers.dm
 code/__DEFINES/traits.dm
 code/controllers/subsystem/traumas.dm
 code/game/machinery/doors/airlock_types.dm
 code/game/objects/items/holy_weapons.dm
 code/game/objects/items/storage/book.dm
 code/modules/admin/topic.dm
 code/modules/antagonists/cult/cult.dm
 code/modules/antagonists/cult/runes.dm
 code/modules/antagonists/wizard/equipment/soulstone.dm
 code/modules/holiday/halloween.dm
 code/modules/mob/living/carbon/examine.dm
 code/modules/mob/living/simple_animal/constructs.dm
 code/modules/mob/transform_procs.dm
<!-- Any master file changes you've made to existing master files or if you've added a new master file. Please mark either as #NEW or #CHANGE -->

### Included files that are not contained in this module:

- N/A
<!-- Likewise, be it a non-modular file or a modular one that's not contained within the folder belonging to this specific module, it should be mentioned here -->

### Credits:
	Arturlang
<!-- Here go the credits to you, dear coder, and in case of collaborative work or ports, credits to the original source of the code -->
