/datum/supply_pack/security/m16ammo
	name = "M16 Ammo Crate"
	desc = "3 magazina para sua linda e preciosa m16."
	cost = CARGO_CRATE_VALUE * 8
	access_view = ACCESS_CAPTAIN
	contains = list(/obj/item/ammo_box/magazine/m16,
					/obj/item/ammo_box/magazine/m16,
					/obj/item/ammo_box/magazine/m16)
	crate_name = "m16 ammo crate"

/datum/supply_pack/security/m16
	name = "M16 crate"
	desc = "Sua arma preferida e pronta para fuzilar qualquer um em sua frente."
	cost = CARGO_CRATE_VALUE * 25
	access_view = ACCESS_CAPTAIN
	contains = list(/obj/item/gun/ballistic/automatic/assault_rifle/m16)
	crate_name = "m16 gun crate"

/datum/supply_pack/security/rubygun
	name = "Ruby gunpack crate"
	desc = "Uma pistola boa... sem trava de segurança, contém 3 delas."
	cost = CARGO_CRATE_VALUE * 15
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/gun/ballistic/automatic/pistol/cfa_ruby/empty,
					/obj/item/gun/ballistic/automatic/pistol/cfa_ruby/empty,
					/obj/item/gun/ballistic/automatic/pistol/cfa_ruby/empty)
	crate_name = "Ruby Gun crate"

/datum/supply_pack/security/rubyammo
	name = "Ruby ammo pack crate"
	desc = "Uma caixa de munição de borracha para a pistola ruby."
	cost = CARGO_CRATE_VALUE * 9
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/rubber,
					/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/rubber,
					/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/rubber,
					/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/rubber,
					/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/rubber,
					/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/rubber,
					/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/rubber,
					/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/rubber,
					/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/rubber)
	crate_name = "Ruby Ammo crate"
