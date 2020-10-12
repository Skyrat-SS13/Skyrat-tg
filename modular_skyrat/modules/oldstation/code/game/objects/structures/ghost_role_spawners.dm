/obj/effect/mob_spawn/human/oldmine
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise a mining uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "a shaft miner"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You are a  working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod."
	important_info = "Work as a team with your fellow survivors and do not abandon them."
	uniform = /obj/item/clothing/under/rank/cargo/miner
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/workboots/mining
	id = /obj/item/card/id/away/old/mine
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/survival
	r_pocket = /obj/item/storage/bag/ore
	assignedrole = "Ancient Crew Miner"
	assignedrole = "Ancient Crew"

/obj/effect/mob_spawn/human/oldmine/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldmed
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise doctor scrubs uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "a doctor"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You are a doctor working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod."
	important_info = "Work as a team with your fellow survivors and do not abandon them."
	uniform = /obj/item/clothing/under/rank/medical/doctor/blue
	shoes = /obj/item/clothing/shoes/sneakers/white
	id = /obj/item/card/id/away/old/med
	l_hand = /obj/item/storage/firstaid/regular
	l_pocket = /obj/item/stack/medical/bruise_pack
	r_pocket = /obj/item/stack/medical/ointment
	assignedrole = "Ancient Crew Medical Doctor"
	assignedrole = "Ancient Crew"

/obj/effect/mob_spawn/human/oldmed/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldass
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise an assistant uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "an assistant"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You are a staff assistant working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. The last thing \
	you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod."
	important_info = "Work as a team with your fellow survivors and do not abandon them."
	uniform = /obj/item/clothing/under/staffassistant
	shoes = /obj/item/clothing/shoes/sneakers/black
	id = /obj/item/card/id/away/old/ass
	gloves = /obj/item/clothing/gloves/color/fyellow/
	assignedrole = "Ancient Crew"

/obj/effect/mob_spawn/human/oldass/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldchap
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise a chaplain uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "a chaplain"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You are a chaplain working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. The last thing \
	you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod. At least you still have your trusty bible and null rod, \
	may your deity protect you from any harm."
	important_info = "Work as a team with your fellow survivors and do not abandon them."
	uniform = /obj/item/clothing/under/rank/civilian/chaplain
	shoes = /obj/item/clothing/shoes/sneakers/black
	id = /obj/item/card/id/away/old/chaplain
	assignedrole = "Ancient Crew"

/obj/effect/mob_spawn/human/oldchap/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldatmos
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise an atmospheric technician uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "an atmospheric technician"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You are an atmospheric technician working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod."
	important_info = "Work as a team with your fellow survivors and do not abandon them."
	uniform = /obj/item/clothing/under/rank/engineering/atmospheric_technician
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/color/black
	id = /obj/item/card/id/away/old/atmos
	l_pocket = /obj/item/analyzer
	assignedrole = "Ancient Crew Atmos Tech"
	assignedrole = "Ancient Crew"

/obj/effect/mob_spawn/human/oldatmos/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

