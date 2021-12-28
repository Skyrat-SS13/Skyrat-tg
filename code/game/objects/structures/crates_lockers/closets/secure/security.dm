/obj/structure/closet/secure_closet/captains
	name = "\proper captain's locker"
	req_access = list(ACCESS_CAPTAIN)
	icon_state = "cap"

/obj/structure/closet/secure_closet/captains/PopulateContents()
	..()

	new /obj/item/storage/backpack/captain(src)
	new /obj/item/storage/backpack/satchel/cap(src)
	new /obj/item/storage/backpack/duffelbag/captain(src)
	new /obj/item/clothing/neck/petcollar(src)
	new /obj/item/pet_carrier(src)
	new /obj/item/storage/bag/garment/captain(src)
	new /obj/item/cartridge/captain(src)
	new /obj/item/storage/box/silver_ids(src)
	new /obj/item/radio/headset/heads/captain/alt(src)
	new /obj/item/radio/headset/heads/captain(src)
	new /obj/item/storage/belt/sabre(src)
	new /obj/item/gun/energy/e_gun(src)
	new /obj/item/door_remote/captain(src)
	new /obj/item/storage/photo_album/captain(src)

/obj/structure/closet/secure_closet/hop
	name = "\proper head of personnel's locker"
	req_access = list(ACCESS_HOP)
	icon_state = "hop"
	storage_capacity = 40 //SKYRAT EDIT ADDITION

/obj/structure/closet/secure_closet/hop/PopulateContents()
	..()
	new /obj/item/storage/bag/garment/hop(src)
	new /obj/item/storage/lockbox/medal/service(src)
	new /obj/item/cartridge/hop(src)
	new /obj/item/radio/headset/heads/hop(src)
	new /obj/item/storage/box/ids(src)
	new /obj/item/storage/box/ids(src)
	new /obj/item/megaphone/command(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/gun/energy/e_gun(src)
	new /obj/item/clothing/neck/petcollar(src)
	new /obj/item/pet_carrier(src)
	new /obj/item/door_remote/civilian(src)
	new /obj/item/circuitboard/machine/techfab/department/service(src)
	new /obj/item/storage/photo_album/hop(src)
	new /obj/item/storage/lockbox/medal/hop(src)

/obj/structure/closet/secure_closet/hos
	name = "\proper head of security's locker"
	req_access = list(ACCESS_HOS)
	icon_state = "hos"

/obj/structure/closet/secure_closet/hos/PopulateContents()
	..()

	new /obj/item/cartridge/hos(src)
	new /obj/item/radio/headset/heads/hos(src)
	new /obj/item/storage/bag/garment/hos(src)
	new /obj/item/storage/lockbox/medal/sec(src)
	new /obj/item/megaphone/sec(src)
	new /obj/item/holosign_creator/security(src)
	new /obj/item/storage/lockbox/loyalty(src)
	new /obj/item/storage/box/flashbangs(src)
	new /obj/item/shield/riot/tele(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/gun/energy/e_gun/hos(src)
	new /obj/item/pinpointer/nuke(src)
	new /obj/item/circuitboard/machine/techfab/department/security(src)
	new /obj/item/storage/photo_album/hos(src)

/obj/structure/closet/secure_closet/warden
	name = "\proper warden's locker"
	req_access = list(ACCESS_ARMORY)
	icon_state = "warden"

/obj/structure/closet/secure_closet/warden/PopulateContents()
	..()
	new /obj/item/radio/headset/headset_sec(src)
	//new /obj/item/clothing/suit/armor/vest/warden(src) SKYRAT EDIT REMOVAL
	//new /obj/item/clothing/head/warden(src) SKYRAT EDIT REMOVAL
	//new /obj/item/clothing/head/warden/drill(src) SKYRAT EDIT REMOVAL
	new /obj/item/clothing/head/beret/sec/navywarden(src)
	new /obj/item/clothing/suit/armor/vest/warden/alt(src)
	//new /obj/item/clothing/under/rank/security/warden/formal(src) SKYRAT EDIT REMOVAL
	//new /obj/item/clothing/under/rank/security/warden/skirt(src) SKYRAT EDIT REMOVAL
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/holosign_creator/security(src)
	new /obj/item/clothing/mask/gas/sechailer(src)
	new /obj/item/storage/box/zipties(src)
	new /obj/item/storage/box/flashbangs(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/clothing/gloves/krav_maga/sec(src)
	new /obj/item/door_remote/head_of_security(src)


/obj/structure/closet/secure_closet/security
	name = "security officer's locker"
	req_access = list(ACCESS_SECURITY)
	icon_state = "sec"

/obj/structure/closet/secure_closet/security/PopulateContents()
	..()
	//new /obj/item/clothing/suit/armor/vest(src) SKYRAT EDIT REMOVAL
	new /obj/item/clothing/head/security_cap(src) //SKYRAT EDIT CHANGE
	new /obj/item/clothing/head/beret/sec(src) //SKYRAT EDIT ADDITION
	new /obj/item/clothing/head/helmet/sec(src) //SKYRAT EDIT ADDITION
	new /obj/item/radio/headset/headset_sec(src)
	new /obj/item/radio/headset/headset_sec/alt(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/flashlight/seclite(src)

/obj/structure/closet/secure_closet/security/sec

/obj/structure/closet/secure_closet/security/sec/PopulateContents()
	..()
	new /obj/item/storage/belt/security/full(src)

// SKYRAT EDIT CHANGE -- GOOFSEC DEP GUARDS
/obj/structure/closet/secure_closet/security/cargo
	name = "\proper customs agent's locker"
	req_access = list(ACCESS_SEC_DOORS, ACCESS_CARGO)
	icon_state = "qm"
	icon = 'icons/obj/closet.dmi'

/obj/structure/closet/secure_closet/security/cargo/PopulateContents()
	new /obj/item/radio/headset/headset_cargo(src)
	new /obj/item/clothing/shoes/sneakers/black(src)
	new /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/customs_agent(src)
	new /obj/item/clothing/head/helmet/blueshirt/skyrat/guard(src)
	new /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/customs_agent(src)
	new /obj/item/restraints/handcuffs/cable/orange(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded/departmental/cargo(src)
	new /obj/item/clothing/glasses/hud/security(src)

/obj/structure/closet/secure_closet/security/engine
	name = "\proper engineering guard's locker"
	req_access = list(ACCESS_SEC_DOORS, ACCESS_ENGINE_EQUIP)
	icon_state = "eng_secure"
	icon = 'icons/obj/closet.dmi'

/obj/structure/closet/secure_closet/security/engine/PopulateContents()
	new /obj/item/radio/headset/headset_eng(src)
	new /obj/item/clothing/shoes/workboots(src)
	new /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/engineering_guard(src)
	new /obj/item/clothing/head/helmet/blueshirt/skyrat/guard(src)
	new /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/engineering_guard(src)
	new /obj/item/restraints/handcuffs/cable/yellow(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded/departmental/engineering(src)
	new /obj/item/clothing/glasses/hud/security(src)

/obj/structure/closet/secure_closet/security/science
	name = "\proper science guard's locker"
	req_access = list(ACCESS_SEC_DOORS, ACCESS_RESEARCH)
	icon_state = "science"
	icon = 'icons/obj/closet.dmi'

/obj/structure/closet/secure_closet/security/science/PopulateContents()
	new /obj/item/radio/headset/headset_sci(src)
	new /obj/item/clothing/shoes/sneakers/black(src)
	new /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat(src)
	new /obj/item/clothing/head/helmet/blueshirt/skyrat(src)
	new /obj/item/clothing/suit/armor/vest/blueshirt/skyrat(src)
	new /obj/item/restraints/handcuffs/cable/pink(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded/departmental/science(src)
	new /obj/item/clothing/glasses/hud/security(src)

/obj/structure/closet/secure_closet/security/med
	name = "\proper orderly's locker"
	req_access = list(ACCESS_SEC_DOORS, ACCESS_MEDICAL)
	icon_state = "med_secure"
	icon = 'icons/obj/closet.dmi'

/obj/structure/closet/secure_closet/security/med/PopulateContents()
	new /obj/item/radio/headset/headset_med(src)
	new /obj/item/clothing/shoes/sneakers/white(src)
	new /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/orderly(src)
	new /obj/item/clothing/head/helmet/blueshirt/skyrat/guard(src)
	new /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/orderly(src)
	new /obj/item/restraints/handcuffs/cable/blue(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded/departmental/medical(src)
	new /obj/item/clothing/glasses/hud/security(src)
// SKYRAT EDIT CHANGE END -- GOOFSEC DEP GUARDS

/obj/structure/closet/secure_closet/detective
	name = "\improper detective's cabinet"
	req_access = list(ACCESS_FORENSICS_LOCKERS)
	icon_state = "cabinet"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	door_anim_time = 0 // no animation
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'

/obj/structure/closet/secure_closet/detective/PopulateContents()
	..()
	new /obj/item/storage/box/evidence(src)
	new /obj/item/radio/headset/headset_sec(src)
	new /obj/item/detective_scanner(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/holosign_creator/security(src)
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/clothing/suit/armor/vest/det_suit(src)
	new /obj/item/storage/belt/holster/detective/full(src)
	new /obj/item/pinpointer/crew(src)
	new /obj/item/binoculars(src)
	new /obj/item/storage/box/rxglasses/spyglasskit(src)
	new /obj/item/taperoll/police(src) //SKYRAT EDIT ADDITION - Detective starts with this in their locker :)

/obj/structure/closet/secure_closet/injection
	name = "lethal injections"
	req_access = list(ACCESS_HOS)

/obj/structure/closet/secure_closet/injection/PopulateContents()
	..()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/syringe/lethal/execution(src)

/obj/structure/closet/secure_closet/brig
	name = "brig locker"
	req_access = list(ACCESS_BRIG)
	anchored = TRUE
	var/id = null

/obj/structure/closet/secure_closet/brig/genpop
	name = "genpop storage locker"
	desc = "Used for storing the belongings of genpop's tourists visiting the locals."
	/// reference to the ID linked to the locker, done by swiping a prisoner ID on it
	var/datum/weakref/assigned_id = null

/obj/structure/closet/secure_closet/brig/genpop/attackby(obj/item/card/id/advanced/prisoner/C, mob/user)
	..()
	if(!assigned_id && istype(C, /obj/item/card/id/advanced/prisoner))
		assigned_id = WEAKREF(C)
		name = "genpop storage locker - [C.registered_name]"
		say("Prisoner ID linked to locker.")
		return
	if(C == assigned_id)
		locked = FALSE
		assigned_id = initial(assigned_id)
		name = initial(name)
		say("Linked prisoner ID detected. Unlocking locker and resetting ID.")
		update_appearance()

/obj/structure/closet/secure_closet/brig/genpop/examine(mob/user)
	. = ..()
	if(assigned_id)
		. += span_notice("The digital display on the locker shows it is currently owned by [assigned_id].")

/obj/structure/closet/secure_closet/evidence
	anchored = TRUE
	name = "Secure Evidence Closet"
	req_access_txt = "0"
	req_one_access_txt = list(ACCESS_ARMORY, ACCESS_FORENSICS_LOCKERS)

/obj/structure/closet/secure_closet/brig/PopulateContents()
	..()
	new /obj/item/clothing/under/rank/prisoner( src )
	new /obj/item/clothing/under/rank/prisoner/skirt( src )
	new /obj/item/clothing/shoes/sneakers/orange( src )

/obj/structure/closet/secure_closet/courtroom
	name = "courtroom locker"
	req_access = list(ACCESS_COURT)

/obj/structure/closet/secure_closet/courtroom/PopulateContents()
	..()
	new /obj/item/clothing/shoes/sneakers/brown(src)
	for(var/i in 1 to 3)
		new /obj/item/paper/fluff/jobs/security/court_judgement (src)
	new /obj/item/pen (src)
	new /obj/item/clothing/suit/judgerobe (src)
	new /obj/item/clothing/head/powdered_wig (src)
	new /obj/item/storage/briefcase(src)

/obj/structure/closet/secure_closet/contraband/armory
	anchored = TRUE
	name = "Contraband Locker"
	req_access = list(ACCESS_ARMORY)

/obj/structure/closet/secure_closet/contraband/heads
	anchored = TRUE
	name = "Contraband Locker"
	req_access = list(ACCESS_HEADS)

/obj/structure/closet/secure_closet/armory1
	name = "armory armor locker"
	req_access = list(ACCESS_ARMORY)
	icon_state = "armory" // SKYRAT EDIT ADDITION - NEW ICON ADDED IN peacekeeper_lockers.dm

/obj/structure/closet/secure_closet/armory1/PopulateContents()
	..()
	new /obj/item/clothing/suit/hooded/ablative(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/suit/armor/riot(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/head/helmet/riot(src)
	for(var/i in 1 to 3)
		new /obj/item/shield/riot(src)

/obj/structure/closet/secure_closet/armory2
	name = "armory ballistics locker"
	req_access = list(ACCESS_ARMORY)
	icon_state = "armory" // SKYRAT EDIT ADDITION - NEW ICON ADDED IN peacekeeper_lockers.dm

/obj/structure/closet/secure_closet/armory2/PopulateContents()
	..()
	new /obj/item/storage/box/firingpins(src)
	for(var/i in 1 to 3)
		new /obj/item/storage/box/rubbershot(src)
	for(var/i in 1 to 3)
		new /obj/item/gun/ballistic/shotgun/riot(src)

/obj/structure/closet/secure_closet/armory3
	name = "armory energy gun locker"
	req_access = list(ACCESS_ARMORY)
	icon_state = "armory" // SKYRAT EDIT ADDITION - NEW ICON ADDED IN peacekeeper_lockers.dm

/obj/structure/closet/secure_closet/armory3/PopulateContents()
	..()
	new /obj/item/storage/box/firingpins(src)
	new /obj/item/gun/energy/ionrifle(src)
	for(var/i in 1 to 3)
		new /obj/item/gun/energy/e_gun(src)
	for(var/i in 1 to 3)
		new /obj/item/gun/energy/laser(src)

/obj/structure/closet/secure_closet/tac
	name = "armory tac locker"
	req_access = list(ACCESS_ARMORY)
	icon_state = "tac"

/obj/structure/closet/secure_closet/tac/PopulateContents()
	..()
	new /obj/item/gun/ballistic/automatic/wt550(src)
	new /obj/item/clothing/head/helmet/alt(src)
	new /obj/item/clothing/mask/gas/sechailer(src)
	new /obj/item/clothing/suit/armor/bulletproof(src)

/obj/structure/closet/secure_closet/labor_camp_security
	name = "labor camp security locker"
	req_access = list(ACCESS_SECURITY)
	icon_state = "sec"

/obj/structure/closet/secure_closet/labor_camp_security/PopulateContents()
	..()
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/clothing/head/helmet/sec(src)
	new /obj/item/clothing/under/rank/security/officer(src)
	new /obj/item/clothing/under/rank/security/officer/skirt(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/flashlight/seclite(src)
