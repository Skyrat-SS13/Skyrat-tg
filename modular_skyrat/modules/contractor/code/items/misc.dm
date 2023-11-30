/obj/item/paper/contractor_guide
	name = "Contractor Guide"

/obj/item/paper/contractor_guide/Initialize(mapload)
	default_raw_text = {"<p>Welcome agent, congratulations on your new position as contractor. On top of your already assigned objectives,
			this kit will provide you contracts to take on for TC payments.</p>

			<p>You likely already have your Contractor MODSuit equipped. It has a built in chameleon module, which only works when the MODSuit is undeployed,
			but is highly useful for on-station infiltrations. We also provide your chameleon jumpsuit and mask, both of which can be changed
			to any form you need for the moment. The cigarettes are a special blend - it'll heal your injuries slowly overtime.</p>

			<p>Your standard issue contractor baton hits harder than the ones you might be used to, and likely be your go to weapon for kidnapping your
			targets. The three additional items have been randomly selected from what we had available. We hope they're useful to you for your mission.</p>

			<p>The contractor hub, available at the top right of the uplink, will provide you unique items and abilities. These are bought using Contractor Rep,
			with two Rep being provided each time you complete a contract.</p>

			<h3>Using the tablet</h3>
			<ol>
				<li>Open the Syndicate Contract Uplink program.</li>
				<li>Here, you can accept a contract, and redeem your TC payments from completed contracts.</li>
				<li>The payment number shown in brackets is the bonus you'll receive when bringing your target <b>alive</b>. You receive the
				other number regardless of if they were alive or dead.</li>
				<li>Contracts are completed by bringing the target to designated dropoff, calling for extraction, and putting them
				inside the pod.</li>
			</ol>

			<p>Be careful when accepting a contract. While you'll be able to see the location of the dropoff point, cancelling will make it
			unavailable to take on again.</p>
			<p>The tablet can also be recharged at any cell charger.</p>
			<h3>Extracting</h3>
			<ol>
				<li>Make sure both yourself and your target are at the dropoff.</li>
				<li>Call the extraction, and stand back from the drop point.</li>
				<li>If it fails, make sure your target is inside, and there's a free space for the pod to land.</li>
				<li>Grab your target, and drag them into the pod.</li>
			</ol>
			<h3>Ransoms</h3>
			<p>We need your target for our own reasons, but we ransom them back to your mission area once their use is served. They will return back
			from where you sent them off from in several minutes time. Don't worry, we give you a cut of what we get paid. We pay this into whatever
			ID card you have equipped, on top of the TC payment we give.</p>

			<p>Good luck agent. You can burn this document with the supplied lighter.</p>"}

	return ..()

/obj/item/pinpointer/crew/contractor
	name = "contractor pinpointer"
	desc = "A handheld tracking device that locks onto certain signals. Ignores suit sensors, but is much less accurate."
	icon_state = "pinpointer_syndicate"
	worn_icon_state = "pinpointer_black"
	minimum_range = 15
	has_owner = TRUE
	ignore_suit_sensor_level = TRUE

/obj/item/extraction_pack/contractor
	name = "black fulton extraction pack"
	icon = 'modular_skyrat/modules/contractor/icons/fulton.dmi'
	can_use_indoors = TRUE
	special_desc_requirement = EXAMINE_CHECK_CONTRACTOR
	special_desc = "A modified fulton pack that can be used indoors thanks to Bluespace technology. Favored by Syndicate Contractors."


/obj/item/paper/contractor_guide/midround
	name = "Contractor Guide"

/obj/item/paper/contractor_guide/midround/Initialize(mapload)
	default_raw_text = {"<p>Welcome agent, congratulations on successfully getting in range of the station.</p>

			<p>You likely already have your Contractor MODSuit equipped. It has a built in chameleon module, which only works when the MODSuit is undeployed,
			but is highly useful for on-station infiltrations. We also provide your chameleon jumpsuit and mask, both of which can be changed
			to any form you need for the moment. The cigarettes are a special blend - it'll heal your injuries slowly overtime.</p>

			<p>Your standard issue contractor baton can be found in the baton holster MODSuit module, it hits harder than the ones you might be used to,
			and will likely be your go to weapon for kidnapping your targets.The three additional items have been randomly selected from what we had available.
			We hope they're useful to you for your mission.</p>

			<p>The contractor hub, available at the top right of the uplink, will provide you unique items and abilities. These are bought using Contractor Rep,
			with two Rep being provided each time you complete a contract.</p>

			<p>You've also been provided with a medipen of atropine, to prevent your implanted microbomb going off if it would be more tactically sound for your
			body to stay intact. If circumstances change, you are still able to detonate your microbomb post-mortem.</p>

			<h3>Using the tablet</h3>
			<ol>
				<li>Open the Syndicate Contract Uplink program.</li>
				<li>Here, you can accept a contract, and redeem your TC payments from completed contracts.</li>
				<li>The payment number shown in brackets is the bonus you'll receive when bringing your target <b>alive</b>. You receive the
				other number regardless of if they were alive or dead.</li>
				<li>Contracts are completed by bringing the target to designated dropoff, calling for extraction, and putting them
				inside the pod.</li>
			</ol>

			<p>Be careful when accepting a contract. While you'll be able to see the location of the dropoff point, cancelling will make it
			unavailable to take on again.</p>
			<p>The tablet can also be recharged at any cell charger.</p>
			<h3>Extracting</h3>
			<ol>
				<li>Make sure both yourself and your target are at the dropoff.</li>
				<li>Call the extraction, and stand back from the drop point.</li>
				<li>If it fails, make sure your target is inside, and there's a free space for the pod to land.</li>
				<li>Grab your target, and drag them into the pod.</li>
			</ol>
			<h3>Ransoms</h3>
			<p>We need your target for our own reasons, but we ransom them back to your mission area once their use is served. They will return back
			from where you sent them off from in several minutes time. Don't worry, we give you a cut of what we get paid. We pay this into whatever
			ID card you have equipped, on top of the TC payment we give.</p>

			<p>Good luck agent. You can burn this document with the supplied lighter.</p>"}

	return ..()

/obj/item/storage/toolbox/guncase/skyrat/pistol/contractor/wespe/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/sol/evil/contractor(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/incapacitator(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/incapacitator(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/starts_empty(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/starts_empty(src)
	new /obj/item/ammo_box/c35sol(src)

/obj/item/gun/ballistic/automatic/pistol/sol/evil/contractor
	name = "\improper Vesper 'Guêpe' Pistol"
	desc = "An aftermarket variant of the Trappiste 'Wespe', with an integrated suppressor. \
	Comes with an underbarrel kinetic light disruptor and tacticool black color scheme."
	icon_state = "wespe_contractor"
	suppressed = TRUE
	spawn_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol/incapacitator
	pin = /obj/item/firing_pin/implant/pindicate
	var/obj/item/gun/energy/recharge/fisher/underbarrel

/obj/item/gun/ballistic/automatic/pistol/sol/evil/contractor/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_VESPER)

/obj/item/gun/ballistic/automatic/pistol/sol/evil/contractor/Initialize(mapload)
	. = ..()
	underbarrel = new /obj/item/gun/energy/recharge/fisher/unsafe(src)
	update_appearance()

/obj/item/gun/ballistic/automatic/pistol/sol/evil/contractor/Destroy()
	QDEL_NULL(underbarrel)
	return ..()

/obj/item/gun/ballistic/automatic/pistol/sol/evil/contractor/afterattack_secondary(atom/target, mob/living/user, proximity_flag, click_parameters)
	underbarrel.afterattack(target, user, proximity_flag, click_parameters)
	return SECONDARY_ATTACK_CONTINUE_CHAIN

// go stealth mode idiot
/obj/item/gun/ballistic/automatic/pistol/sol/evil/contractor/add_seclight_point()
	return

/obj/item/gun/ballistic/automatic/pistol/sol/evil/contractor/examine_more(mob/user)
	. = ..()

	. += "\nThe Guêpe is simply a modified Trappiste 'Wespe'. Its main difference, often \
	claimed to not be enough to warrant its advertisement as an overhaul, is a stubby \
	integral suppressor and a modified housing with side-button trigger for a \
	chopped-down SC/FISHER for disrupting electrical sources of light."

	return .

/obj/item/autosurgeon/syndicate/laser_arm/selfdes

/obj/item/autosurgeon/syndicate/laser_arm/selfdes/use_autosurgeon(mob/living/target, mob/living/user, implant_time)
	. = ..()
	if(!uses)
		to_chat(user, span_alert("[src] shatters into unusable dust, scattering to the wind with a convenient gust."))
		qdel(src)

/obj/item/mod/module/demoralizer/removable
	removable = TRUE

/obj/item/mod/module/power_kick/removable
	removable = TRUE
