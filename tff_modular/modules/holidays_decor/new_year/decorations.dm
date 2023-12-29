/obj/item/decoration/new_year
	name = "decoration"
	desc = "Winter is coming!"
	icon = 'tff_modular/modules/holidays_decor/new_year/decorations.dmi'
	icon_state = "santa"
	layer = 4.1

/obj/item/decoration/new_year/attack_hand(mob/user)
	if (isclosedturf(loc) || istype(loc, /obj/structure/window))
		var/choice = tgui_input_list(user, "Do you want to take \the [src]?", "Taking a decoration" , list("Yes", "Cancel"))
		if(choice != "Yes" || get_dist(src, user) > 1)
			return
	set_light(0)
	..()

/obj/item/decoration/new_year/afterattack(atom/target, mob/user, proximity, params)
	if(!proximity)
		return
	if(iswallturf(target))
		forceMove(target)

// Garland
/obj/item/decoration/new_year/garland
	name = "garland"
	desc = "Beautiful lights! Shinee!"
	icon_state = "garland_on"
	var/icon_state_off = "garland"
	var/light_colors = list(
		"Red" = "#ff0000",
		"Purple" = "#6111ff",
		"Orange" = "#ffa500",
		"Blue" = "#44faff",
		)
	light_color = "#ffa500"
	var/on = TRUE
	var/brightness = 4

/obj/item/decoration/new_year/garland/afterattack(atom/target, mob/user, proximity, params)
	..()
	update_garland()

/obj/item/decoration/new_year/garland/AltClick(mob/living/user)
	if(get_dist(src, user) <= 1)
		change_color(user)

/obj/item/decoration/new_year/garland/attack_self(mob/user)
	. = ..()
	if(do_after(user, 0.5 SECONDS, target = src))
		toggle()

/obj/item/decoration/new_year/garland/proc/update_garland()
	if(on)
		icon_state = "[icon_state_off]_on"
		set_light(brightness)
	else
		icon_state = "[icon_state_off]"
		set_light(0)

/obj/item/decoration/new_year/garland/proc/change_color(mob/living/user)
	var/color = tgui_input_list(user, "What color should we choose?", "Select lighting color", light_colors)
	if(color)
		light_color = light_colors[color]
		update_garland()

/obj/item/decoration/new_year/garland/proc/toggle()
	var/mob/living/carbon/C = usr
	on = !on
	C.visible_message("<span class='notice'>[C] turns \the [src] [on ? "on" : "off"].</span>", "<span class='notice'>You turn \the [src] [on ? "on" : "off"].</span>")
	update_garland()

// Tinsels
/obj/item/decoration/new_year/tinsel
	name = "tinsel"
	desc = "Soft tinsel, pleasant to the touch. Ahhh..."
	icon_state = "tinsel_green"
	unique_reskin = list(
		"Green" = "tinsel_green",
		"Red" = "tinsel_red",
		"Yellow" = "tinsel_yellow",
		"White" = "tinsel_white",
	)

/obj/item/decoration/new_year/tinsel/green
	icon_state = "tinsel_green"
	unique_reskin = list()

/obj/item/decoration/new_year/tinsel/red
	icon_state = "tinsel_red"
	unique_reskin = list()

/obj/item/decoration/new_year/tinsel/yellow
	icon_state = "tinsel_yellow"
	unique_reskin = list()

/obj/item/decoration/new_year/tinsel/white
	icon_state = "tinsel_white"
	unique_reskin = list()

// Snowflakes
/obj/item/decoration/new_year/snowflake
	name = "snowflake"
	desc = "Snowflakes from very soft and pleasant to touch material."
	icon_state = "snowflakes_1"

/obj/item/decoration/new_year/snowflake/Initialize(mapload)
	. = ..()
	icon_state = "snowflakes_[rand(1, 4)]"

// Snowman head
/obj/item/decoration/new_year/snowman
	name = "snowman head"
	desc = "Snowman head, which looks right into your soul."
	icon_state = "snowman"
