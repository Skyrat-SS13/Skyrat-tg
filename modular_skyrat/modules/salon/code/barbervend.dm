/obj/machinery/vending/barbervend
	name = "Fab-O-Vend"
	desc = "It would seem it vends dyes, and other stuff to make you pretty."
	icon = 'modular_skyrat/modules/salon/icons/vendor.dmi'
	icon_state = "barbervend"
	product_slogans = "Spread the colour, like butter, onto toast... Onto their hair.; Sometimes, I dream about dyes...; Paint 'em up and call me Mr. Painter.; Look brother, I'm a vendomat, I solve practical problems."
	product_ads = "Cut 'em all!; To sheds!; Hair be gone!; Prettify!; Beautify!"
	req_access = list(ACCESS_BARBER)
	refill_canister = /obj/item/vending_refill/barbervend
	products = list(
		/obj/item/reagent_containers/spray/quantum_hair_dye = 3,
		/obj/item/reagent_containers/spray/baldium = 3,
		/obj/item/reagent_containers/spray/barbers_aid = 3,
		/obj/item/hair_dye = 3,
		/obj/item/dyespray = 5,
		/obj/item/hairbrush = 3,
		/obj/item/hairbrush/comb = 3,
		/obj/item/fur_dyer = 1,
	)
	premium = list(
		/obj/item/scissors = 3,
		/obj/item/reagent_containers/spray/super_barbers_aid = 3,
		/obj/item/storage/box/lipsticks = 3,
		/obj/item/reagent_containers/dropper/precision = 1,
		/obj/item/lipstick/quantum = 1,
		/obj/item/razor = 1,
		/obj/item/storage/box/perfume = 1,
	)

/obj/item/vending_refill/barbervend
	name = "barber vend resupply"

