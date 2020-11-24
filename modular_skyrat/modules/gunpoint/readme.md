## Title: Gunpoint

MODULE ID: GUNPOINT

### Description:

Allows anyone with a gun to use SHIFT + MMB to hold someone at gunpoint, much like how baystation does it, but in a more visually clear way

### TG Proc Changes:

 ./modular_skyrat/modules/gunpoint/code/datum/gunpoint/gunpoint.dm > /mob/living/ShiftMiddleClickOn() > CHILD PROC
 ./code/_onclick/hud/radial.dm > /datum/radial_menu/proc/setup_menu()
 ./code/_onclick/item_attack.dm > /obj/item/proc/attack_self()
 ./code/game/objects/items/devices/radio/radio.dm > /obj/item/radio/talk_into()
 ./code/game/objects/items/devices/radio/headset.dm > /obj/item/radio/headset/talk_into() 
 ./code/modules/mob/living/carbon/human/examine.dm > /mob/living/carbon/human/examine()
 ./code/modules/mob/living/living.dm > /mob/living/proc/update_mobility()
 ./code/modules/mob/living/living.dm > /mob/living/proc/MobBump()
 ./code/modules/mob/mob_movement.dm > /mob/proc/toggle_move_intent()

### Defines:

 ./code/_onclick/hud/radial.dm > /datum/radial_menu - var/icon_path
 ./code/__DEFINES/~skyrat_defines/signals.dm - COMSIG_MOVABLE_RADIO_TALK_INTO, COMSIG_LIVING_UPDATED_RESTING 
 ./code/__DEFINES/~skyrat_defines/traits.dm - TRAIT_NORUNNING

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:
Azarak - original code & porting
