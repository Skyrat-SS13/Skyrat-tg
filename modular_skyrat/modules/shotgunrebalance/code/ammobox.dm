/obj/item/storage/box/shotgun
	icon = 'modular_skyrat/modules/shotgunrebalance/icons/shotbox.dmi'
	var/max_ammo = 7
	var/ammo_type = null

/obj/item/storage/box/shotgun/PopulateContents()
	for(var/i in 1 to max_ammo)
		new ammo_type(src)

// SLUGS
/obj/item/storage/box/shotgun/slugs
	name = "box of shotgun slugs"
	desc = "A box of 12 gauge lead slugs with no special effects."
	icon_state = "slug"
	ammo_type = /obj/item/ammo_casing/shotgun

// BUCKSHOT
/obj/item/storage/box/shotgun/buckshot
	name = "box of buckshot"
	desc = "A box of 12 gauge buckshot shells with no special effects."
	icon_state = "buckshot"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot

// RUBBERSHOT
/obj/item/storage/box/shotgun/rubbershot
	name = "box of rubbershot"
	desc = "A box of shotgun casings filled with densely-packed rubber balls, used to incapacitate crowds from a distance."
	icon_state = "rubber"
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot

// BEANBAGS
/obj/item/storage/box/shotgun/beanbag
	name = "box of beanbag slugs"
	desc = "A box of weak beanbag slugs for riot control."
	icon_state = "bean"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

// MAGNUM BUCKSHOT
/obj/item/storage/box/shotgun/magnum
	name = "box of magnum buckshot"
	desc = "A box of 12 gauge buckshot shells that fire bigger pellets with more spread. They are able to contend against armored targets."
	icon_state = "magnum"
	ammo_type = /obj/item/ammo_casing/shotgun/magnum

// EXPRESS BUCKSHOT
/obj/item/storage/box/shotgun/express
	name = "box of express buckshot"
	desc = "A box of 12 gauge buckshot shells that have smaller projectiles but tighter spread."
	icon_state = "express"
	ammo_type = /obj/item/ammo_casing/shotgun/express

// HOLLOW POINT SLUGS
/obj/item/storage/box/shotgun/hollow_point
	name = "box of hollow point slugs"
	desc = "A box of 12 gauge hollow point slugs purpose-built for unarmored targets."
	icon_state = "hollowpoint"
	ammo_type = /obj/item/ammo_casing/shotgun/hp

// ARMOR PIERCING SLUGS
/obj/item/storage/box/shotgun/ap_slug
	name = "box of PT-20 armor piercing slugs"
	desc = "A box of 12 gauge plastitanium slugs purpose-built to penetrate armored targets."
	icon_state = "apshell"
	ammo_type = /obj/item/ammo_casing/shotgun/pt20

// RIP SLUGS
/obj/item/storage/box/shotgun/rip
	name = "box of RIP slugs"
	desc = "A box of Radically Invasive Projectile slugs designed to cause massive damage against unarmored targets by embedding inside them."
	icon_state = "rip"
	ammo_type = /obj/item/ammo_casing/shotgun/rip

// FLECHETTES
/obj/item/storage/box/shotgun/flechette
	name = "box of flechettes"
	desc = "A box of 12 gauge flechette shells that specialize in ripping through armor."
	icon_state = "flechette"
	ammo_type = /obj/item/ammo_casing/shotgun/flechette

// BEEHIVE
/obj/item/storage/box/shotgun/beehive
	name = "box of B3-HVE 'Beehive' shells"
	desc = "A box of highly experimental non-lethal shells filled with smart nanite pellets that re-aim themselves when bouncing off from surfaces."
	icon_state = "beehive"
	ammo_type = /obj/item/ammo_casing/shotgun/beehive

// ANTI-TIDE
/obj/item/storage/box/shotgun/antitide
	name = "box of 4NT1-TD3 'Suppressor' shells"
	desc = "A box of highly experimental shells filled with nanite electrodes that will embed themselves in soft targets. \
			The electrodes are charged from kinetic movement which means moving targets will get punished more."
	icon_state = "antitide"
	ammo_type = /obj/item/ammo_casing/shotgun/antitide

// ICEBLOX
/obj/item/storage/box/shotgun/iceblox
	name = "box of iceblox shells"
	desc = "A box of highly experimental shells filled with nanites that will lower the body temperature of hit targets."
	icon_state = "iceblox"
	ammo_type = /obj/item/ammo_casing/shotgun/iceblox

// INCENDIARY
/obj/item/storage/box/shotgun/incendiary
	name = "box of incendiary slugs"
	desc = "A box of incendiary-coated shotgun slugs."
	icon_state = "incendiary"
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary

// CONFETTI
/obj/item/storage/box/shotgun/confetti
	name = "box of confetti shells"
	desc = "A box of 12 gauge buckshot shells that have been filled to the brim with confetti."
	icon_state = "confetti"
	ammo_type = /obj/item/ammo_casing/shotgun/confetti
