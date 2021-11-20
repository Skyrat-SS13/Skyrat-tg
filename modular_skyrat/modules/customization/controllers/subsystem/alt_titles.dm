//SKYRAT MODULE CUSTOMIZATION
// Make a seperate subsystem so it doesn't conflict with the actual job one.

SUBSYSTEM_DEF(altjob)
	name = "Alt Jobs"
	init_order = INIT_ORDER_JOBS
	flags = SS_NO_FIRE

/datum/controller/subsystem/altjob/Initialize(timeofday)
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, .proc/on_job_after_spawn)
	return ..(timeofday)

/datum/controller/subsystem/altjob/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/spawned, client/player_client)
	SIGNAL_HANDLER

	var/alt_title = player_client.prefs.alt_job_titles[job.title]
	var/mob/living/carbon/human/human = spawned

	// If alt title is null, the player is just using default.
	// Player also needs to be a human or we're aborting.
	if(alt_title && istype(human))
		// ID card
		var/obj/item/card/id/card = human.get_idcard()
		if(istype(card))
			card.assignment = alt_title
			card.update_label()

		// PDA
		for(var/obj/item/pda/pda in human)
			pda.ownjob = alt_title
			pda.update_label()

		// Wallet
		for(var/obj/item/storage/wallet/wallet in human)
			wallet.update_label()
