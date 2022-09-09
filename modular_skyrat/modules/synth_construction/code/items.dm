#define CHOICE_TEXT "Select an interface to convert to."
#define CHOICE_TITLE "Interface Conversion"
#define CHOICE_TIMEOUT 1 MINUTES
#define CHOICE_TIME 20 SECONDS

#define CHOICE_ITEMS list( \
	"Man-Machine Interface", \
	"Positronic Brain", \
	"Compact AI Module", \
	"Synthetic Man-Machine Interface", \
	"Synthetic Positronic Brain", \
	"Synthetic Compact AI Module", \
)

#define CHOICE_ITEMS_TO_TYPE list( \
	"Man-Machine Interface" = /obj/item/mmi, \
	"Positronic Brain" = /obj/item/mmi/posibrain, \
	"Compact AI Module" = /obj/item/mmi/posibrain, \
	"Synthetic Man-Machine Interface" = /obj/item/organ/internal/brain/ipc_positron/*/mmi*/, \
	"Synthetic Positronic Brain" = /obj/item/organ/internal/brain/ipc_positron, \
	"Synthetic Compact AI Module" = /obj/item/organ/internal/brain/ipc_positron/*/circuit*/, \
)

#define CHOICE_MMI "Man-Machine Interface"
#define CHOICE_POSIBRAIN "Positronic Brain"
#define CHOICE_CIRCUIT "Compact AI Module"
#define CHOICE_SYNTH_MMI "Synthetic Man-Machine Interface"
#define CHOICE_SYNTH_POSIBRAIN "Synthetic Positronic Brain"
#define CHOICE_SYNTH_CIRCUIT "Synthetic Compact AI Module"

/obj/item/synth_brain_converter
	name = "synthetic intelligence converter"
	desc = "An advanced tool for reconfiguring a cyborg-compatible brain into it's chosen form. It has a recepticle for inserting a compatible brain."
	icon = 'icons/obj/objects.dmi'
	icon_state = "oldshieldon"

/obj/item/synth_brain_converter/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/mmi))
		playsound(src, pick('sound/machines/buzz-sigh.ogg', 'sound/machines/buzz-two.ogg'), 25, ignore_walls = FALSE)
		user.show_message(span_warning("The targeted object is not a valid cyborg MMI, posibrain, or compact AI circuit!"))
		return

	var/obj/item/mmi/old_mmi = attacking_item

	if(!old_mmi.brain || !old_mmi.brainmob || !old_mmi.brainmob.mind)
		playsound(src, pick('sound/machines/buzz-sigh.ogg', 'sound/machines/buzz-two.ogg'), 25, ignore_walls = FALSE)
		user.show_message(span_warning("The targeted object has no functioning brain!"))
		return

	var/choice = tgui_input_list(user, CHOICE_TEXT, CHOICE_TITLE, CHOICE_ITEMS, CHOICE_MMI, CHOICE_TIMEOUT)

	if((choice == /obj/item/mmi /*|| choice == /obj/item/organ/internal/brain/ipc_positron/mmi*/) && istype(old_mmi, /obj/item/mmi/posibrain))
		playsound(src, pick('sound/machines/buzz-sigh.ogg', 'sound/machines/buzz-two.ogg'), 25, ignore_walls = FALSE)
		user.show_message(span_warning("Cannot convert silicon into organic material!"))
		return

	if(do_after(user, CHOICE_TIME, src, interaction_key = CHOICE_TITLE))
		switch(choice)
			if(CHOICE_MMI, CHOICE_POSIBRAIN, CHOICE_CIRCUIT)
				var/obj/item/mmi/new_mmi = CHOICE_ITEMS_TO_TYPE[choice]
				user.temporarilyRemoveItemFromInventory(attacking_item, TRUE)
				new_mmi = new new_mmi()
				new_mmi.brain = old_mmi.brain
				old_mmi.brain = null // Avoid deleting brain to save skillchips and cycles.
				new_mmi.transfer_identity(old_mmi.brainmob)
				old_mmi.brainmob.mind.transfer_to(new_mmi.brainmob)
				qdel(old_mmi)
				user.put_in_active_hand(new_mmi, ignore_animation = TRUE)
			if(CHOICE_SYNTH_MMI, CHOICE_SYNTH_POSIBRAIN, CHOICE_SYNTH_CIRCUIT)
				var/obj/item/organ/internal/brain/brain = CHOICE_ITEMS_TO_TYPE[choice]
				brain = new brain()
				old_mmi.brain.before_organ_replacement(brain) // Avoid deleting skillchips.
				brain.transfer_identity(old_mmi.brainmob)
				qdel(old_mmi)
				user.put_in_active_hand(brain, ignore_animation = TRUE)

