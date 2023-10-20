/obj/item/autosurgeon/toolset
	starting_organ = /obj/item/organ/internal/cyberimp/arm/toolset

/obj/item/autosurgeon/surgery
	starting_organ = /obj/item/organ/internal/cyberimp/arm/surgery

/obj/item/autosurgeon/botany
	starting_organ = /obj/item/organ/internal/cyberimp/arm/botany

/obj/item/autosurgeon/armblade
	starting_organ = /obj/item/organ/internal/cyberimp/arm/armblade

/obj/item/autosurgeon/muscle
	starting_organ = /obj/item/organ/internal/cyberimp/arm/muscle

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
