/obj/item/autosurgeon/toolset
	starting_organ = /obj/item/organ/internal/cyberimp/arm/toolset

/obj/item/autosurgeon/surgery
	starting_organ = /obj/item/organ/internal/cyberimp/arm/surgery

/obj/item/autosurgeon/botany
	starting_organ = /obj/item/organ/internal/cyberimp/arm/botany

/obj/item/autosurgeon/janitor
	starting_organ = /obj/item/organ/internal/cyberimp/arm/janitor

/obj/item/autosurgeon/armblade
	starting_organ = /obj/item/organ/internal/cyberimp/arm/armblade

/obj/item/autosurgeon/muscle
	starting_organ = /obj/item/organ/internal/cyberimp/arm/strongarm

//syndie
/obj/item/autosurgeon/syndicate/hackerman
	starting_organ = /obj/item/organ/internal/cyberimp/arm/hacker

/obj/item/autosurgeon/syndicate/esword_arm
	starting_organ = /obj/item/organ/internal/cyberimp/arm/esword

/obj/item/autosurgeon/syndicate/nodrop
	starting_organ = /obj/item/organ/internal/cyberimp/brain/anti_drop

/obj/item/autosurgeon/syndicate/baton
	starting_organ = /obj/item/organ/internal/cyberimp/arm/baton

/obj/item/autosurgeon/syndicate/flash
	starting_organ = /obj/item/organ/internal/cyberimp/arm/flash

//bodypart
/obj/item/autosurgeon/bodypart/r_arm_robotic
	starting_bodypart = /obj/item/bodypart/arm/right/robot

/obj/item/autosurgeon/bodypart/r_arm_robotic/Initialize(mapload)
	. = ..()
	storedbodypart.icon = 'modular_skyrat/master_files/icons/mob/augmentation/hi2ipc.dmi'

//xeno-organs
/obj/item/autosurgeon/xeno
	name = "strange autosurgeon"
	icon = 'modular_skyrat/modules/moretraitoritems/icons/alien.dmi'
	surgery_speed = 2
	organ_whitelist = list(/obj/item/organ/internal/alien)

/obj/item/organ/internal/alien/plasmavessel/opfor
	stored_plasma = 500
	max_plasma = 500
	plasma_rate = 10

/obj/item/storage/organbox/strange
	name = "strange organ transport box"
	icon = 'modular_skyrat/modules/moretraitoritems/icons/alien.dmi'

/obj/item/storage/organbox/strange/Initialize(mapload)
	. = ..()
	reagents.add_reagent_list(list(/datum/reagent/cryostylane = 60))

/obj/item/storage/organbox/strange/PopulateContents()
	new /obj/item/autosurgeon/xeno(src)
	new /obj/item/organ/internal/alien/plasmavessel/opfor(src)
	new /obj/item/organ/internal/alien/resinspinner(src)
	new /obj/item/organ/internal/alien/acid(src)
	new /obj/item/organ/internal/alien/neurotoxin(src)
	new /obj/item/organ/internal/alien/hivenode(src)

/obj/item/storage/organbox/strange/eggsac/PopulateContents()
	. = ..()
	new /obj/item/organ/internal/alien/eggsac(src)
