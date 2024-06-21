
//BeanieStation13 Redux

//Plus a bobble hat, lets be inclusive!!

/obj/item/clothing/head/beanie
	name = "beanie"
	desc = "A stylish beanie. The perfect winter accessory for those with a keen fashion sense, and those who just can't handle a cold breeze on their heads."
	icon = 'icons/obj/clothing/head/beanie.dmi'
	worn_icon = 'icons/mob/clothing/head/beanie.dmi'
	icon_state = "beanie"
	icon_preview = 'icons/obj/fluff/previews.dmi'
	icon_state_preview = "beanie_cloth"
	custom_price = PAYCHECK_CREW * 1.2
	greyscale_colors = "#EEEEEE#EEEEEE"
	greyscale_config = /datum/greyscale_config/beanie
	greyscale_config_worn = /datum/greyscale_config/beanie/worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/beanie/black
	name = "black beanie"
	greyscale_colors = "#4A4A4B#4A4A4B"

/obj/item/clothing/head/beanie/red
	name = "red beanie"
	greyscale_colors = "#D91414#D91414"

/obj/item/clothing/head/beanie/darkblue
	name = "dark blue beanie"
	greyscale_colors = "#1E85BC#1E85BC"

/obj/item/clothing/head/beanie/yellow
	name = "yellow beanie"
	greyscale_colors = "#E0C14F#E0C14F"

/obj/item/clothing/head/beanie/orange
	name = "orange beanie"
	greyscale_colors = "#C67A4B#C67A4B"

/obj/item/clothing/head/beanie/christmas
	name = "christmas beanie"
	greyscale_colors = "#038000#960000"

/obj/item/clothing/head/beanie/durathread
	name = "durathread beanie"
	desc = "A beanie made from durathread, its resilient fibres provide some protection to the wearer."
	icon_preview = 'icons/obj/fluff/previews.dmi'
	icon_state_preview = "beanie_durathread"
	greyscale_colors = "#8291A1#8291A1"
	armor_type = /datum/armor/beanie_durathread

/obj/item/clothing/head/rasta
	name = "rastacap"
	desc = "Perfect for tucking in those dreadlocks."
	icon = 'icons/obj/clothing/head/beanie.dmi'
	worn_icon = 'icons/mob/clothing/head/beanie.dmi'
	icon_state = "beanierasta"

/obj/item/clothing/head/waldo
	name = "red striped bobble hat"
	desc = "If you're going on a worldwide hike, you'll need some cold protection."
	icon = 'icons/obj/clothing/head/beanie.dmi'
	worn_icon = 'icons/mob/clothing/head/beanie.dmi'
	icon_state = "waldo_hat"

//No dog fashion sprites yet :(  poor Ian can't be dope like the rest of us yet

/obj/item/clothing/head/beanie/black/dboy
	name = "test subject beanie"
	desc = "A dingy and torn black beanie. Is that slime or grease?"
	/// Used for the extra flavor text the d-boy himself sees
	var/datum/weakref/beanie_owner = null

/datum/armor/beanie_durathread
	melee = 15
	bullet = 5
	laser = 15
	energy = 25
	bomb = 10
	fire = 30
	acid = 5

/obj/item/clothing/head/beanie/black/dboy/equipped(mob/user, slot)
	. = ..()
	if(iscarbon(user) && !beanie_owner)
		beanie_owner = WEAKREF(user)

/obj/item/clothing/head/beanie/black/dboy/examine(mob/user)
	. = ..()
	if(IS_WEAKREF_OF(user, beanie_owner))
		. += span_purple("It's covered in otherworldly debris only your eyes have been ruined enough to see.")
