/obj/structure/flora/ocean
	icon = 'icons/horizon/obj/flora/ocean_flora.dmi'
	var/random_variants = 0

/obj/structure/flora/ocean/Initialize()
	. = ..()
	if(random_variants)
		icon_state = "[icon_state][rand(1,random_variants)]"

/obj/structure/flora/ocean/glowweed
	name = "glow weed"
	icon_state = "glowweed"
	desc = "A plant with glowing bulbs at the end of it."
	random_variants = 3
	light_color = LIGHT_COLOR_CYAN
	light_range = 1.5

/obj/structure/flora/ocean/seaweed
	name = "sea weed"
	icon_state = "seaweed"
	desc = "Just your regular seaweed."
	random_variants = 5

/obj/structure/flora/ocean/longseaweed
	name ="sea weed"
	icon_state = "longseaweed"
	desc = "Less so regular seaweed. This one is very long."
	random_variants = 4

/obj/structure/flora/ocean/coral
	name = "coral"
	icon_state = "coral"
	desc = "Beautiful coral."
	random_variants = 3
	density = TRUE
