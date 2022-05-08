/**************SKYRAT REWARDS**************/
//SUITS
/obj/item/clothing/suit/hooded/wintercoat/polychromic
	name = "polychromic winter coat"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "coatpoly"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/polychromic

/obj/item/clothing/suit/hooded/wintercoat/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#666666", "#CCBBAA", "#0000FF"))

//We need this to color the hood that comes up
/obj/item/clothing/suit/hooded/wintercoat/polychromic/ToggleHood()
	. = ..()
	if(hood)
		hood.color = color
		hood.update_slot_icon()

/obj/item/clothing/head/hooded/winterhood/polychromic
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "winterhood_poly"

// NECK

/obj/item/clothing/neck/cloak/colourable
	name = "colourable cloak"
	icon_state = "gags_cloak"
	greyscale_config = /datum/greyscale_config/cloak
	greyscale_config_worn = /datum/greyscale_config/cloak/worn
	greyscale_colors = "#917A57#4e412e#4e412e"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/cloak/colourable/veil
	name = "colourable veil"
	icon_state = "gags_veil"
	greyscale_config = /datum/greyscale_config/cloak/veil
	greyscale_config_worn = /datum/greyscale_config/cloak/veil/worn

/obj/item/clothing/neck/cloak/colourable/boat
	name = "colourable boatcloak"
	icon_state = "gags_boat"
	greyscale_config = /datum/greyscale_config/cloak/boat
	greyscale_config_worn = /datum/greyscale_config/cloak/boat/worn

/obj/item/clothing/neck/cloak/colourable/shroud
	name = "colourable shroud"
	icon_state = "gags_shroud"
	greyscale_config = /datum/greyscale_config/cloak/shroud
	greyscale_config_worn = /datum/greyscale_config/cloak/shroud/worn

//UNIFORMS
/obj/item/clothing/under/dress/skirt/polychromic
	name = "polychromic skirt"
	desc = "A fancy skirt made with polychromic threads."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "polyskirt"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	var/list/poly_colors = list("#FFFFFF", "#FF8888", "#888888")

/obj/item/clothing/under/dress/skirt/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors)

/obj/item/clothing/under/dress/skirt/polychromic/pleated
	name = "polychromic pleated skirt"
	desc = "A magnificent pleated skirt complements the woolen polychromatic sweater."
	icon_state = "polypleat"
	body_parts_covered = CHEST|GROIN|ARMS
	poly_colors = list("#88CCFF", "#888888", "#FF3333")

/obj/item/clothing/under/misc/poly_shirt
	name = "polychromic button-up shirt"
	desc = "A fancy button-up shirt made with polychromic threads."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "polysuit"
	supports_variations_flags = NONE

/obj/item/clothing/under/misc/poly_shirt/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#FFFFFF", "#333333", "#333333"))

/obj/item/clothing/under/misc/polyshorts
	name = "polychromic shorts"
	desc = "For ease of movement and style."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "polyshorts"
	can_adjust = FALSE
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/misc/polyshorts/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#333333", "#888888", "#888888"))

/obj/item/clothing/under/misc/polyjumpsuit
	name = "polychromic tri-tone jumpsuit"
	desc = "A fancy jumpsuit made with polychromic threads."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "polyjump"
	can_adjust = FALSE
	supports_variations_flags = NONE

/obj/item/clothing/under/misc/polyjumpsuit/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#FFFFFF", "#888888", "#333333"))

/obj/item/clothing/under/misc/poly_bottomless
	name = "polychromic bottomless shirt"
	desc = "Great for showing off your underwear in dubious style."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "polybottomless"
	body_parts_covered = CHEST|ARMS	//Because there's no bottom included
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/misc/poly_bottomless/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#888888", "#FF3333", "#FFFFFF"))

/obj/item/clothing/under/misc/polysweater
	name = "polychromic sweater"
	desc = "Why trade style for comfort? Now you can go commando down south and still be cozy up north, AND do it in whatever color you choose."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "poly_turtle"
	worn_icon_state = "poly_turtle"
	body_parts_covered = CHEST|GROIN|ARMS //Commando sweater is long but still doesnt have pants
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/misc/polysweater/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#FFFFFF"))

/obj/item/clothing/under/misc/poly_tanktop
	name = "polychromic tank top"
	desc = "For those lazy summer days."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "polyshimatank"
	body_parts_covered = CHEST|GROIN
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	var/list/poly_colors = list("#888888", "#FFFFFF", "#88CCFF")

/obj/item/clothing/under/misc/poly_tanktop/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors)

/obj/item/clothing/under/misc/poly_tanktop/female
	name = "polychromic feminine tank top"
	desc = "Great for showing off your chest in style. Not recommended for males."
	icon_state = "polyfemtankpantsu"
	poly_colors = list("#888888", "#FF3333", "#FFFFFF")

/obj/item/clothing/under/shorts/polychromic
	name = "polychromic athletic shorts"
	desc = "95% Polychrome, 5% Spandex!"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "polyshortpants"
	supports_variations_flags = NONE
	var/list/poly_colors = list("#FFFFFF", "#FF8888", "#FFFFFF")

/obj/item/clothing/under/shorts/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors)

/obj/item/clothing/under/shorts/polychromic/pantsu
	name = "polychromic panties"
	desc = "Topless striped panties. Now with 120% more polychrome!"
	icon_state = "polypantsu"
	body_parts_covered = GROIN
	supports_variations_flags = NONE
	poly_colors = list("#FFFFFF", "#88CCFF", "#FFFFFF")

/**************CKEY EXCLUSIVES*************/

// Donation reward for Grunnyyy
/obj/item/clothing/suit/jacket/ryddid
	name = "Ryddid"
	desc = "An old worn out piece of clothing belonging to a certain small demon."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "darkcoat"
	inhand_icon_state = "darkcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for Grunnyyy
/obj/item/clothing/neck/cloak/grunnyyy
	name = "black and red cloak"
	desc = "The design on this seems a little too familiar."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "infcloak"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = NONE

// Donation reward for Thedragmeme
// might make it have some flavour functionality in future, a'la rewritable piece of paper - JOKES ON YOU I'M MAKING IT DRAW
/obj/item/canvas/drawingtablet
	name = "drawing tablet"
	desc = "A portable tablet that allows you to draw. Legends say these can earn the owner a fortune in some sectors of space."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "drawingtablet"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	inhand_icon_state = "electronic"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	actions_types = list(/datum/action/item_action/dtselectcolor,/datum/action/item_action/dtcolormenu,/datum/action/item_action/dtcleargrid)
	pixel_x = 0
	pixel_y = 0
	width = 28
	height = 26
	nooverlayupdates = TRUE
	var/currentcolor = "#ffffff"
	var/list/colors = list("Eraser" = "#ffffff")

/obj/item/canvas/drawingtablet/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/dtselectcolor))
		currentcolor = input(user, "", "Choose Color", currentcolor) as color|null
	else if(istype(action, /datum/action/item_action/dtcolormenu))
		var/list/selects = colors.Copy()
		selects["Save"] = "Save"
		selects["Delete"] = "Delete"
		var/selection = input(user, "", "Color Menu", currentcolor) as null|anything in selects
		if(QDELETED(src) || !user.canUseTopic(src, BE_CLOSE))
			return
		switch(selection)
			if("Save")
				var/name = input(user, "", "Name the color!", "Pastel Purple") as text|null
				if(name)
					colors[name] = currentcolor
			if("Delete")
				var/delet = input(user, "", "Color Menu", currentcolor) as null|anything in colors
				if(delet)
					colors.Remove(delet)
			if(null)
				return
			else
				currentcolor = colors[selection]
	else if(istype(action, /datum/action/item_action/dtcleargrid))
		var/yesnomaybe = tgui_alert("Are you sure you wanna clear the canvas?", "", list("Yes", "No", "Maybe"))
		if(QDELETED(src) || !user.canUseTopic(src, BE_CLOSE))
			return
		switch(yesnomaybe)
			if("Yes")
				reset_grid()
				SStgui.update_uis(src)
			if("No")
				return
			if("Maybe")
				playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE)
				audible_message(span_warning("The [src] buzzes!"))
				return

/obj/item/canvas/drawingtablet/get_paint_tool_color()
	return currentcolor

/obj/item/canvas/drawingtablet/finalize()
	return // no finalizing this piece

/obj/structure/sign/painting/frame_canvas(mob/user,obj/item/canvas/new_canvas)
	if(istype(new_canvas, /obj/item/canvas/drawingtablet)) // NO FINALIZING THIS BITCH.
		return FALSE
	else
		return ..()

/obj/item/canvas/var/nooverlayupdates = FALSE

/obj/item/canvas/update_overlays()
	if(nooverlayupdates)
		return
	. = ..()

/datum/action/item_action/dtselectcolor
	name = "Change Color"
	desc = "Change your color."
	icon_icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

/datum/action/item_action/dtcolormenu
	name = "Color Menu"
	desc = "Select, save, or delete a color in your tablet's color menu!"
	icon_icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

/datum/action/item_action/dtcleargrid
	name = "Clear Canvas"
	desc = "Clear the canvas of your drawing tablet."
	icon_icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

// Donation reward for Thedragmeme
/obj/item/clothing/suit/furcoat
	name = "leather coat"
	desc = "A thick, comfy looking leather coat. It's got some fluffy fur at the collar and sleeves."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "furcoat"
	inhand_icon_state = "hostrench"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = NONE

// Donation reward for Thedragmeme
/obj/item/clothing/under/syndicate/tacticool/black
	name = "black turtleneck"
	desc = "Tacticool as fug. Comfy too."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "black_turtleneck"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	supports_variations_flags = NONE
	can_adjust = FALSE //There wasnt an adjustable sprite anyways
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0, WOUND = 5)	//same armor as a greyshirt - DONOR ITEMS ARE PURELY COSMETIC
	has_sensor = HAS_SENSORS	//Actually has sensors, to balance the new lack of armor

// Donation reward for Thedragmeme
/obj/item/clothing/shoes/jackboots/heel
	name = "high-heeled jackboots"
	desc = "Almost like regular jackboots... why are they on a high heel?"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/feet.dmi'
	icon_state = "heel-jackboots"
	supports_variations_flags = NONE
	uses_advanced_reskins = FALSE
	unique_reskin = NONE

// Donation reward for Bloodrite
/obj/item/clothing/shoes/clown_shoes/britches
	desc = "The prankster's standard-issue clowning shoes. They look extraordinarily cute. Ctrl-click to toggle waddle dampeners."
	name = "Britches' shoes"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/feet.dmi'
	icon_state = "clown_shoes_cute"
	supports_variations_flags = NONE
	resistance_flags = FIRE_PROOF

// Donation reward for Bloodrite
/obj/item/clothing/under/rank/civilian/clown/britches
	name = "Britches' dress"
	desc = "<i>'HONK!' (but cute)</i>"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "clowndress"
	supports_variations_flags = NONE
	resistance_flags = FIRE_PROOF

// Donation reward for Bloodrite
/obj/item/clothing/mask/gas/britches
	name = "Britches' mask"
	desc = "A true prankster's facial attire. Cute."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "cute_mask"
	inhand_icon_state = "clown_hat"
	dye_color = "clown"
	supports_variations_flags = NONE
	clothing_flags = MASKINTERNALS
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSEYES
	resistance_flags = FIRE_PROOF

// Donation reward for Farsighted Nightlight
/obj/item/clothing/mask/gas/nightlight
	name = "FAR-14C IRU"
	desc = "A close-fitting respirator designed by Forestiian Armories, commonly used by Military and Civilian Personnel alike. It reeks of Militarism."
	actions_types = list(/datum/action/item_action/adjust)
	icon_state = "sechailer"
	inhand_icon_state = "sechailer"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS //same flags as actual sec hailer gas mask
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	flags_cover = NONE
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	visor_flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	tint = 0

/obj/item/clothing/mask/gas/nightlight/ui_action_click(mob/user, action)
	adjustmask(user)

// Donation reward for TheOOZ
/obj/item/clothing/mask/kindle
	name = "\proper The mask of Kindle"
	desc = "The mask which belongs to Nanotrasen's Outpost Captain Kindle, it is the symbol of her 'Kindled' cult. The material feels like it's made entirely out of inexpensive plastic."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	icon_state = "kindle"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	inhand_icon_state = "kindle"
	supports_variations_flags = NONE
	clothing_flags = MASKINTERNALS
	flags_inv = HIDEFACIALHAIR | HIDESNOUT
	visor_flags_inv = HIDEFACIALHAIR | HIDESNOUT
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/kindle/Initialize()
	. = ..()
	AddComponent(/datum/component/knockoff,50,list(BODY_ZONE_HEAD),list(ITEM_SLOT_MASK))
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/clothing/mask/kindle/proc/on_entered(datum/source, atom/movable/movable)
	SIGNAL_HANDLER
	if(damaged_clothes == CLOTHING_SHREDDED)
		return
	if(isliving(movable))
		var/mob/living/crusher = movable
		if(crusher.m_intent != MOVE_INTENT_WALK && (!(crusher.movement_type & (FLYING|FLOATING)) || crusher.buckled))
			playsound(src, 'modular_skyrat/master_files/sound/effects/plastic_crush.ogg', 75)
			visible_message(span_warning("[crusher] steps on [src], crushing it with ease."))
			take_damage(100, sound_effect = FALSE)

/obj/item/clothing/mask/kindle/atom_destruction(damage_flag)
	. = ..()
	name = "\proper The broken mask of Kindle"
	desc = "The mask which belongs to Nanotrasen's Outpost Captain Kindle, it is the symbol of her 'Kindled' cult. The material is completely shattered in half."
	icon_state = "kindle_broken"
	inhand_icon_state = "kindle_broken"

/obj/item/clothing/mask/kindle/repair()
	. = ..()
	name = "\proper The mended mask of Kindle"
	desc = "The mask which belongs to Nanotrasen's Outpost Captain Kindle, it is the symbol of her 'Kindled' cult. The material seems extra flimsy, like it has recently been repaired in a hurry."
	icon_state = "kindle"
	inhand_icon_state = "kindle"

// Donation reward for Random516
/obj/item/clothing/head/drake_skull
	name = "skull of an ashdrake"
	desc = "How did they get this?"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	icon_state = "drake_skull"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/large-worn-icons/32x64/head.dmi'
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	supports_variations_flags = NONE

// Donation reward for Random516
/obj/item/clothing/gloves/fingerless/blutigen_wraps
	name = "Blutigen wraps"
	desc = "The one who wears these had everything and yet lost it all..."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	icon_state = "blutigen_wraps"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'

// Donation reward for Random516
/obj/item/clothing/suit/blutigen_kimono
	name = "Blutigen kimono"
	desc = "For the eyes bestowed upon this shall seek adventure..."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	icon_state = "blutigen_kimono"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = NONE

// Donation reward for Random516
/obj/item/clothing/under/custom/blutigen_undergarment
	name = "Dragon undergarments"
	desc = "The Dragon wears the sexy?"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "blutigen_undergarment"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	supports_variations_flags = NONE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/gloves/ring/hypno
	var/list/spans = list()
	actions_types = list(/datum/action/item_action/hypno_whisper)

// Donation reward for CoffeePot
/obj/item/clothing/gloves/ring/hypno/coffeepot
	name = "hypnodemon's ring"
	desc = "A pallid, softly desaturated-looking gold ring that doesn't look like it belongs. It's hard to put one's finger on why it feels at odds with the world around it - the shine coming off it looks like it could be a mismatch with the lighting in the room, or it could be that it seems to glint and twinkle occasionally when there's no obvious reason for it to - though only when you're not really looking."
	spans = list("velvet")

// Donation reward for Bippys
/obj/item/clothing/gloves/ring/hypno/bippys
	name = "hypnobot hexnut"
	desc = "A silver bolt component that once belonged to a very peculiar IPC. It's large enough to be worn as a ring on nearly any finger, and is said to amplify the voice of one's mind to another's in the softness of a Whisper..."
	icon_state = "ringsilver"
	inhand_icon_state = "sring"
	worn_icon_state = "sring"
	spans = list("hexnut")

/datum/action/item_action/hypno_whisper
	name = "Hypnotic Whisper"

/obj/item/clothing/gloves/ring/hypno/ui_action_click(mob/living/user, action)
	if(!isliving(user) || !can_use(user))
		return
	var/message = input(user, "Speak with a hypnotic whisper", "Whisper")
	if(QDELETED(src) || QDELETED(user) || !message || !user.can_speak())
		return
	user.whisper(message, spans = spans)

// Donation reward for SlippyJoe
/obj/item/clothing/head/avipilot
	name = "smuggler's flying cap"
	desc = "Shockingly, despite space winds, and the lack of any practicality, this pilot cap seems to be fairly well standing, there's a rabbit head seemingly stamped into the side of it."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "avipilotup"
	inhand_icon_state = "ushankadown"
	flags_inv = HIDEEARS|HIDEHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT //about as warm as an ushanka
	actions_types = list(/datum/action/item_action/adjust)
	supports_variations_flags = NONE
	var/goggles = FALSE

/obj/item/clothing/head/avipilot/proc/adjust_goggles(mob/living/carbon/user)
	if(user?.incapacitated())
		return
	if(goggles)
		icon_state = "avipilotup"
		inhand_icon_state = "avipilotup"
		to_chat(user, span_notice("You put all your effort into pulling the goggles up."))
	else
		icon_state = "avipilotdown"
		inhand_icon_state = "avipilotdown"
		to_chat(user, span_notice("You focus all your willpower to put the goggles down on your eyes."))
	goggles = !goggles
	if(user)
		user.head_update(src, forced = 1)
		user.update_action_buttons_icon()

/obj/item/clothing/head/avipilot/ui_action_click(mob/living/carbon/user, action)
	adjust_goggles(user)

/obj/item/clothing/head/avipilot/attack_self(mob/living/carbon/user)
	adjust_goggles(user)

// Donation reward for NetraKyram
/obj/item/clothing/under/rank/security/blueshield/netra
	name = "black and silver armored dress"
	desc = "An ankle length black and silver dress, made out of some shiny synthetic material with inlaid kevlar shards and silver reinforcements, a silver ring surrounds the collar, and it doesn't appear to have a zipper... How does somebody put this thing on anyways?"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "silver_dress"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = null
	supports_variations_flags = NONE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

// Donation reward for NetraKyram
/obj/item/clothing/gloves/netra
	name = "black and silver gloves"
	desc = "Some black gloves with silver reinforcements, made of a shiny synthetic material."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	icon_state = "silver_dress_gloves"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'

// Donation reward for NetraKyram
/obj/item/clothing/shoes/jackboots/netra
	name = "polished jackboots"
	desc = "Some standard issue jackboots, spit-shined to a reflective sheen, wreaking of the scent of silicon parade polish."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/shoes.dmi'
	icon_state = "silver_dress_boots"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/feet.dmi'
	supports_variations_flags = NONE
	uses_advanced_reskins = FALSE


/****************LEGACY REWARDS***************/
// Donation reward for inferno707
/obj/item/clothing/neck/cloak/inferno
	name = "Kiara's cloak"
	desc = "The design on this seems a little too familiar."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "infcloak"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

// Donation reward for inferno707
/obj/item/clothing/neck/inferno_collar
	name = "Kiara's collar"
	desc = "A soft black collar that seems to stretch to fit whoever wears it."
	icon_state = "infcollar"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	alternate_worn_layer = UNDER_SUIT_LAYER
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/collar
	/// What's the name on the tag, if any?
	var/tagname = null
	/// What treat item spawns inside the collar?
	var/treat_path = /obj/item/food/cookie

/obj/item/clothing/neck/inferno_collar/Initialize()
	. = ..()
	if(treat_path)
		new treat_path(src)

/obj/item/clothing/neck/inferno_collar/attack_self(mob/user)
	tagname = stripped_input(user, "Would you like to change the name on the tag?", "Name your new pet", "Kiara", MAX_NAME_LEN)
	if(tagname)
		name = "[initial(name)] - [tagname]"

// Donation reward for inferno707
/obj/item/clothing/accessory/medal/steele
	name = "Insignia Of Steele"
	desc = "An intricate pendant given to those who help a key member of the Steele Corporation."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "steele"
	medaltype = "medal-silver"

// Donation reward for inferno707
/obj/item/toy/darksabre
	name = "Kiara's sabre"
	desc = "This blade looks as dangerous as its owner."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "darksabre"
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'

/obj/item/toy/darksabre/get_belt_overlay()
	return mutable_appearance('modular_skyrat/master_files/icons/donator/obj/custom.dmi', "darksheath-darksabre")

// Donation reward for inferno707
/obj/item/storage/belt/sabre/darksabre
	name = "ornate sheathe"
	desc = "An ornate and rather sinister looking sabre sheathe."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "darksheath"

/obj/item/storage/belt/sabre/darksabre/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.set_holdable(list(
		/obj/item/toy/darksabre
		))

/obj/item/storage/belt/sabre/darksabre/PopulateContents()
	new /obj/item/toy/darksabre(src)
	update_icon()

// Donation reward for inferno707
/obj/item/clothing/suit/armor/vest/darkcarapace
	name = "dark armor"
	desc = "A dark, non-functional piece of armor sporting a red and black finish."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "darkcarapace"
	blood_overlay_type = "armor"
	dog_fashion = /datum/dog_fashion/back
	supports_variations_flags = NONE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "fire" = 0, "acid" = 0)

// Donation reward for inferno707
/obj/item/clothing/mask/hheart
	name = "Hollow Heart"
	desc = "It's an odd ceramic mask. Set in the internal side are several suspicious electronics branded by Steele Tech."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	icon_state = "hheart"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	var/c_color_index = 1
	var/list/possible_colors = list("off", "blue", "red")
	actions_types = list(/datum/action/item_action/hheart)
	supports_variations_flags = NONE

/obj/item/clothing/mask/hheart/Initialize()
	. = ..()
	update_icon()

/obj/item/clothing/mask/hheart/update_icon()
	. = ..()
	icon_state = "hheart-[possible_colors[c_color_index]]"

/datum/action/item_action/hheart
	name = "Toggle Mode"
	desc = "Toggle the color of the hollow heart."

/obj/item/clothing/mask/hheart/ui_action_click(mob/user, action)
	. = ..()
	if(istype(action, /datum/action/item_action/hheart))
		if(!isliving(user))
			return
		var/mob/living/ooser = user
		var/the = possible_colors.len
		var/index = 0
		if(c_color_index >= the)
			index = 1
		else
			index = c_color_index + 1
		c_color_index = index
		update_icon()
		ooser.update_inv_wear_mask()
		ooser.update_action_buttons_icon()
		to_chat(ooser, span_notice("You toggle the [src] to [possible_colors[c_color_index]]."))

// Donation reward for asky / Zulie
/obj/item/clothing/suit/hooded/cloak/zuliecloak
	name = "Project: Zul-E"
	desc = "A standard version of a prototype cloak given out by Nanotrasen higher ups. It's surprisingly thick and heavy for a cloak despite having most of it's tech stripped. It also comes with a bluespace trinket which calls it's accompanying hat onto the user. A worn inscription on the inside of the cloak reads 'Fleuret' ...the rest is faded away."
	icon_state = "zuliecloak"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/zuliecloak
	body_parts_covered = CHEST|GROIN|ARMS
	slot_flags = ITEM_SLOT_OCLOTHING | ITEM_SLOT_NECK //it's a cloak. it's cosmetic. so why the hell not? what could possibly go wrong?
	supports_variations_flags = NONE

/obj/item/clothing/head/hooded/cloakhood/zuliecloak
	name = "NT special issue"
	desc = "This hat is unquestionably the best one, bluespaced to and from CentComm. It smells of Fish and Tea with a hint of antagonism"
	icon_state = "zuliecap"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'
	flags_inv = null
	supports_variations_flags = NONE

// Donation reward for Lyricalpaws
/obj/item/clothing/neck/cloak/healercloak
	name = "legendary healer's cloak"
	desc = "Worn by the most skilled professional medics on the station, this legendary cloak is only attainable by becoming the pinnacle of healing. This status symbol represents the wearer has spent countless years perfecting their craft of helping the sick and wounded."
	icon_state = "healercloak"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'

// Donation reward for Kathrin Bailey / Floof Ball
/obj/item/clothing/under/custom/lannese
	name = "Lannese dress"
	desc = "An alien cultural garment for women, coming from a distant planet named Cantalan."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "lannese"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	supports_variations_flags = NONE
	inhand_icon_state = "lannese"
	can_adjust = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|LEGS|FEET

/obj/item/clothing/under/custom/lannese/vambrace
	desc = "An alien cultural garment for women, coming from a distant planet named Cantalan. Shiny vambraces included!"
	icon_state = "lannese_vambrace"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET

// Donation reward for Hacker T.Dog
/obj/item/clothing/suit/scraparmour
	name = "scrap armour"
	desc = "A shoddily crafted piece of armour. It provides no benefit apart from being clunky."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	icon_state = "scraparmor"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon_state = "scraparmor"
	body_parts_covered = CHEST

// Donation reward for Enzoman
/obj/item/clothing/mask/luchador/enzo
	name = "mask of El Red Templar"
	desc = "A mask belonging to El Red Templar, a warrior of lucha. Taking it from him is not recommended."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "luchador"
	worn_icon_state = "luchador"
	clothing_flags = MASKINTERNALS
	supports_variations_flags = NONE

// Donation Reward for Grand Vegeta
/obj/item/clothing/under/mikubikini
	name = "starlight singer bikini"
	desc = " "
	icon_state = "mikubikini"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_state = "mikubikini"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

// Donation Reward for Grand Vegeta
/obj/item/clothing/suit/mikujacket
	name = "starlight singer jacket"
	desc = " "
	icon_state = "mikujacket"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon_state = "mikujacket"

// Donation Reward for Grand Vegeta
/obj/item/clothing/head/mikuhair
	name = "starlight singer hair"
	desc = " "
	icon_state = "mikuhair"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	worn_icon_state = "mikuhair"
	flags_inv = HIDEHAIR

// Donation Reward for Grand Vegeta
/obj/item/clothing/gloves/mikugloves
	name = "starlight singer gloves"
	desc = " "
	icon_state = "mikugloves"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'
	worn_icon_state = "mikugloves"

// Donation Reward for Grand Vegeta
/obj/item/clothing/shoes/sneakers/mikuleggings
	name = "starlight singer leggings"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	desc = " "
	icon_state = "mikuleggings"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/feet.dmi'
	worn_icon_state = "mikuleggings"

// Donation reward for CandleJax
/obj/item/clothing/head/helmet/space/plasmaman/candlejax
	name = "emission's helmet"
	desc = "A special containment helmet designed for heavy usage. Multiple dings and notches are on this one."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "emissionhelm"
	inhand_icon_state = "emissionhelm"

// Donation reward for CandleJax
/obj/item/clothing/under/plasmaman/candlejax
	name = "emission's containment suit"
	desc = "A modified envirosuit featuring a reserved color scheme."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "emissionsuit"
	inhand_icon_state = "emissionsuit"

// Donation reward for CandleJax
/obj/item/clothing/glasses/zentai
	var/list/spans = list()
	actions_types = list(/datum/action/item_action/demonic_whisper)

/obj/item/clothing/glasses/zentai
	name = "demonic sunglasses"
	desc = "A devilishly fashionable set of shades. An eerie red glint is present."
	spans = list("velvet")
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon_state = "zentai"
	inhand_icon_state = "zentai"
	tint = 0
	glass_colour_type = /datum/client_colour/glass_colour/red

/datum/action/item_action/demonic_whisper
	name = "Demonic Whisper"

/obj/item/clothing/glasses/zentai/ui_action_click(mob/living/user, action)
	if(!isliving(user) || !can_use(user))
		return
	var/message = input(user, "Speak with a demonic whisper", "Whisper")
	if(QDELETED(src) || QDELETED(user) || !message || !user.can_speak())
		return
	user.whisper(message, spans = spans)

// Donation reward for CandleJax
/obj/item/clothing/head/helmet/sec/peacekeeper/jax
	name = "HepUnit standard helmet"
	desc = "An adjustable riot-grade helmet which protects the user from most forms of blunt force trauma. It comes included with floodlights for deployment in darker environments, as well as a powered visor that can be energized with a current to conceal the users face."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'

	icon_state = "hephelmet-visor-nolight"
	worn_icon_state = "hephelmet-visor-nolight"
	actions_types = list(/datum/action/item_action/togglevisor)

	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES
	visor_flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES
	var/visor = TRUE

/datum/action/item_action/togglevisor
	name = "Adjust visor"

/obj/item/clothing/head/helmet/sec/peacekeeper/jax/ui_action_click(mob/living/carbon/user, datum/action)
	. = ..()

	if(istype(action, /datum/action/item_action/togglevisor))
		visor = !visor
		if(visor)
			flags_inv = HIDEHAIR | HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
		else
			flags_inv = HIDEHAIR
		update_icon()

		if(user)
			user.head_update(src, forced = 1)
			user.update_action_buttons_icon()

/obj/item/clothing/head/helmet/sec/peacekeeper/jax/update_icon_state()
	. = ..()
	icon_state = "hephelmet-[visor ? "visor" : "novisor"]-[attached_light?.on?"light":"nolight"]"
	worn_icon_state = icon_state

// Donation reward for Raxraus
/obj/item/clothing/under/rax_turtleneck
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	name = "black turtleneck"
	desc = "A stylish black turtleneck."
	icon_state = "hosalt"
	inhand_icon_state = "bl_suit"
	alt_covers_chest = TRUE

// Donation reward for Raxraus
/obj/item/clothing/shoes/combat/rax
	name = "tactical boots"
	desc = "Tactical and sleek. This model seems to resemble Armadyne's."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/feet_digi.dmi'
	icon_state = "armadyne_boots"
	inhand_icon_state = "jackboots"
	worn_icon_state = "armadyne_boots"

// Donation reward for Raxraus
/obj/item/clothing/suit/armor/vest/warden/rax
	name = "peacekeeper jacket"
	desc = "A navy-blue armored jacket with blue shoulder designations."

// Donation reward for Raxraus
/obj/item/clothing/under/rank/security/rax
	name = "banded uniform"
	desc = "Personalized and tailored to fit, this uniform is designed to protect without compromising its stylishness."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	icon_state = "hos_black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for Raxraus
/obj/item/clothing/under/rax_turtleneck_gray
	name = "gray turtleneck"
	desc = "A stylish gray turtleneck."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/uniform_digi.dmi'
	icon_state = "bs_turtleneck"
	can_adjust = FALSE

// Donation reward for Raxraus
/obj/item/clothing/suit/jacket/rax
	name = "navy aerostatic jacket"
	desc = "An expensive jacket with a golden badge on the chest and \"NT\" emblazoned on the back. It weighs surprisingly little, despite how heavy it looks."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "blueshield"

// Donation reward for DeltaTri
/obj/item/clothing/suit/jacket/delta
	name = "grey winter hoodie"
	desc = "A plain old grey hoodie. It has some puffing on the inside, and a animal fur trim around half of the hood."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "greycoat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

// Donation reward for GoldenAlpharex
/obj/item/clothing/glasses/welding/goldengoggles
	name = "steampunk goggles"
	desc = "This really feels like something you'd expect to see sitting on top of a certain ginger's head... They have a rather fancy brass trim around the lenses."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon_state = "goldengoggles"
	slot_flags = ITEM_SLOT_EYES | ITEM_SLOT_HEAD // Making it fit in both first just so it can properly fit on the head slot in the loadout
	flash_protect = FLASH_PROTECTION_NONE
	flags_cover = GLASSESCOVERSEYES
	custom_materials = null // Don't want that to go in the autolathe
	visor_vars_to_toggle = 0
	tint = 0

	/// Was welding protection added yet?
	var/welding_upgraded = FALSE
	/// Was welding protection toggled on, if welding_upgraded is TRUE?
	var/welding_protection = FALSE
	/// The sound played when toggling the shutters.
	var/shutters_sound = 'sound/effects/clock_tick.ogg'

/obj/item/clothing/glasses/welding/goldengoggles/Initialize()
	. = ..()
	visor_toggling()

/obj/item/clothing/glasses/welding/goldengoggles/examine(mob/user)
	. = ..()
	if(welding_upgraded)
		. += "It has been upgraded with welding shutters, which are currently [welding_protection ? "closed" : "opened"]."

/obj/item/clothing/glasses/welding/goldengoggles/item_action_slot_check(slot, mob/user)
	. = ..()
	if(. && slot == ITEM_SLOT_HEAD)
		return FALSE

/obj/item/clothing/glasses/welding/goldengoggles/attack_self(mob/user)
	if(user.get_item_by_slot(ITEM_SLOT_HEAD) == src)
		to_chat(user, span_warning("You can't seem to slip those on your eyes from the top of your head!"))
		return
	. = ..()

/obj/item/clothing/glasses/welding/goldengoggles/visor_toggling()
	. = ..()
	slot_flags = up ? ITEM_SLOT_EYES | ITEM_SLOT_HEAD : ITEM_SLOT_EYES
	toggle_vision_effects()

/obj/item/clothing/glasses/welding/goldengoggles/weldingvisortoggle(mob/user)
	. = ..()
	handle_sight_updating(user)

/obj/item/clothing/glasses/welding/goldengoggles/attackby(obj/item/attacking_item, mob/living/user, params)
	if(!istype(attacking_item, /obj/item/clothing/glasses/welding))
		..()
	if(welding_upgraded)
		to_chat(user, span_warning("\The [src] was already upgraded to have welding protection!"))
		return
	qdel(attacking_item)
	welding_upgraded = TRUE
	to_chat(user, span_notice("You upgrade \the [src] with some welding shutters, offering you the ability to toggle welding protection!"))
	actions += new /datum/action/item_action/toggle_steampunk_goggles_welding_protection(src)

/// Proc that handles the whole toggling the welding protection on and off, with user feedback.
/obj/item/clothing/glasses/welding/goldengoggles/proc/toggle_shutters(mob/user)
	if(!can_use(user) || !user)
		return FALSE
	if(!toggle_welding_protection(user))
		return FALSE

	to_chat(user, span_notice("You slide \the [src]'s welding shutters slider, [welding_protection ? "closing" : "opening"] them."))
	playsound(user, shutters_sound, 100, TRUE)
	if(iscarbon(user))
		var/mob/living/carbon/carbon_user = user
		carbon_user.head_update(src, forced = 1)
	update_action_buttons()
	return TRUE

/// This is the proc that handles toggling the welding protection, while also making sure to update the sight of a mob wearing it.
/obj/item/clothing/glasses/welding/goldengoggles/proc/toggle_welding_protection(mob/user)
	if(!welding_upgraded)
		return FALSE
	welding_protection = !welding_protection

	visor_vars_to_toggle = welding_protection ? VISOR_FLASHPROTECT | VISOR_TINT : initial(visor_vars_to_toggle)
	toggle_vision_effects()
	// We also need to make sure the user has their vision modified. We already checked that there was a user, so this is safe.
	handle_sight_updating(user)
	return TRUE

/// Proc handling changing the flash protection and the tint of the goggles.
/obj/item/clothing/glasses/welding/goldengoggles/proc/toggle_vision_effects()
	if(welding_protection)
		if(visor_vars_to_toggle & VISOR_FLASHPROTECT)
			flash_protect = up ? FLASH_PROTECTION_NONE : FLASH_PROTECTION_WELDER
	else
		flash_protect = FLASH_PROTECTION_NONE
	tint = flash_protect

/// Proc handling to update the sight of the user, while forcing an update_tint() call every time, due to how the welding protection toggle works.
/obj/item/clothing/glasses/welding/goldengoggles/proc/handle_sight_updating(mob/user)
	if(user && (user.get_item_by_slot(ITEM_SLOT_HEAD) == src || user.get_item_by_slot(ITEM_SLOT_EYES) == src))
		user.update_sight()
		if(iscarbon(user))
			var/mob/living/carbon/carbon_user = user
			carbon_user.update_tint()
			carbon_user.head_update(src, forced = TRUE)

/obj/item/clothing/glasses/welding/goldengoggles/ui_action_click(mob/user, actiontype, is_welding_toggle = FALSE)
	if(!is_welding_toggle)
		return ..()
	else
		toggle_shutters(user)

/// Action button for toggling the welding shutters (aka, welding protection) on or off.
/datum/action/item_action/toggle_steampunk_goggles_welding_protection
	name = "Toggle Welding Shutters"

/// We need to do a bit of code duplication here to ensure that we do the right kind of ui_action_click(), while keeping it modular.
/datum/action/item_action/toggle_steampunk_goggles_welding_protection/Trigger(trigger_flags)
	if(!IsAvailable())
		return FALSE
	if(SEND_SIGNAL(src, COMSIG_ACTION_TRIGGER, src) & COMPONENT_ACTION_BLOCK_TRIGGER)
		return FALSE
	if(!target || !istype(target, /obj/item/clothing/glasses/welding/goldengoggles))
		return FALSE

	var/obj/item/clothing/glasses/welding/goldengoggles/goggles = target
	goggles.ui_action_click(owner, src, is_welding_toggle = TRUE)
	return TRUE

// End of the code for GoldenAlpharex's donator item :^)

// Donation reward for MyGuy49
/obj/item/clothing/suit/cloak/ashencloak
	name = "ashen wastewalker cloak"
	desc = "A cloak of advanced make. Clearly beyond what ashwalkers are capable of, it was probably pulled from a downed vessel or something. It seems to have been reinforced with goliath hide and watcher sinew, and the hood has been torn off."
	icon_state = "ashencloak"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|LEGS|ARMS
	supports_variations_flags = NONE

//Donation reward for Hacker T.Dog
/obj/item/clothing/head/nanotrasen_consultant/hubert
	name = "CC ensign's cap"
	desc = "A tailor made peaked cap, denoting the rank of Ensign."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "CCofficerhat"

//Donation reward for Hacker T.Dog
/obj/item/clothing/suit/armor/vest/nanotrasen_consultant/hubert
	name = "CC ensign's armoured vest"
	desc = "A tailor made Ensign's armoured vest, providing the same protection - but in a more stylish fashion."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "CCvest"

//Donation reward for Hacker T.Dog
/obj/item/clothing/under/rank/nanotrasen_consultant/hubert
	name = "CC ensign's uniform"
	desc = "A tailor-made Ensign's uniform, various medals and chains hang down from it."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "CCofficer"

// Donation reward for Cherno_00
/obj/item/clothing/head/ushanka/frosty
	name = "blue ushanka"
	desc = "A dark blue ushanka with a hand-stitched snowflake on the front. Cool to the touch."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "fushankadown"
	upsprite = "fushankaup"
	downsprite = "fushankadown"

// Donation reward for M97screwsyourparents
/obj/item/clothing/neck/cross
	name = "silver cross"
	desc = "A silver cross to be worn on a chain around your neck. Certain to bring you favour from up above."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/necklaces.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'
	icon_state = "cross"

// Donation reward for gamerguy14948
/obj/item/storage/belt/fannypack/occult
	name = "trinket belt"
	desc = "A belt covered in various trinkets collected through time. Doesn't look like there's much space for anything else nowadays."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/belt.dmi'
	icon_state = "occultfannypack"
	worn_icon_state = "occultfannypack"

// Donation reward for gamerguy14948
/obj/item/clothing/under/occult
	name = "occult collector's outfit"
	desc = "A set of clothes fit for someone dapper that isn't afraid of getting dirty."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "occultoutfit"
	supports_variations_flags = NONE

// Donation reward for gamerguy14948
/obj/item/clothing/head/hooded/occult
	name = "hood"
	desc = "Certainly makes you look more ominous."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "occulthood"
	supports_variations_flags = NONE

// Donation reward for gamerguy14948
/obj/item/clothing/suit/hooded/occult
	name = "occult collector's coat"
	desc = "A big, heavy coat lined with leather and ivory cloth, adorned with a hood. It looks dusty."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "occultcoat"
	hoodtype = /obj/item/clothing/head/hooded/occult
	supports_variations_flags = NONE

// Donation reward for gamerguy14948
/obj/item/toy/plush/donator/voodoo
	name = "voodoo doll"
	desc = "A not so small voodoo doll made out of cut and sewn potato bags. It almost looks cute."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "voodoo"

// Donation reward for Octus
/obj/item/clothing/mask/breath/vox/octus
	name = "sinister visor"
	desc = "Skrektastic."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	worn_icon_vox = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask_vox.dmi'
	icon_state = "death"

// Donation reward for 1ceres
/obj/item/clothing/glasses/rosecolored
	name = "rose-colored glasses"
	desc = "Goggle-shaped glasses that seem to have a HUD-like feed in some odd line-based script. It doesn’t look like they were made by NT."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon_state = "rose"

// Donation reward for Fuzlet
/obj/item/card/fuzzy_license
	name = "license to hug"
	desc = "A very official looking license. Not actually endorsed by Nanotrasen."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "license"

	var/possible_types = list(
		"hug",
		"snuggle",
		"cuddle",
		"kiss",
		"feed Dan Kelly",
		"hoard Shinzo Shore",
		"spoil friends",
		"hold hands",
		"have this license",
		"squeak",
		"cute",
		"pat",
		"administer plushies",
		"distribute cookies",
		"sex",
		"weh")

/obj/item/card/fuzzy_license/attack_self(mob/user)
	if(Adjacent(user))
		user.visible_message(span_notice("[user] shows you: [icon2html(src, viewers(user))] [src.name]."), span_notice("You show \the [src.name]."))
	add_fingerprint(user)

/obj/item/card/fuzzy_license/attackby(obj/item/used, mob/living/user, params)
	if(user.ckey != "fuzlet")
		return

	if(istype(used, /obj/item/pen) || istype(used, /obj/item/toy/crayon))
		var/choice = input(user, "Select the license type", "License Type Selection") as null|anything in possible_types
		if(!isnull(choice))
			name = "license to [choice]"

// Donation reward for 1ceres
/obj/item/sequence_scanner/korpstech
	name = "Korpstech genetics scanner"
	desc = "A hand-held sequence scanner for analyzing someone's gene sequence on the fly. This one is bright pink and has some kind of Helix shape on its back."
	icon_state = "korpsgenetic"
	inhand_icon_state = "korpsgenetic"
	worn_icon_state = "korpsgenetic"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'

// Donation reward for 1ceres
/obj/item/poster/korpstech
	name = "Korps Genetics poster"
	poster_type = /obj/structure/sign/poster/contraband/korpstech
	icon_state = "rolled_poster"

/obj/structure/sign/poster/contraband/korpstech
	name = "Korps Genetics"
	desc = "This poster bears a huge, pink helix on it, with smaller text underneath it that reads 'The Korps institute, advancing the Genetics field since 2423!'"
	icon_state = "korpsposter"

// Donation reward for Kay-Nite
/obj/item/clothing/glasses/eyepatch/rosecolored
	name = "rose-colored eyepatch"
	desc = "A customized eyepatch with a bright pink HUD floating in front of it. It looks like there's more to it than just an eyepatch, considering the materials it's made of."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon_state = "rosepatch"

// Donation reward for Cimika
/obj/item/clothing/suit/toggle/labcoat/tenrai
	name = "Tenrai labcoat"
	desc = "A labcoat crafted from a variety of pristine materials, sewn together with a frightening amount of skill. The fabric is aery, smooth as silk, and exceptionally pleasant to the touch. The golden stripes are visible in the dark, working as a beacon to the injured. A small label on the inside of it reads \"Tenrai Kitsunes Supremacy\"."
	base_icon_state = "tenraicoat"
	icon_state = "tenraicoat"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'

/obj/item/clothing/suit/toggle/labcoat/tenrai/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", alpha = src.alpha)

//Donation reward for RealWinterFrost
/obj/item/clothing/neck/cloak/fluffycloak
	name = "Cloak of the Fluffy One"
	desc = "Hugs and kisses is only what this one knows, may their hugs be for all and not for their own \"For Fuffy Use Only\"."
	icon_state = "fluffycloak"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'

/obj/item/clothing/neck/cloak/fluffycloak/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", alpha = src.alpha)


/obj/item/clothing/mask/gas/larpswat
	name = "Foam Force SWAT Mask"
	desc = "What seems to be a SWAT mask at first, is actually a gasmask that has replica parts of a SWAT mask made from cheap plastic. Hey at least it looks good if you enjoy looking like a security larper."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "larpswat"
	supports_variations_flags = NONE

// Donation reward for Cimika, on behalf of tf4
/obj/item/clothing/neck/fishpendant
	name = "fish necklace"
	desc = "A simple, silver necklace with a blue tuna pendant.\n\"L. Alazawi\" is inscribed on the back. You get the feeling it would go well with potatoes and green beans."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/necklaces.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'
	icon_state = "fishpendant"

// Donation reward for Weredoggo
/obj/item/hairbrush/tactical
	name = "tactical hairbrush"
	desc = "Sometimes, after a brush with death, a good grooming is just the thing for tactical stress relief. "
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "tacticalbrush"
	inhand_icon_state = "tacticalbrush"

// Donation reward for tobjv
/obj/item/toy/plush/donator/tesh
	name = "Squish-Me-Tesh"
	desc = "Winner of Be Made Into A Plushy by ClownCo!"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "teshplush"

// Donation reward for tobjv
/obj/item/toy/plush/donator/immovable_rod
	name = "immovable rod"
	desc = "Realistic! But also squishy and certainly not as dangerous as its real counterpart."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "immrod"

/obj/item/toy/plush/donator/immovable_rod/Bump(atom/clong)
	. = ..()
	if(isliving(clong))
		playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		return

// Donation reward for ultimarifox
/obj/item/clothing/under/rank/security/head_of_security/alt/roselia
	name = "black and red turtleneck"
	desc = "A black turtleneck with red livery attached. Reminds you of a time before the color blue. It seems padded to hell and back as well."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "hosaltred"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = null

/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga/roselia
	name = "red-tinted giga HUD gar glasses"
	desc = "GIGA GAR glasses with a security hud implanted in the lens. Reminds you of a time before the color blue."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "supergarsred"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'

//Donation reward for Konstyantyn
/obj/item/clothing/accessory/badge/holo/jade
    name = "jade holobadge"
    desc = "A strangely green holobadge. 'Lieutenant Uriah' is stamped onto it, above the letters JS."
    icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
    worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
    icon_state = "greenbadge"

