/obj/effect/spawner/random/medical
	name = "medical loot spawner"
	desc = "Doc, gimmie something good."

/obj/effect/spawner/random/medical/minor_healing
	name = "minor healing spawner"
	icon_state = "gauze"
	loot = list(
		/obj/item/stack/medical/suture,
		/obj/item/stack/medical/mesh,
		/obj/item/stack/medical/gauze,
	)

/obj/effect/spawner/random/medical/injector
	name = "injector spawner"
	icon_state = "syringe"
	loot = list(
		/obj/item/implanter,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/syringe,
	)

/obj/effect/spawner/random/medical/organs
	name = "ayylien organ spawner"
	icon_state = "eyes"
	spawn_loot_count = 3
	loot = list(
		/obj/item/organ/internal/heart/gland/egg = 7,
		/obj/item/organ/internal/heart/gland/plasma = 7,
		/obj/item/organ/internal/heart/gland/chem = 5,
		/obj/item/organ/internal/heart/gland/mindshock = 5,
		/obj/item/organ/internal/heart/gland/transform = 5,
		/obj/item/organ/internal/heart/gland/spiderman = 5,
		/obj/item/organ/internal/heart/gland/slime = 4,
		/obj/item/organ/internal/heart/gland/trauma = 4,
		/obj/item/organ/internal/heart/gland/electric = 3,
		/obj/item/organ/internal/monster_core/regenerative_core = 2,
		/obj/item/organ/internal/monster_core/rush_gland = 2,
		/obj/item/organ/internal/monster_core/brimdust_sac = 2,
		/obj/item/organ/internal/heart/gland/ventcrawling = 1,
		/obj/item/organ/internal/body_egg/alien_embryo = 1,
	)

/obj/effect/spawner/random/medical/memeorgans
	name = "meme organ spawner"
	icon_state = "eyes"
	spawn_loot_count = 5
	loot = list(
		/obj/item/organ/internal/ears/penguin,
		/obj/item/organ/internal/ears/cat,
		/obj/item/organ/internal/eyes/moth,
		/obj/item/organ/internal/eyes/snail,
		/obj/item/organ/internal/tongue/bone,
		/obj/item/organ/internal/tongue/fly,
		/obj/item/organ/internal/tongue/snail,
		/obj/item/organ/internal/tongue/lizard,
		/obj/item/organ/internal/tongue/alien,
		/obj/item/organ/internal/tongue/ethereal,
		/obj/item/organ/internal/tongue/robot,
		/obj/item/organ/internal/tongue/zombie,
		/obj/item/organ/internal/appendix,
		/obj/item/organ/internal/liver/fly,
		/obj/item/organ/internal/lungs/plasmaman,
		/obj/item/organ/external/tail/cat,
		/obj/item/organ/external/tail/lizard,
	)

/obj/effect/spawner/random/medical/two_percent_xeno_egg_spawner
	name = "2% chance xeno egg spawner"
	icon_state = "xeno_egg"
	loot = list(
		/obj/effect/decal/remains/xeno = 49,
		/obj/item/clothing/mask/facehugger/toy = 1, // SKYRAT EDIT - They should be handled by dynamic - ORIGIGNAL: /obj/effect/spawner/xeno_egg_delivery = 1,
	)

/obj/effect/spawner/random/medical/surgery_tool
	name = "Surgery tool spawner"
	icon_state = "scapel"
	loot = list(
		/obj/item/scalpel,
		/obj/item/hemostat,
		/obj/item/retractor,
		/obj/item/circular_saw,
		/obj/item/surgicaldrill,
		/obj/item/cautery,
		/obj/item/bonesetter,
	)

/obj/effect/spawner/random/medical/surgery_tool_advanced
	name = "Advanced surgery tool spawner"
	icon_state = "scapel"
	loot = list( // Mail loot spawner. Drop pool of advanced medical tools typically from research. Not endgame content.
		/obj/item/scalpel/advanced,
		/obj/item/retractor/advanced,
		/obj/item/cautery/advanced,
	)

/obj/effect/spawner/random/medical/surgery_tool_alien
	name = "Rare surgery tool spawner"
	icon_state = "scapel"
	loot = list( // Mail loot spawner. Some sort of random and rare surgical tool. Alien tech found here.
		/obj/item/scalpel/alien,
		/obj/item/hemostat/alien,
		/obj/item/retractor/alien,
		/obj/item/circular_saw/alien,
		/obj/item/surgicaldrill/alien,
		/obj/item/cautery/alien,
	)

/obj/effect/spawner/random/medical/medkit_rare
	name = "rare medkit spawner"
	icon_state = "medkit"
	loot = list(
		/obj/item/storage/medkit/emergency,
		/obj/item/storage/medkit/surgery,
		/obj/item/storage/medkit/advanced,
	)

/obj/effect/spawner/random/medical/medkit
	name = "medkit spawner"
	icon_state = "medkit"
	loot = list(
		/obj/item/storage/medkit/regular = 10,
		/obj/item/storage/medkit/o2 = 10,
		/obj/item/storage/medkit/fire = 10,
		/obj/item/storage/medkit/brute = 10,
		/obj/item/storage/medkit/toxin = 10,
		/obj/effect/spawner/random/medical/medkit_rare = 1,
	)

/obj/effect/spawner/random/medical/patient_stretcher
	name = "patient stretcher spawner"
	icon_state = "rollerbed"
	loot = list(
		/obj/structure/bed/medical/emergency,
		/obj/vehicle/ridden/wheelchair,
	)

/obj/effect/spawner/random/medical/supplies
	name = "medical supplies spawner"
	icon_state = "box_small"
	loot = list(
		/obj/item/storage/box/hug,
		/obj/item/storage/box/pillbottles,
		/obj/item/storage/box/bodybags,
		/obj/item/storage/box/rxglasses,
		/obj/item/storage/box/beakers,
		/obj/item/storage/box/gloves,
		/obj/item/storage/box/masks,
		/obj/item/storage/box/syringes,
	)
