
// TODO: Work into reworked uplinks.
/proc/create_uplink_sales(num, datum/uplink_category/category, limited_stock, list/sale_items)
	var/list/sales = list()
	var/list/sale_items_copy = sale_items.Copy()
	for (var/i in 1 to num)
		var/datum/uplink_item/taken_item = pick_n_take(sale_items_copy)
		var/datum/uplink_item/uplink_item = new taken_item.type()
		var/discount = uplink_item.get_discount()
		var/list/disclaimer = list("Void where prohibited.", "Not recommended for children.", "Contains small parts.", "Check local laws for legality in region.", "Do not taunt.", "Not responsible for direct, indirect, incidental or consequential damages resulting from any defect, error or failure to perform.", "Keep away from fire or flames.", "Product is provided \"as is\" without any implied or expressed warranties.", "As seen on TV.", "For recreational use only.", "Use only as directed.", "16% sales tax will be charged for orders originating within Space Nebraska.")
		uplink_item.limited_stock = limited_stock
		if(uplink_item.cost >= 20) //Tough love for nuke ops
			discount *= 0.5
		uplink_item.category = category
		uplink_item.cost = max(round(uplink_item.cost * discount),1)
		uplink_item.name += " ([round(((initial(uplink_item.cost)-uplink_item.cost)/initial(uplink_item.cost))*100)]% off!)"
		uplink_item.desc += " Normally costs [initial(uplink_item.cost)] TC. All sales final. [pick(disclaimer)]"
		uplink_item.item = taken_item.item

		sales += uplink_item
	return sales

/**
 * Uplink Items
 *
 * Items that can be spawned from an uplink. Can be limited by gamemode.
**/
/datum/uplink_item
	/// Name of the uplink item
	var/name = "item name"
	/// Category of the uplink
	var/datum/uplink_category/category
	/// Description of the uplink
	var/desc = "item description"
	/// Path to the item to spawn.
	var/item = null
	/// Alternative path for refunds, in case the item purchased isn't what is actually refunded (ie: holoparasites).
	var/refund_path = null
	/// Cost of the item.
	var/cost = 0
	/// Amount of TC to refund, in case there's a TC penalty for refunds.
	var/refund_amount = 0
	/// Whether this item is refundable or not.
	var/refundable = FALSE
	// Chance of being included in the surplus crate.
	var/surplus = 100
	/// Whether this can be discounted or not
	var/cant_discount = FALSE
	/// How many items of this stock can be purchased.
	var/limited_stock = -1 //Setting this above zero limits how many times this item can be bought by the same traitor in a round, -1 is unlimited
	/// A bitfield to represent what uplinks can purchase this item.
	/// See [`code/__DEFINES/uplink.dm`].
	var/purchasable_from = ALL
	/// If this uplink item is only available to certain roles. Roles are dependent on the frequency chip or stored ID.
	var/list/restricted_roles = list()
	/// The minimum amount of progression needed for this item to be added to uplinks.
	var/progression_minimum = 0
	/// Whether this purchase is visible in the purchase log.
	var/purchase_log_vis = TRUE // Visible in the purchase log?
	/// Whether this purchase is restricted or not (VR/Events related)
	var/restricted = FALSE
	/// Can this item be deconstructed to unlock certain techweb research nodes?
	var/illegal_tech = TRUE

/datum/uplink_category
	/// Name of the category
	var/name
	/// Weight of the category. Used to determine the positioning in the uplink. High weight = appears first
	var/weight = 0

/datum/uplink_item/proc/get_discount()
	return pick(4;0.75,2;0.5,1;0.25)

/datum/uplink_item/proc/purchase(mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	var/atom/A = spawn_item(item, user, uplink_handler, source)
	log_uplink("[key_name(user)] purchased [src] for [cost] telecrystals from [source]'s uplink")
	if(purchase_log_vis && uplink_handler.purchase_log)
		uplink_handler.purchase_log.LogPurchase(A, src, cost)

/datum/uplink_item/proc/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	if(!spawn_path)
		return
	var/atom/A
	if(ispath(spawn_path))
		A = new spawn_path(get_turf(user))
	else
		A = spawn_path
	if(ishuman(user) && istype(A, /obj/item))
		var/mob/living/carbon/human/H = user
		if(H.put_in_hands(A))
			to_chat(H, span_boldnotice("[A] materializes into your hands!"))
			return A
	to_chat(user, span_boldnotice("[A] materializes onto the floor!"))
	return A

/datum/uplink_category/discounts
	name = "Discounted Gear"
	weight = -1

/datum/uplink_category/discount_team_gear
	name = "Discounted Team Gear"
	weight = -1

/datum/uplink_category/limited_discount_team_gear
	name = "Limited Stock Team Gear"
	weight = -2

/datum/uplink_item/support/clown_reinforcement
	name = "Clown Reinforcements"
	desc = "Call in an additional clown to share the fun, equipped with full starting gear, but no telecrystals."
	item = /obj/item/antag_spawner/nuke_ops/clown
	cost = 20
	purchasable_from = UPLINK_CLOWN_OPS
	restricted = TRUE

/datum/uplink_item/support/reinforcement
	name = "Reinforcements"
	desc = "Call in an additional team member. They won't come with any gear, so you'll have to save some telecrystals \
			to arm them as well."
	item = /obj/item/antag_spawner/nuke_ops
	cost = 25
	refundable = TRUE
	purchasable_from = UPLINK_NUKE_OPS
	restricted = TRUE

/datum/uplink_item/support/reinforcement/assault_borg
	name = "Syndicate Assault Cyborg"
	desc = "A cyborg designed and programmed for systematic extermination of non-Syndicate personnel. \
			Comes equipped with a self-resupplying LMG, a grenade launcher, energy sword, emag, pinpointer, flash and crowbar."
	item = /obj/item/antag_spawner/nuke_ops/borg_tele/assault
	refundable = TRUE
	cost = 65
	restricted = TRUE

/datum/uplink_item/support/reinforcement/medical_borg
	name = "Syndicate Medical Cyborg"
	desc = "A combat medical cyborg. Has limited offensive potential, but makes more than up for it with its support capabilities. \
			It comes equipped with a nanite hypospray, a medical beamgun, combat defibrillator, full surgical kit including an energy saw, an emag, pinpointer and flash. \
			Thanks to its organ storage bag, it can perform surgery as well as any humanoid."
	item = /obj/item/antag_spawner/nuke_ops/borg_tele/medical
	refundable = TRUE
	cost = 35
	restricted = TRUE

/datum/uplink_item/support/reinforcement/saboteur_borg
	name = "Syndicate Saboteur Cyborg"
	desc = "A streamlined engineering cyborg, equipped with covert modules. Also incapable of leaving the welder in the shuttle. \
			Aside from regular Engineering equipment, it comes with a special destination tagger that lets it traverse disposals networks. \
			Its chameleon projector lets it disguise itself as a Nanotrasen cyborg, on top it has thermal vision and a pinpointer."
	item = /obj/item/antag_spawner/nuke_ops/borg_tele/saboteur
	refundable = TRUE
	cost = 35
	restricted = TRUE

/datum/uplink_item/support/gygax
	name = "Dark Gygax Exosuit"
	desc = "A lightweight exosuit, painted in a dark scheme. Its speed and equipment selection make it excellent \
			for hit-and-run style attacks. Features a scattershot shotgun, armor boosters against melee and ranged attacks, ion thrusters and a Tesla energy array."
	item = /obj/vehicle/sealed/mecha/combat/gygax/dark/loaded
	cost = 80

/datum/uplink_item/support/honker
	name = "Dark H.O.N.K."
	desc = "A clown combat mech equipped with bombanana peel and tearstache grenade launchers, as well as the ubiquitous HoNkER BlAsT 5000."
	item = /obj/vehicle/sealed/mecha/combat/honker/dark/loaded
	cost = 80
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/support/mauler
	name = "Mauler Exosuit"
	desc = "A massive and incredibly deadly military-grade exosuit. Features long-range targeting, thrust vectoring \
			and deployable smoke. Comes equipped with an LMG, scattershot carbine, missile rack, an antiprojectile armor booster and a Tesla energy array."
	item = /obj/vehicle/sealed/mecha/combat/marauder/mauler/loaded
	cost = 140

// Stealth Items
/datum/uplink_item/stealthy_tools
	category = "Stealth Gadgets"

/datum/uplink_item/stealthy_tools/agent_card
	name = "Agent Identification Card"
	desc = "Agent cards prevent artificial intelligences from tracking the wearer, and hold up to 5 wildcards \
			from other identification cards. In addition, they can be forged to display a new assignment, name and trim. \
			This can be done an unlimited amount of times. Some Syndicate areas and devices can only be accessed \
			with these cards."
	item = /obj/item/card/id/advanced/chameleon
	cost = 2

/datum/uplink_item/stealthy_tools/ai_detector
	name = "Artificial Intelligence Detector"
	desc = "A functional multitool that turns red when it detects an artificial intelligence watching it, and can be \
			activated to display their exact viewing location and nearby security camera blind spots. Knowing when \
			an artificial intelligence is watching you is useful for knowing when to maintain cover, and finding nearby \
			blind spots can help you identify escape routes."
	item = /obj/item/multitool/ai_detect
	cost = 1

/datum/uplink_item/stealthy_tools/chameleon
	name = "Chameleon Kit"
	desc = "A set of items that contain chameleon technology allowing you to disguise as pretty much anything on the station, and more! \
			Due to budget cuts, the shoes don't provide protection against slipping and skillchips are sold separately. Now comes with \
			a nanite mirror to change your hair on the fly as well as a bottle of dye. " //SKYRAT EDIT
	item = /obj/item/storage/box/syndie_kit/chameleon
	cost = 2
	purchasable_from = ~UPLINK_NUKE_OPS //clown ops are allowed to buy this kit, since it's basically a costume

/datum/uplink_item/stealthy_tools/chameleon_proj
	name = "Chameleon Projector"
	desc = "Projects an image across a user, disguising them as an object scanned with it, as long as they don't \
			move the projector from their hand. Disguised users move slowly, and projectiles pass over them."
	item = /obj/item/chameleon
	cost = 7


/datum/uplink_item/stealthy_tools/codespeak_manual
	name = "Codespeak Manual"
	desc = "Syndicate agents can be trained to use a series of codewords to convey complex information, which sounds like random concepts and drinks to anyone listening. \
			This manual teaches you this Codespeak. You can also hit someone else with the manual in order to teach them. This is the deluxe edition, which has unlimited uses."
	item = /obj/item/language_manual/codespeak_manual/unlimited
	cost = 3

/datum/uplink_item/stealthy_tools/combatbananashoes
	name = "Combat Banana Shoes"
	desc = "While making the wearer immune to most slipping attacks like regular combat clown shoes, these shoes \
		can generate a large number of synthetic banana peels as the wearer walks, slipping up would-be pursuers. They also \
		squeak significantly louder."
	item = /obj/item/clothing/shoes/clown_shoes/banana_shoes/combat
	cost = 6
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/stealthy_tools/emplight
	name = "EMP Flashlight"
	desc = "A small, self-recharging, short-ranged EMP device disguised as a working flashlight. \
			Useful for disrupting headsets, cameras, doors, lockers and borgs during stealth operations. \
			Attacking a target with this flashlight will direct an EM pulse at it and consumes a charge."
	item = /obj/item/flashlight/emp
	cost = 4
	surplus = 30

/datum/uplink_item/stealthy_tools/mulligan
	name = "Mulligan"
	desc = "Screwed up and have security on your tail? This handy syringe will give you a completely new identity \
			and appearance."
	item = /obj/item/reagent_containers/syringe/mulligan
	cost = 4
	surplus = 30
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/stealthy_tools/syndigaloshes
	name = "No-Slip Chameleon Shoes"
	desc = "These shoes will allow the wearer to run on wet floors and slippery objects without falling down. \
			They do not work on heavily lubricated surfaces."
	item = /obj/item/clothing/shoes/chameleon/noslip
	cost = 2
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
	player_minimum = 20

/datum/uplink_item/stealthy_tools/syndigaloshes/nuke
	item = /obj/item/clothing/shoes/chameleon/noslip
	cost = 4
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/stealthy_tools/jammer
	name = "Radio Jammer"
	desc = "This device will disrupt any nearby outgoing radio communication when activated. Does not affect binary chat."
	item = /obj/item/jammer
	cost = 5

/datum/uplink_item/stealthy_tools/smugglersatchel
	name = "Smuggler's Satchel"
	desc = "This satchel is thin enough to be hidden in the gap between plating and tiling; great for stashing \
			your stolen goods. Comes with a crowbar, a floor tile and some contraband inside."
	item = /obj/item/storage/backpack/satchel/flat/with_tools
	cost = 1
	surplus = 30
	illegal_tech = FALSE

//Space Suits and MODsuits
/datum/uplink_item/suits
	category = "Space Suits"
	surplus = 40

/datum/uplink_item/suits/infiltrator_bundle
	name = "Infiltrator Case"
	desc = "Developed by Roseus Galactic in conjunction with the Gorlex Marauders to produce a functional suit for urban operations, \
			this suit proves to be cheaper than your standard issue MODsuit, with none of the movement restrictions of the outdated spacesuits employed by the company. \
			Comes with an armor vest, helmet, sneaksuit, sneakboots, specialized combat gloves and a high-tech balaclava. The case is also rather useful as a storage container."
	item = /obj/item/storage/toolbox/infiltrator
	cost = 6
	limited_stock = 1 //you only get one so you don't end up with too many gun cases
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/suits/space_suit
	name = "Syndicate Space Suit"
	desc = "This red and black Syndicate space suit is less encumbering than Nanotrasen variants, \
			fits inside bags, and has a weapon slot. Nanotrasen crew members are trained to report red space suit \
			sightings, however."
	item = /obj/item/storage/box/syndie_kit/space
	cost = 4

/datum/uplink_item/suits/modsuit
	name = "Syndicate MODsuit"
	desc = "The feared MODsuit of a Syndicate agent. Features armoring and a set of inbuilt modules."
	item = /obj/item/mod/control/pre_equipped/traitor
	cost = 8
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS) //you can't buy it in nuke, because the elite modsuit costs the same while being better

/datum/uplink_item/suits/modsuit/elite
	name = "Elite Syndicate MODsuit"
	desc = "An upgraded, elite version of the Syndicate MODsuit. It features fireproofing, and also \
			provides the user with superior armor and mobility compared to the standard Syndicate MODsuit."
	item = /obj/item/mod/control/pre_equipped/elite
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/suits/energy_shield
	name = "MODsuit Energy Shield Module"
	desc = "An energy shield module for a MODsuit. The shields can handle up to three impacts \
			within a short duration and will rapidly recharge while not under fire."
	item = /obj/item/mod/module/energy_shield
	cost = 15
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/suits/thermal
	name = "MODsuit Thermal Visor Module"
	desc = "A visor for a MODsuit. Lets you see living beings through walls."
	item = /obj/item/mod/module/visor/thermal
	cost = 3

/datum/uplink_item/suits/night
	name = "MODsuit Night Visor Module"
	desc = "A visor for a MODsuit. Lets you see clearer in the dark."
	item = /obj/item/mod/module/visor/night
	cost = 2

/datum/uplink_item/suits/noslip
	name = "MODsuit Anti-Slip Module"
	desc = "A MODsuit module preventing the user from slipping on water."
	item = /obj/item/mod/module/noslip
	cost = 4
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/suits/noslip/traitor
	cost = 2
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

// Devices and Tools
/datum/uplink_item/device_tools
	category = "Misc. Gadgets"

/datum/uplink_item/device_tools/cutouts
	name = "Adaptive Cardboard Cutouts"
	desc = "These cardboard cutouts are coated with a thin material that prevents discoloration and makes the images on them appear more lifelike. \
			This pack contains three as well as a crayon for changing their appearances."
	item = /obj/item/storage/box/syndie_kit/cutouts
	cost = 1
	surplus = 20

/datum/uplink_item/device_tools/assault_pod
	name = "Assault Pod Targeting Device"
	desc = "Use this to select the landing zone of your assault pod."
	item = /obj/item/assault_pod
	cost = 30
	surplus = 0
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS
	restricted = TRUE

/datum/uplink_item/device_tools/binary
	name = "Binary Translator Key"
	desc = "A key that, when inserted into a radio headset, allows you to listen to and talk with silicon-based lifeforms, \
			such as AI units and cyborgs, over their private binary channel. Caution should \
			be taken while doing this, as unless they are allied with you, they are programmed to report such intrusions."
	item = /obj/item/encryptionkey/binary
	cost = 5
	surplus = 75
	restricted = TRUE

/datum/uplink_item/device_tools/magboots
	name = "Blood-Red Magboots"
	desc = "A pair of magnetic boots with a Syndicate paintjob that assist with freer movement in space or on-station \
			during gravitational generator failures. These reverse-engineered knockoffs of Nanotrasen's \
			'Advanced Magboots' slow you down in simulated-gravity environments much like the standard issue variety."
	item = /obj/item/clothing/shoes/magboots/syndie
	cost = 2
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/device_tools/briefcase_launchpad
	name = "Briefcase Launchpad"
	desc = "A briefcase containing a launchpad, a device able to teleport items and people to and from targets up to eight tiles away from the briefcase. \
			Also includes a remote control, disguised as an ordinary folder. Touch the briefcase with the remote to link it."
	surplus = 0
	item = /obj/item/storage/briefcase/launchpad
	cost = 6

/datum/uplink_item/device_tools/camera_bug
	name = "Camera Bug"
	desc = "Enables you to view all cameras on the main network, set up motion alerts and track a target. \
			Bugging cameras allows you to disable them remotely."
	item = /obj/item/camera_bug
	cost = 1
	surplus = 90

/datum/uplink_item/device_tools/military_belt
	name = "Chest Rig"
	desc = "A robust seven-slot set of webbing that is capable of holding all manner of tactical equipment."
	item = /obj/item/storage/belt/military
	cost = 1

/datum/uplink_item/device_tools/emag
	name = "Cryptographic Sequencer"
	desc = "The cryptographic sequencer, electromagnetic card, or emag, is a small card that unlocks hidden functions \
			in electronic devices, subverts intended functions, and easily breaks security mechanisms. Cannot be used to open airlocks."
	item = /obj/item/card/emag
	cost = 4

/datum/uplink_item/device_tools/emag/New()
	. = ..()
	if(SSevents.holidays?[HALLOWEEN])
		item = /obj/item/card/emag/halloween
		desc += " This one is fitted to support the Halloween season. Candle not included."

/datum/uplink_item/device_tools/syndie_jaws_of_life
	name = "Syndicate Jaws of Life"
	desc = "Based on a Nanotrasen model, this powerful tool can be used as both a crowbar and a pair of wirecutters. \
	In its crowbar configuration, it can be used to force open airlocks. Very useful for entering the station or its departments."
	item = /obj/item/crowbar/power/syndicate
	cost = 4
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/device_tools/doorjack
	name = "Airlock Authentication Override Card"
	desc = "A specialized cryptographic sequencer specifically designed to override station airlock access codes. \
			After hacking a certain number of airlocks, the device will require some time to recharge."
	item = /obj/item/card/emag/doorjack
	cost = 3

/datum/uplink_item/device_tools/fakenucleardisk
	name = "Decoy Nuclear Authentication Disk"
	desc = "It's just a normal disk. Visually it's identical to the real deal, but it won't hold up under closer scrutiny by the Captain. \
			Don't try to give this to us to complete your objective, we know better!"
	item = /obj/item/disk/nuclear/fake
	cost = 1
	surplus = 1
	illegal_tech = FALSE

/datum/uplink_item/device_tools/frame
	name = "F.R.A.M.E. PDA Cartridge"
	desc = "When inserted into a personal digital assistant, this cartridge gives you five PDA viruses which \
			when used cause the targeted PDA to become a new uplink with zero TCs, and immediately become unlocked. \
			You will receive the unlock code upon activating the virus, and the new uplink may be charged with \
			telecrystals normally."
	item = /obj/item/cartridge/virus/frame
	cost = 4
	restricted = TRUE

/datum/uplink_item/device_tools/failsafe
	name = "Failsafe Uplink Code"
	desc = "When entered the uplink will self-destruct immediately."
	item = /obj/effect/gibspawner/generic
	cost = 1
	surplus = 0
	restricted = TRUE
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/device_tools/failsafe/spawn_item(spawn_path, mob/user, datum/component/uplink/U)
	if(!U)
		return
	U.failsafe_code = U.generate_code()
	var/code = "[islist(U.failsafe_code) ? english_list(U.failsafe_code) : U.failsafe_code]"
	to_chat(user, span_warning("The new failsafe code for this uplink is now : [code]. You may check your antagonist info to recall this."))
	return U.parent //For log icon

/datum/uplink_item/device_tools/toolbox
	name = "Full Syndicate Toolbox"
	desc = "The Syndicate toolbox is a suspicious black and red. It comes loaded with a full tool set including a \
			multitool and combat gloves that are resistant to shocks and heat."
	item = /obj/item/storage/toolbox/syndicate
	cost = 1
	illegal_tech = FALSE

/datum/uplink_item/device_tools/hacked_module
	name = "Hacked AI Law Upload Module"
	desc = "When used with an upload console, this module allows you to upload priority laws to an artificial intelligence. \
			Be careful with wording, as artificial intelligences may look for loopholes to exploit."
	item = /obj/item/ai_module/syndicate
	cost = 4

//SKYRAT EDIT BEGIN - Brainwash surgery no longer restricted
/datum/uplink_item/device_tools/brainwash_disk
	name = "Brainwashing Surgery Program"
	desc = "A disk containing the procedure to perform a brainwashing surgery, allowing you to implant an objective onto a target. \
	Insert into an Operating Console to enable the procedure."
	item = /obj/item/disk/surgery/brainwashing
	cost = 5
//SKYRAT EDIT END

/datum/uplink_item/device_tools/hypnotic_flash
	name = "Hypnotic Flash"
	desc = "A modified flash able to hypnotize targets. If the target is not in a mentally vulnerable state, it will only confuse and pacify them temporarily."
	item = /obj/item/assembly/flash/hypnotic
	cost = 7

/datum/uplink_item/device_tools/hypnotic_grenade
	name = "Hypnotic Grenade"
	desc = "A modified flashbang grenade able to hypnotize targets. The sound portion of the flashbang causes hallucinations, and will allow the flash to induce a hypnotic trance to viewers."
	item = /obj/item/grenade/hypnotic
	cost = 12

/datum/uplink_item/device_tools/medgun
	name = "Medbeam Gun"
	desc = "A wonder of Syndicate engineering, the Medbeam gun, or Medi-Gun enables a medic to keep his fellow \
			operatives in the fight, even while under fire. Don't cross the streams!"
	item = /obj/item/gun/medbeam
	cost = 15
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/device_tools/singularity_beacon
	name = "Power Beacon"
	desc = "When screwed to wiring attached to an electric grid and activated, this large device pulls any \
			active gravitational singularities or tesla balls towards it. This will not work when the engine is still \
			in containment. Because of its size, it cannot be carried. Ordering this \
			sends you a small beacon that will teleport the larger beacon to your location upon activation."
	item = /obj/item/sbeacondrop
	cost = 10

/datum/uplink_item/device_tools/powersink
	name = "Power Sink"
	desc = "When screwed to wiring attached to a power grid and activated, this large device lights up and places excessive \
			load on the grid, causing a station-wide blackout. The sink is large and cannot be stored in most \
			traditional bags and boxes. Caution: Will explode if the powernet contains sufficient amounts of energy."
	item = /obj/item/powersink
	cost = 18 //SKYRAT EDIT: Original value (10)
	player_minimum = 25

/datum/uplink_item/device_tools/rad_laser
	name = "Radioactive Microlaser"
	desc = "A radioactive microlaser disguised as a standard Nanotrasen health analyzer. When used, it emits a \
			powerful burst of radiation, which, after a short delay, can incapacitate all but the most protected \
			of humanoids. It has two settings: intensity, which controls the power of the radiation, \
			and wavelength, which controls the delay before the effect kicks in."
	item = /obj/item/healthanalyzer/rad_laser
	cost = 3

/datum/uplink_item/device_tools/stimpack
	name = "Stimpack"
	desc = "Stimpacks, the tool of many great heroes, make you nearly immune to stuns and knockdowns for about \
			5 minutes after injection."
	item = /obj/item/reagent_containers/hypospray/medipen/stimulants
	cost = 5
	surplus = 90

/datum/uplink_item/device_tools/medkit
	name = "Syndicate Combat Medic Kit"
	desc = "This first aid kit is a suspicious brown and red. Included is a combat stimulant injector \
			for rapid healing, a medical night vision HUD for quick identification of injured personnel, \
			and other supplies helpful for a field medic."
	item = /obj/item/storage/firstaid/tactical
	cost = 4
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/device_tools/soap
	name = "Syndicate Soap"
	desc = "A sinister-looking surfactant used to clean blood stains to hide murders and prevent DNA analysis. \
			You can also drop it underfoot to slip people."
	item = /obj/item/soap/syndie
	cost = 1
	surplus = 50
	illegal_tech = FALSE

/datum/uplink_item/device_tools/surgerybag
	name = "Syndicate Surgery Duffel Bag"
	desc = "The Syndicate surgery duffel bag is a toolkit containing all surgery tools, surgical drapes, \
			a Syndicate brand MMI, a straitjacket, and a muzzle."
	item = /obj/item/storage/backpack/duffelbag/syndie/surgery
	cost = 3

/datum/uplink_item/device_tools/encryptionkey
	name = "Syndicate Encryption Key"
	desc = "A key that, when inserted into a radio headset, allows you to listen to all station department channels \
			as well as talk on an encrypted Syndicate channel with other agents that have the same key."
	item = /obj/item/encryptionkey/syndicate
	cost = 2
	surplus = 75
	restricted = TRUE

/datum/uplink_item/device_tools/syndietome
	name = "Syndicate Tome"
	desc = "Using rare artifacts acquired at great cost, the Syndicate has reverse engineered \
			the seemingly magical books of a certain cult. Though lacking the esoteric abilities \
			of the originals, these inferior copies are still quite useful, being able to provide \
			both weal and woe on the battlefield, even if they do occasionally bite off a finger."
	item = /obj/item/storage/book/bible/syndicate
	cost = 5

/datum/uplink_item/device_tools/thermal
	name = "Thermal Imaging Glasses"
	desc = "These goggles can be turned to resemble common eyewear found throughout the station. \
			They allow you to see organisms through walls by capturing the upper portion of the infrared light spectrum, \
			emitted as heat and light by objects. Hotter objects, such as warm bodies, cybernetic organisms \
			and artificial intelligence cores emit more of this light than cooler objects like walls and airlocks."
	item = /obj/item/clothing/glasses/thermal/syndi
	cost = 4

/datum/uplink_item/device_tools/potion
	name = "Syndicate Sentience Potion"
	item = /obj/item/slimepotion/slime/sentience/nuclear
	desc = "A potion recovered at great risk by undercover Syndicate operatives and then subsequently modified with Syndicate technology. \
			Using it will make any animal sentient, and bound to serve you, as well as implanting an internal radio for communication and an internal ID card for opening doors."
	cost = 4
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS
	restricted = TRUE

//SKYRAT EDIT REMOVAL BEGIN
/*
/datum/uplink_item/device_tools/suspiciousphone
	name = "Protocol CRAB-17 Phone"
	desc = "The Protocol CRAB-17 Phone, a phone borrowed from an unknown third party, it can be used to crash the space market, funneling the losses of the crew to your bank account.\
	The crew can move their funds to a new banking site though, unless they HODL, in which case they deserve it."
	item = /obj/item/suspiciousphone
	restricted = TRUE
	cost = 7
	limited_stock = 1
*/
//SKYRAT EDIT REMOVAL END

/datum/uplink_item/device_tools/guerillagloves
	name = "Guerilla Gloves"
	desc = "A pair of highly robust combat gripper gloves that excels at performing takedowns at close range, with an added lining of insulation. Careful not to hit a wall!"
	item = /obj/item/clothing/gloves/tackler/combat/insulated
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS
	cost = 2
	illegal_tech = FALSE

// Implants
/datum/uplink_item/implants
	category = "Implants"
	surplus = 50

/datum/uplink_item/implants/antistun
	name = "CNS Rebooter Implant"
	desc = "This implant will help you get back up on your feet faster after being stunned. Comes with an autosurgeon."
	item = /obj/item/autosurgeon/organ/syndicate/anti_stun
	cost = 12
	surplus = 0
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/implants/freedom
	name = "Freedom Implant"
	desc = "An implant injected into the body and later activated at the user's will. It will attempt to free the \
			user from common restraints such as handcuffs."
	item = /obj/item/storage/box/syndie_kit/imp_freedom
	cost = 5

/datum/uplink_item/implants/microbomb
	name = "Microbomb Implant"
	desc = "An implant injected into the body, and later activated either manually or automatically upon death. \
			The more implants inside of you, the higher the explosive power. \
			This will permanently destroy your body, however."
	item = /obj/item/storage/box/syndie_kit/imp_microbomb
	cost = 2
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/implants/macrobomb
	name = "Macrobomb Implant"
	desc = "An implant injected into the body, and later activated either manually or automatically upon death. \
			Upon death, releases a massive explosion that will wipe out everything nearby."
	item = /obj/item/storage/box/syndie_kit/imp_macrobomb
	cost = 20
	purchasable_from = UPLINK_NUKE_OPS
	restricted = TRUE

/datum/uplink_item/implants/radio
	name = "Internal Syndicate Radio Implant"
	desc = "An implant injected into the body, allowing the use of an internal Syndicate radio. \
			Used just like a regular headset, but can be disabled to use external headsets normally and to avoid detection."
	item = /obj/item/storage/box/syndie_kit/imp_radio
	cost = 4
	restricted = TRUE

/datum/uplink_item/implants/reviver
	name = "Reviver Implant"
	desc = "This implant will attempt to revive and heal you if you lose consciousness. Comes with an autosurgeon."
	item = /obj/item/autosurgeon/organ/syndicate/reviver
	cost = 8
	surplus = 0
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/implants/stealthimplant
	name = "Stealth Implant"
	desc = "This one-of-a-kind implant will make you almost invisible if you play your cards right. \
			On activation, it will conceal you inside a chameleon cardboard box that is only revealed once someone bumps into it."
	item = /obj/item/storage/box/syndie_kit/imp_stealth
	cost = 8

/datum/uplink_item/implants/storage
	name = "Storage Implant"
	desc = "An implant injected into the body, and later activated at the user's will. It will open a small bluespace \
			pocket capable of storing two regular-sized items."
	item = /obj/item/storage/box/syndie_kit/imp_storage
	cost = 8

/datum/uplink_item/implants/thermals
	name = "Thermal Eyes"
	desc = "These cybernetic eyes will give you thermal vision. Comes with a free autosurgeon."
	item = /obj/item/autosurgeon/organ/syndicate/thermal_eyes
	cost = 8
	surplus = 0
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/implants/uplink
	name = "Uplink Implant"
	desc = "An implant injected into the body, and later activated at the user's will. Has no telecrystals and must be charged by the use of physical telecrystals. \
			Undetectable (except via surgery), and excellent for escaping confinement."
	item = /obj/item/storage/box/syndie_kit // the actual uplink implant is generated later on in spawn_item
	cost = UPLINK_IMPLANT_TELECRYSTAL_COST
	// An empty uplink is kinda useless.
	surplus = 0
	restricted = TRUE

/datum/uplink_item/implants/uplink/spawn_item(spawn_path, mob/user, datum/component/uplink/purchaser_uplink)
	var/obj/item/storage/box/syndie_kit/uplink_box = ..()
	uplink_box.name = "Uplink Implant Box"
	new /obj/item/implanter/uplink(uplink_box, purchaser_uplink.uplink_flag)
	return uplink_box


/datum/uplink_item/implants/xray
	name = "X-ray Vision Implant"
	desc = "These cybernetic eyes will give you X-ray vision. Comes with an autosurgeon."
	item = /obj/item/autosurgeon/organ/syndicate/xray_eyes
	cost = 10
	surplus = 0
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/implants/deathrattle
	name = "Box of Deathrattle Implants"
	desc = "A collection of implants (and one reusable implanter) that should be injected into the team. When one of the team \
	dies, all other implant holders recieve a mental message informing them of their teammates' name \
	and the location of their death. Unlike most implants, these are designed to be implanted \
	in any creature, biological or mechanical."
	item = /obj/item/storage/box/syndie_kit/imp_deathrattle
	cost = 4
	surplus = 0
	purchasable_from = UPLINK_NUKE_OPS


//Race-specific items
/datum/uplink_item/race_restricted
	category = "Species-Restricted"
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
	surplus = 0

/datum/uplink_item/race_restricted/syndilamp
	name = "Extra-Bright Lantern"
	desc = "We heard that moths such as yourself really like lamps, so we decided to grant you early access to a prototype \
	Syndicate brand \"Extra-Bright Lantern™\". Enjoy."
	cost = 2
	item = /obj/item/flashlight/lantern/syndicate
	restricted_species = list(SPECIES_MOTH)

// Role-specific items
/datum/uplink_item/role_restricted
	category = "Role-Restricted"
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
	surplus = 0

/datum/uplink_item/role_restricted/ancient_jumpsuit
	name = "Ancient Jumpsuit"
	desc = "A tattered old jumpsuit that will provide absolutely no benefit to you."
	item = /obj/item/clothing/under/color/grey/ancient
	cost = 20
	restricted_roles = list(JOB_ASSISTANT)
	surplus = 0

/datum/uplink_item/role_restricted/oldtoolboxclean
	name = "Ancient Toolbox"
	desc = "An iconic toolbox design notorious with Assistants everywhere, this design was especially made to become more robust the more telecrystals it has inside it! Tools and insulated gloves included."
	item = /obj/item/storage/toolbox/mechanical/old/clean
	cost = 2
	restricted_roles = list(JOB_ASSISTANT)
	surplus = 0

/datum/uplink_item/role_restricted/pie_cannon
	name = "Banana Cream Pie Cannon"
	desc = "A special pie cannon for a special clown, this gadget can hold up to 20 pies and automatically fabricates one every two seconds!"
	cost = 10
	item = /obj/item/pneumatic_cannon/pie/selfcharge
	restricted_roles = list(JOB_CLOWN)
	surplus = 0 //No fun unless you're the clown!

/* // SKYRAT EDIT - REMOVAL BEGIN
/datum/uplink_item/role_restricted/blastcannon
	name = "Blast Cannon"
	desc = "A highly specialized weapon, the Blast Cannon is actually relatively simple. It contains an attachment for a tank transfer valve mounted to an angled pipe specially constructed \
			withstand extreme pressure and temperatures, and has a mechanical trigger for triggering the transfer valve. Essentially, it turns the explosive force of a bomb into a narrow-angle \
			blast wave \"projectile\". Aspiring scientists may find this highly useful, as forcing the pressure shockwave into a narrow angle seems to be able to bypass whatever quirk of physics \
			disallows explosive ranges above a certain distance, allowing for the device to use the theoretical yield of a transfer valve bomb, instead of the factual yield. It's simple design makes it easy to conceal."
	item = /obj/item/gun/blastcannon
	cost = 14 //High cost because of the potential for extreme damage in the hands of a skilled scientist.
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST)
*/ // SKYRAT EDIT - REMOVAL END

/datum/uplink_item/role_restricted/gorillacubes
	name = "Box of Gorilla Cubes"
	desc = "A box with three Waffle Co. brand gorilla cubes. Eat big to get big. \
			Caution: Product may rehydrate when exposed to water."
	item = /obj/item/storage/box/gorillacubes
	cost = 6
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_GENETICIST)

/* SKYRAT EDIT CHANGE - MOVED TO UNRESTRICTED
/datum/uplink_item/role_restricted/brainwash_disk
	name = "Brainwashing Surgery Program"
	desc = "A disk containing the procedure to perform a brainwashing surgery, allowing you to implant an objective onto a target. \
	Insert into an Operating Console to enable the procedure."
	item = /obj/item/disk/surgery/brainwashing
	restricted_roles = list(
		JOB_CHIEF_MEDICAL_OFFICER, JOB_MEDICAL_DOCTOR,
		JOB_ROBOTICIST,
	)
	cost = 5
*/

/datum/uplink_item/role_restricted/clown_bomb
	name = "Clown Bomb"
	desc = "The Clown bomb is a hilarious device capable of massive pranks. It has an adjustable timer, \
			with a minimum of 60 seconds, and can be bolted to the floor with a wrench to prevent \
			movement. The bomb is bulky and cannot be moved; upon ordering this item, a smaller beacon will be \
			transported to you that will teleport the actual bomb to it upon activation. Note that this bomb can \
			be defused, and some crew may attempt to do so."
	item = /obj/item/sbeacondrop/clownbomb
	cost = 15
	restricted_roles = list(JOB_CLOWN)

/datum/uplink_item/role_restricted/clumsinessinjector //clown ops can buy this too, but it's in the pointless badassery section for them
	name = "Clumsiness Injector"
	desc = "Inject yourself with this to become as clumsy as a clown... or inject someone ELSE with it to make THEM as clumsy as a clown. Useful for clowns who wish to reconnect with their former clownish nature or for clowns who wish to torment and play with their prey before killing them."
	item = /obj/item/dnainjector/clumsymut
	cost = 1
	restricted_roles = list(JOB_CLOWN)
	illegal_tech = FALSE

//SKYRAT EDIT REMOVAL BEGIN
/*
/datum/uplink_item/role_restricted/spider_injector
	name = "Australicus Slime Mutator"
	desc = "Crikey mate, it's been a wild travel from the Australicus sector but we've managed to get \
			some special spider extract from the giant spiders down there. Use this injector on a gold slime core \
			to create a few of the same type of spiders we found on the planets over there. They're a bit tame until you \
			also give them a bit of sentience though."
	item = /obj/item/reagent_containers/syringe/spider_extract
	cost = 10
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/uplink_item/role_restricted/clowncar
	name = "Clown Car"
	desc = "The Clown Car is the ultimate transportation method for any worthy clown! \
			Simply insert your bikehorn and get in, and get ready to have the funniest ride of your life! \
			You can ram any spacemen you come across and stuff them into your car, kidnapping them and locking them inside until \
			someone saves them or they manage to crawl out. Be sure not to ram into any walls or vending machines, as the springloaded seats \
			are very sensitive. Now with our included lube defense mechanism which will protect you against any angry shitcurity! \
			Premium features can be unlocked with a cryptographic sequencer!"
	item = /obj/vehicle/sealed/car/clowncar
	cost = 20
	restricted_roles = list(JOB_CLOWN)
*/
//SKYRAT EDIT REMOVAL END

/datum/uplink_item/role_restricted/concealed_weapon_bay
	name = "Concealed Weapon Bay"
	desc = "A modification for non-combat mechas that allows them to equip one piece of equipment designed for combat mechs. \
			It also hides the equipped weapon from plain sight. \
			Only one can fit on a mecha."
	item = /obj/item/mecha_parts/concealed_weapon_bay
	cost = 3
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_ROBOTICIST)

/datum/uplink_item/role_restricted/syndimmi
	name = "Syndicate Brand MMI"
	desc = "An MMI modified to give cyborgs laws to serve the Syndicate without having their interface damaged by Cryptographic Sequencers, this will not unlock their hidden modules."
	item = /obj/item/mmi/syndie
	cost = 2
	restricted_roles = list(
		JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST,
		JOB_CHIEF_MEDICAL_OFFICER, JOB_MEDICAL_DOCTOR,
	)
	surplus = 0

/datum/uplink_item/role_restricted/haunted_magic_eightball
	name = "Haunted Magic Eightball"
	desc = "Most magic eightballs are toys with dice inside. Although identical in appearance to the harmless toys, this occult device reaches into the spirit world to find its answers. \
			Be warned, that spirits are often capricious or just little assholes. To use, simply speak your question aloud, then begin shaking."
	item = /obj/item/toy/eightball/haunted
	cost = 2
	restricted_roles = list("Curator")
	limited_stock = 1 //please don't spam deadchat

//SKYRAT EDIT REMOVAL START
/*
/datum/uplink_item/role_restricted/his_grace
	name = "His Grace"
	desc = "An incredibly dangerous weapon recovered from a station overcome by the grey tide. Once activated, He will thirst for blood and must be used to kill to sate that thirst. \
	His Grace grants gradual regeneration and complete stun immunity to His wielder, but be wary: if He gets too hungry, He will become impossible to drop and eventually kill you if not fed. \
	However, if left alone for long enough, He will fall back to slumber. \
	To activate His Grace, simply unlatch Him."
	item = /obj/item/his_grace
	cost = 20
	restricted_roles = list(JOB_CHAPLAIN)
	surplus = 5 //Very low chance to get it in a surplus crate even without being the chaplain
*/
//SKYRAT EDIT REMOVAL END

/datum/uplink_item/role_restricted/explosive_hot_potato
	name = "Exploding Hot Potato"
	desc = "A potato rigged with explosives. On activation, a special mechanism is activated that prevents it from being dropped. \
			The only way to get rid of it if you are holding it is to attack someone else with it, causing it to latch to that person instead."
	item = /obj/item/hot_potato/syndicate
	cost = 4
	surplus = 0
	restricted_roles = list(JOB_COOK, JOB_BOTANIST, JOB_CLOWN, JOB_MIME)

/datum/uplink_item/role_restricted/ez_clean_bundle
	name = "EZ Clean Grenade Bundle"
	desc = "A box with three cleaner grenades using the trademark Waffle Co. formula. Serves as a cleaner and causes acid damage to anyone standing nearby. \
			The acid only affects carbon-based creatures."
	item = /obj/item/storage/box/syndie_kit/ez_clean
	cost = 6
	surplus = 20
	restricted_roles = list(JOB_JANITOR)

/datum/uplink_item/role_restricted/mimery
	name = "Guide to Advanced Mimery Series"
	desc = "The classical two part series on how to further hone your mime skills. Upon studying the series, the user should be able to make 3x1 invisible walls, and shoot bullets out of their fingers. \
			Obviously only works for Mimes."
	cost = 12
	item = /obj/item/storage/box/syndie_kit/mimery
	restricted_roles = list(JOB_MIME)
	surplus = 0

/datum/uplink_item/role_restricted/pressure_mod
	name = "Kinetic Accelerator Pressure Mod"
	desc = "A modification kit which allows Kinetic Accelerators to do greatly increased damage while indoors. \
			Occupies 35% mod capacity."
	item = /obj/item/borg/upgrade/modkit/indoors
	cost = 5 //you need two for full damage, so total of 10 for maximum damage
	limited_stock = 2 //you can't use more than two!
	restricted_roles = list(JOB_SHAFT_MINER)

/datum/uplink_item/role_restricted/magillitis_serum
	name = "Magillitis Serum Autoinjector"
	desc = "A single-use autoinjector which contains an experimental serum that causes rapid muscular growth in Hominidae. \
			Side-affects may include hypertrichosis, violent outbursts, and an unending affinity for bananas."
	item = /obj/item/reagent_containers/hypospray/medipen/magillitis
	cost = 15
	//restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_GENETICIST) //SKYRAT EDIT: Removal

/datum/uplink_item/role_restricted/modified_syringe_gun
	name = "Modified  Compact Syringe Gun"
	desc = "A compact version of the syringe gun that fires DNA injectors instead of normal syringes."
	item = /obj/item/gun/syringe/dna
	cost = 14
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_GENETICIST)

/datum/uplink_item/role_restricted/chemical_gun
	name = "Reagent Dartgun"
	desc = "A heavily modified syringe gun which is capable of synthesizing its own chemical darts using input reagents. Can hold 100u of reagents."
	item = /obj/item/gun/chem
	cost = 12
	/* SKYRAT EDIT REMOVAL
	restricted_roles = list(
		JOB_CHIEF_MEDICAL_OFFICER, JOB_CHEMIST,
		JOB_BOTANIST,
	)
	*/

/datum/uplink_item/role_restricted/reverse_bear_trap
	name = "Reverse Bear Trap"
	desc = "An ingenious execution device worn on (or forced onto) the head. Arming it starts a 1-minute kitchen timer mounted on the bear trap. When it goes off, the trap's jaws will \
	violently open, instantly killing anyone wearing it by tearing their jaws in half. To arm, attack someone with it while they're not wearing headgear, and you will force it onto their \
	head after three seconds uninterrupted."
	cost = 5
	item = /obj/item/reverse_bear_trap
	//restricted_roles = list(JOB_CLOWN) //SKYRAT EDIT: Removal

/datum/uplink_item/role_restricted/reverse_revolver
	name = "Reverse Revolver"
	desc = "A revolver that always fires at its user. \"Accidentally\" drop your weapon, then watch as the greedy corporate pigs blow their own brains all over the wall. \
	The revolver itself is actually real. Only clumsy people, and clowns, can fire it normally. Comes in a box of hugs. Honk."
	cost = 14
	item = /obj/item/storage/box/hug/reverse_revolver
	restricted_roles = list(JOB_CLOWN)

/datum/uplink_item/role_restricted/clownpin
	name = "Ultra Hilarious Firing Pin"
	desc = "A firing pin that, when inserted into a gun, makes that gun only usable by clowns and clumsy people and makes that gun honk whenever anyone tries to fire it."
	cost = 4
	item = /obj/item/firing_pin/clown/ultra
	restricted_roles = list(JOB_CLOWN)
	illegal_tech = FALSE

/datum/uplink_item/role_restricted/clownsuperpin
	name = "Super Ultra Hilarious Firing Pin"
	desc = "Like the ultra hilarious firing pin, except the gun you insert this pin into explodes when someone who isn't clumsy or a clown tries to fire it."
	cost = 7
	item = /obj/item/firing_pin/clown/ultra/selfdestruct
	restricted_roles = list(JOB_CLOWN)
	illegal_tech = FALSE

/datum/uplink_item/role_restricted/laser_arm
	name = "Laser Arm Implant"
	desc = "An implant that grants you a recharging laser gun inside your arm. Weak to EMPs. Comes with a syndicate autosurgeon for immediate self-application."
	cost = 10
	item = /obj/item/autosurgeon/organ/syndicate/laser_arm
	//restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_ROBOTICIST) //SKYRAT EDIT: Removal

/datum/uplink_item/role_restricted/bureaucratic_error_remote
	name = "Organic Resources Disturbance Inducer"
	desc = "A device that raises hell in organic resources indirectly. Single use."
	cost = 2
	limited_stock = 1
	item = /obj/item/devices/bureaucratic_error_remote
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER)

/datum/uplink_item/role_restricted/meathook
	name = "Butcher's Meat Hook"
	desc = "A brutal cleaver on a long chain, it allows you to pull people to your location."
	item = /obj/item/gun/magic/hook
	cost = 11
	restricted_roles = list(JOB_COOK)

/datum/uplink_item/role_restricted/turretbox
	name = "Disposable Sentry Gun"
	desc = "A disposable sentry gun deployment system cleverly disguised as a toolbox, apply wrench for functionality."
	item = /obj/item/storage/toolbox/emergency/turret
	cost = 11
	restricted_roles = list(JOB_STATION_ENGINEER)

// Pointless
/datum/uplink_item/badass
	category = "(Pointless) Badassery"
	surplus = 0

/datum/uplink_item/badass/costumes/obvious_chameleon
	name = "Broken Chameleon Kit"
	desc = "A set of items that contain chameleon technology allowing you to disguise as pretty much anything on the station, and more! \
			Please note that this kit did NOT pass quality control."
	item = /obj/item/storage/box/syndie_kit/chameleon/broken

/datum/uplink_item/badass/costumes
	surplus = 0
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS
	cost = 4
	cant_discount = TRUE

/datum/uplink_item/badass/costumes/centcom_official
	name = "CentCom Official Costume"
	desc = "Ask the crew to \"inspect\" their nuclear disk and weapons system, and then when they decline, pull out a fully automatic rifle and gun down the Captain. \
			Radio headset does not include encryption key. No gun included."
	item = /obj/item/storage/box/syndie_kit/centcom_costume

/datum/uplink_item/badass/costumes/clown
	name = "Clown Costume"
	desc = "Nothing is more terrifying than clowns with fully automatic weaponry."
	item = /obj/item/storage/backpack/duffelbag/clown/syndie

/datum/uplink_item/badass/costumes/tactical_naptime
	name = "Sleepy Time Pajama Bundle"
	desc = "Even soldiers need to get a good nights rest. Comes with blood-red pajamas, a blankie, a hot mug of cocoa and a fuzzy friend."
	item = /obj/item/storage/box/syndie_kit/sleepytime
	cost = 4
	limited_stock = 1
	cant_discount = TRUE

/datum/uplink_item/badass/balloon
	name = "Syndicate Balloon"
	desc = "For showing that you are THE BOSS: A useless red balloon with the Syndicate logo on it. \
			Can blow the deepest of covers."
	item = /obj/item/toy/balloon/syndicate
	cost = 20
	cant_discount = TRUE
	illegal_tech = FALSE

/datum/uplink_item/badass/syndiecash
	name = "Syndicate Briefcase Full of Cash"
	desc = "A secure briefcase containing 5000 space credits. Useful for bribing personnel, or purchasing goods \
			and services at lucrative prices. The briefcase also feels a little heavier to hold; it has been \
			manufactured to pack a little bit more of a punch if your client needs some convincing."
	item = /obj/item/storage/secure/briefcase/syndie
	cost = 1
	restricted = TRUE
	illegal_tech = FALSE

/datum/uplink_item/badass/syndiecards
	name = "Syndicate Playing Cards"
	desc = "A special deck of space-grade playing cards with a mono-molecular edge and metal reinforcement, \
			making them slightly more robust than a normal deck of cards. \
			You can also play card games with them or leave them on your victims."
	item = /obj/item/toy/cards/deck/syndicate
	cost = 1
	surplus = 40
	illegal_tech = FALSE

/datum/uplink_item/badass/syndiecigs
	name = "Syndicate Smokes"
	desc = "Strong flavor, dense smoke, infused with omnizine."
	item = /obj/item/storage/fancy/cigarettes/cigpack_syndicate
	cost = 2
	illegal_tech = FALSE

/datum/uplink_item/badass/clownopclumsinessinjector //clowns can buy this too, but it's in the role-restricted items section for them
	name = "Clumsiness Injector"
	desc = "Inject yourself with this to become as clumsy as a clown... or inject someone ELSE with it to make THEM as clumsy as a clown. Useful for clown operatives who wish to reconnect with their former clownish nature or for clown operatives who wish to torment and play with their prey before killing them."
	item = /obj/item/dnainjector/clumsymut
	cost = 1
	purchasable_from = UPLINK_CLOWN_OPS
	illegal_tech = FALSE

//Discounts (dynamically filled above)
/datum/uplink_item/discounts
	category = /datum/uplink_category/discounts

// Special equipment (Dynamically fills in uplink component)
/datum/uplink_item/special_equipment
	category = "Objective-Specific Equipment"
	name = "Objective-Specific Equipment"
	desc = "Equipment necessary for accomplishing specific objectives. If you are seeing this, something has gone wrong."
	limited_stock = 1
	illegal_tech = FALSE

/datum/uplink_item/special_equipment/purchase(mob/user, datum/component/uplink/U)
	..()
	if(user?.mind?.failed_special_equipment)
		user.mind.failed_special_equipment -= item
