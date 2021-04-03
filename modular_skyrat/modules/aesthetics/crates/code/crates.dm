/obj/structure/closet/crate
	icon = 'modular_skyrat/modules/aesthetics/crates/icons/crates.dmi'

//Adds the unused large crate sprites into the game --- they're really just re-textured crates, but still cool. Maybe someone can add additional function later.
//Making it a subtype of crate/large isn't worth it considering how much code it changes involving opening and durability. Instead they're now crate/big, because its simply easier this way.
/obj/structure/closet/crate/big
	name = "large crate"
	desc = "A sturdy metal crate. It'd be the perfect way to secure your valuables, if you could lock it..."
	icon_state = "largemetal"
	material_drop = /obj/item/stack/sheet/iron
	material_drop_amount = 8
	open_sound_volume = 35
	close_sound_volume = 50
	divable = TRUE
	damage_deflection = 15
	max_integrity = 150

/obj/structure/closet/crate/big/reinforced
	name = "reinforced large crate"
	desc = "An even sturdier metal crate. It's a shame that the metal wasn't used to give it the lock it was missing!"
	icon_state = "largermetal"
	material_drop = /obj/item/stack/sheet/plasteel
	material_drop_amount = 4
	damage_deflection = 25
	max_integrity = 400
