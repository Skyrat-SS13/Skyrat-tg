/obj/machinery/vending/dorms
	name = "LustWish"
	desc = "A vending machine with various toys. Not for the faint of heart."
	icon_state = "lustwish"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/lustwish.dmi'
	light_mask = "lustwish-light-mask"
	age_restrictions = TRUE
	var/card_used = FALSE
	var/current_color = "pink"
	var/static/list/vend_designs
	product_ads = "Try me!;Kinky!;Lewd and fun!;Hey you, yeah you... wanna take a look at my collection?;Come on, take a look!;Remember, always adhere to Nanotrasen corporate policy!;Don't forget to use protection!"
	vend_reply = "Enjoy!;We're glad to satisfy your desires!"

	//STUFF SOLD HERE//
	products = list(//Sex toys
					/obj/item/restraints/handcuffs/lewd = 8,
					/obj/item/clothing/head/domina_cap = 5,
					/obj/item/clothing/head/maid = 5,
					/obj/item/clothing/head/kitty = 4,
					/obj/item/clothing/head/rabbitears = 4,
					/obj/item/clothing/mask/muzzle/ring = 4,
					/obj/item/clothing/mask/muzzle/ball = 4,
					/obj/item/clothing/ears/kinky_headphones = 4,
					/obj/item/clothing/glasses/blindfold/kinky = 4,
					/obj/item/clothing/neck/kink_collar = 3,
					/obj/item/clothing/neck/human_petcollar = 8,
					/obj/item/clothing/neck/human_petcollar/locked/cow = 8,
					/obj/item/clothing/neck/human_petcollar/locked/bell = 8,
					/obj/item/clothing/neck/human_petcollar/locked/spike = 8,
					/obj/item/clothing/neck/human_petcollar/locked/cross = 3,
					/obj/item/clothing/neck/human_petcollar/choker = 4,
					/obj/item/clothing/suit/corset = 2,
					/obj/item/clothing/under/misc/latex_catsuit = 1,
					/obj/item/clothing/under/rank/civilian/janitor/maid = 1,
					/obj/item/clothing/under/costume/lewdmaid = 1,
					/obj/item/clothing/under/costume/maid = 1,
					/obj/item/clothing/under/stripper_outfit = 2,
					/obj/item/clothing/under/misc/gear_harness = 1,
					/obj/item/clothing/under/shorts/polychromic/pantsu = 2,
					/obj/item/clothing/under/misc/poly_bottomless = 4,
					/obj/item/clothing/under/misc/poly_tanktop = 4,
					/obj/item/clothing/under/misc/poly_tanktop/female = 4,
					/obj/item/clothing/under/misc/stripper = 4,
					/obj/item/clothing/under/misc/stripper/green = 4,
					/obj/item/clothing/under/misc/stripper/mankini = 4,
					/obj/item/clothing/under/misc/stripper/bunnysuit = 4,
					/obj/item/clothing/under/misc/stripper/bunnysuit/white = 4,
					/obj/item/clothing/gloves/latex_gloves = 2,
					/obj/item/clothing/gloves/evening = 2,
					/obj/item/clothing/shoes/latex_socks = 2,
					/obj/item/clothing/shoes/latexheels = 1,
					/obj/item/clothing/shoes/dominaheels = 1,
					/obj/item/clothing/shoes/jackboots/thigh = 1,
					/obj/item/clothing/shoes/jackboots/knee = 1,
					//special
					/obj/item/clothing/glasses/nice_goggles = 1 //easter egg, don't touch plz)
					)
	contraband = list(
					/obj/item/electropack/shockcollar = 1
					)
	premium = list(
					/obj/item/clothing/under/dress/corset = 4,
					/obj/item/clothing/under/pants/chaps = 4,
					/obj/item/clothing/neck/human_petcollar/locked/holo = 3
					)

	refill_canister = /obj/item/vending_refill/lustwish
	payment_department = ACCOUNT_SRV
	default_price = 30
	extra_price = 250

//Secret vending machine skin. Don't touch plz
/obj/machinery/vending/dorms/proc/populate_vend_designs()
    vend_designs = list(
        "pink" = image (icon = src.icon, icon_state = "lustwish_pink"),
        "teal" = image(icon = src.icon, icon_state = "lustwish_teal"))

//Changing special secret var
/obj/machinery/vending/dorms/attackby(obj/item/used_item, mob/living/user, params)
	if(istype(used_item, /obj/item/lustwish_discount))
		user.visible_message(span_boldnotice("Something changes in [src] with a loud clunk."))
		card_used = !card_used
		switch(card_used)
			if(TRUE)
				default_price = 0
				extra_price = 0
			if(FALSE)
				default_price = 30
				extra_price = 250
	else
		return ..()

//using multitool on pole
/obj/machinery/vending/dorms/multitool_act(mob/living/user, obj/item/used_item)
	. = ..()
	if(.)
		return
	if(card_used == TRUE)
		var/choice = show_radial_menu(user, src, vend_designs, custom_check = CALLBACK(src, .proc/check_menu, user, used_item), radius = 50, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
	else
		return

/obj/machinery/vending/dorms/proc/check_menu(mob/living/user, obj/item/multitool)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	if(!multitool || !user.is_holding(multitool))
		return FALSE
	return TRUE

/obj/machinery/vending/dorms/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(vend_designs))
		populate_vend_designs()

/obj/machinery/vending/dorms/update_icon_state()
	..()
	if(machine_stat & BROKEN)
		icon_state = "[initial(icon_state)]_[current_color]-broken"
	else
		icon_state = "[initial(icon_state)]_[current_color][powered() ? null : "-off"]"


//Refill item
/obj/item/vending_refill/lustwish
	machine_name = "LustWish"
	icon_state = "lustwish_refill"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
