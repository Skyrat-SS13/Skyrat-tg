

/obj/structure/closet/crate/secure/loot/proc/spawn_loot()
	spawned_loot = TRUE
	if(prob(80)) //hahahah funny meme fucking kill me
		visible_message("Huh..? There's nothing there!")
		return

	var/possible_loot = list( //lord forgive me
		list(
			/obj/item/melee/skateboard/pro
		),
		list(
			/obj/item/stack/ore/diamond/ten
		),
		list(
			/obj/item/poster/random_contraband,
			/obj/item/poster/random_contraband,
			/obj/item/poster/random_contraband,
			/obj/item/poster/random_contraband,
			/obj/item/poster/random_contraband
		),
		list(
			/obj/item/seeds/firelemon,
			/obj/item/seeds/cherry/bomb,
			/obj/item/seeds/gatfruit
		),
		list(
			/obj/item/melee/baton,
			/obj/item/melee/baton,
			/obj/item/melee/baton
		),
		list(
			/obj/item/borg/upgrade/modkit/aoe/mobs,
			/obj/item/clothing/suit/space,
			/obj/item/clothing/head/helmet/space
		),
		list(
			/obj/item/stack/ore/bluespace_crystal/five
		),
		list(
			/obj/item/defibrillator/compact
		),
		list(
			/obj/item/gun/energy/laser/retro
		),
		list(
			/obj/item/melee/skateboard/hoverboard
		),
		list(
			/obj/item/malf_upgrade
		),
		list(
			/obj/item/dnainjector/xraymut,
			/obj/item/dnainjector/cryokinesis,
			/obj/item/dnainjector/telemut
		),
		list(
			/obj/item/melee/transforming/energy/sword
		),
		list(
			/obj/item/reagent_containers/glass/bottle/tuberculosis
		),
		list(
			/obj/item/gun/ballistic/shotgun/bulldog/unrestricted,
			/obj/item/ammo_box/magazine/m12g
		),
		list(
			/obj/item/reagent_containers/hypospray/medipen/stimpack,
			/obj/item/reagent_containers/hypospray/medipen/stimpack,
			/obj/item/reagent_containers/hypospray/medipen/stimpack
		)
	)
	for(var/loot in pick(possible_loot))
		new loot(src)
