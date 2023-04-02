/obj/structure/flora/ash/df_wild_harvestables
	name = "generic plant"
	desc = "What the hell???"
	icon = 'modular_skyrat/modules/dwarf_fortress_other_stuff/icons/plants.dmi'
	icon_state = null
	base_icon_state = null
	product_types = list(/obj/item/food/grown/ash_flora/fireblossom = 1)
	harvested_name = "generic plant stems"
	harvested_desc = "Oh my good no waaaaaayyayayayy."
	harvest_amount_high = 3
	harvest_message_low = "You pluck a single bunch."
	harvest_message_med = "You pluck a number of bunches."
	harvest_message_high = "You pluck quite the number of bunches."
	regrowth_time_low = 3 MINUTES
	regrowth_time_high = 10 MINUTES
	number_of_variants = 2

/obj/structure/flora/ash/df_wild_harvestables/reeds
	name "river reeds"
	desc = "Tall reeds that typically grow near sources of water. The fibers of the plant's stalks make it idea for plant fiber creation."
	icon_state = "reeds1"
	base_icon_state = "reeds"
	product_types = list(/obj/item/grown/reeds = 1)
	harvested_name = "cut river reeds"
	harvested_desc = "Not-so-tall-anymore reeds that typically grow near sources of water."

/obj/structure/flora/ash/df_wild_harvestables/flax
	name "flax flowers"
	desc = "Purple flowers known for two things. Seeds for making oil from, and stalks for making fibers from."
	icon_state = "flax1"
	base_icon_state = "flax"
	product_types = list(/obj/item/grown/flax = 1)
	harvested_name = "flax stems"
	harvested_desc = "Notably lacking in everything except for the roots and stems right now, it'd seem."

/obj/structure/flora/ash/df_wild_harvestables/cotton
	name "wild cotton"
	desc = "Small bushes with balls of cotton growing on it. It should go without saying that you can make thread with said cotton."
	icon_state = "cotton1"
	base_icon_state = "cotton"
	product_types = list(/obj/item/grown/cotton = 1)
	harvested_name = "wild cotton stems"
	harvested_desc = "This bush seems to be picked dry, at the moment."
	number_of_variants = 1
