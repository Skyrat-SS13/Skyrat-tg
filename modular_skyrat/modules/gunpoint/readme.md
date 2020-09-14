## Title: Gunpoint

MODULE ID: GUNPOINT

### Description:

Allows anyone with a gun to use SHIFT + MMB to hold someone at gunpoint, much like how baystation does it, but in a more visually clear way

### TG Proc Changes:

- /mob/living/ShiftMiddleClickOn() - overriden
- /datum/radial_menu/proc/setup_menu() - modified
- /obj/item/proc/attack_self() -modified
- /obj/item/radio/talk_into() -modified
- /obj/item/radio/talk_into() -modified
- /mob/living/carbon/human/examine() - modified
- /mob/living/proc/update_mobility() - modified
- /mob/living/proc/MobBump() - modified
- /mob/proc/toggle_move_intent() - modified

### Defines:

- /datum/radial_menu - var/icon_path

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:
Azarak - original code & porting
