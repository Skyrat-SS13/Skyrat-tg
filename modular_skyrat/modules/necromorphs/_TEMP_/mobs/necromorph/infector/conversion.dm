/*
	Used for necrotoxin and reanimate, but not for parasite leap
	The corpse starts shaking and twitching, notifying everyone nearby what's about to happen
*/
/mob/living/proc/start_necromorph_conversion(var/duration = 12)
	ADD_TRANSFORMATION_MOVEMENT_HANDLER(src)
	var/intensity_step = 1 / duration
	var/intensity = 0
	for (var/i in 1 to duration)
		//If the mob has become invalid, stop this
		if (!is_necromorph_conversion_valid())
			return

		//The movement handler can be deleted from outside as a way to stop the process
		//This is used if the infector's reanimate ability gets interrupted
		if (!HAS_TRANSFORMATION_MOVEMENT_HANDLER(src))
			return

		intensity += intensity_step

		if (prob(80))
			shake_animation(intensity*50)

		if (prob(80))
			playsound(src, "fracture", intensity*100, TRUE)

		if (prob(20))
			var/list/verbs = list("twitches", "cringes", "twists", "contorts", "writhes", "snaps", "crunches", "jerks", "spasms", "convulses", "distorts")
			var/list/adverbs	=	list("gruesomely", "uncontrollably", "violently", "awkwardly", "horribly", "pitifully", "painfully")
			visible_message("[src] [prob(20)	?	"[pick(adverbs)] ":""][pick(verbs)] [prob(20)	?	"and [pick(verbs)], ":""][pick(adverbs)]")

		sleep(1 SECOND)

	DEL_TRANSFORMATION_MOVEMENT_HANDLER(src)

	//Actually do it
	necromorph_conversion()


/*
	The place where converting actually happens, this is instant, no sleeps here
*/
/mob/living/proc/necromorph_conversion(var/compatibility = 1)


	//Final
	if (!is_necromorph_conversion_valid())
		return

	if (client || key)
		ghostize()	//Kick out any existing client


	//Animal conversion doesnt use species, we just spawn a new mob and delete the old one
	var/list/options = get_necromorph_conversion_possibilities(compatibility)
	var/newtype = pick(options)
	var/mob/living/necro = new newtype(loc)
	necro.set_biomass(src.biomass)
	gib()


	//Mice become divider components
	//Cats, dogs, etc become lurkers


//TODO: Fix necromorphs wearing rigs

/mob/living/carbon/human/necromorph_conversion(var/compatibility = 1)
	var/biomass_before = biomass

	//Final
	if (!is_necromorph_conversion_valid())
		return

	if (client || key)
		ghostize()	//Kick out any existing client

	ADD_TRANSFORMATION_MOVEMENT_HANDLER(src)

	compatibility += get_bonus_conversion_compatibility()

	var/list/options = get_necromorph_conversion_possibilities(compatibility)

	var/datum/species/S = pickweight(options)	//This gives us a typepath
	S = all_species[S]	//Convert it to datum

	set_species(S.name)


	resurrect(200) //Revive
	spawn(2)
		regenerate_icons(TRUE)

	//Lets do lots of audio of flesh cracking at randomly staggered intervals over a second
	for (var/i in 1 to 5)
		spawn(rand_between(0, 1 SECOND))
			playsound(src, "fracture", VOLUME_HIGH, TRUE)

	//We do gib visual fx without actually destroying the mob
	gibs(loc, dna)

	set_biomass(biomass_before)	//Our total biomass does not change

	//TODO: Check that our biomass isnt changing
	set_extension(src, /datum/extension/customisation_applied)	//Prevent the clothes from being changed if someone posesses it

	DEL_TRANSFORMATION_MOVEMENT_HANDLER(src)

/*
	Necro Selection

	Animals pick based on size
*/
/mob/living/proc/get_necromorph_conversion_possibilities()
	var/list/options = list()
	switch(mob_size)
		if (MOB_MINISCULE to MOB_TINY)
			options = list(/mob/living/simple_animal/necromorph/divider_component/leg = 1, /mob/living/simple_animal/necromorph/divider_component/arm = 1)
		if (MOB_SMALL)
			options = list(/mob/living/carbon/human/necromorph/lurker = 1)
		if (MOB_MEDIUM)
			options = list(/mob/living/carbon/human/necromorph/exploder = 1)
		if (MOB_LARGE)
			options = list(/mob/living/carbon/human/necromorph/brute = 1)

	return options

/mob/living/carbon/human/get_necromorph_conversion_possibilities(var/compatibility = 1)
	//These options are always available
	var/list/options = list(SPECIES_NECROMORPH_SLASHER = (9.5 / compatibility),
	SPECIES_NECROMORPH_SLASHER_ENHANCED = (1 * compatibility))

	//Monkey?
	if(mob_size < MOB_MEDIUM)
		options = list(SPECIES_NECROMORPH_LEAPER_HOPPER	=	1)
		return options

	//Gender based options
	if (gender == FEMALE)
		options[SPECIES_NECROMORPH_SPITTER]	=	3 * compatibility
	else
		options[SPECIES_NECROMORPH_EXPLODER]	=	2.5 * compatibility
		options[SPECIES_NECROMORPH_EXPLODER_ENHANCED]	=	0.5 * compatibility

	//Future TODO: Twitcher if they had stasis

	//The victim's job may open possibilities. For example, command and science staff could become a Divider
	var/datum/job/J = get_job()
	if (istype(J) && LAZYLEN(J.necro_conversion_options))
		//Grab the extra options, and we need to modify them with compatibility before applying
		var/list/extra_options = J.necro_conversion_options.Copy()
		for (var/thing in extra_options)
			extra_options[thing] *= compatibility
		options |= extra_options

	//Heavily poisoned people can become a puker
	if (getToxLoss() > 100)
		options[SPECIES_NECROMORPH_PUKER]	=	2 * compatibility



	/*
		If the victim was lightly armored and has both of their legs remaining, they might become a leaper
		Why legs? The leaper's tail is made of two legs fused together

		Why then does a slasher not require the host to have arms, you might ask?
		Because slashers grow new arms out of the victim's shoulderblades, the existing arms become vestigial and hang limply
	*/
	var/light_armor = TRUE
	if (wear_suit)
		var/obj/item/clothing/C = wear_suit
		if (C.armor["melee"] > 15 ||	C.armor["bullet"] > 15)
			light_armor = FALSE

	if (light_armor && has_organ(BP_L_LEG) && has_organ(BP_R_LEG))
		options[SPECIES_NECROMORPH_LEAPER]	=	2 * compatibility	//Its still a pretty rare option

	return options


/*
	Safety Checks
*/
/mob/living/proc/is_necromorph_conversion_valid()
	.= TRUE
	if (stat != DEAD && stat != UNCONSCIOUS)
		return FALSE

	if (QDELETED(src))
		return FALSE

	if (is_necromorph())
		return FALSE


/mob/living/carbon/human/is_necromorph_conversion_valid()
	.=..()
	if (!has_organ(BP_HEAD))
		return FALSE





//Compatibility
/*
	This proc returns a number which is added to the base compatibility
	penalties are here too, it can go negative
*/
/mob/living/proc/get_bonus_conversion_compatibility()
	.=0

	if ((world.time - timeofdeath) < 15 MINUTES)
		//Fresh corpses are better
		. += 0.25



/mob/living/carbon/human/get_bonus_conversion_compatibility()
	.=..()


	var/list/missing_limbs = list()
	//Limb Handling
	//This loop counts and documents the damaged limbs
	for(var/limb_tag in species.has_limbs)

		var/obj/item/organ/external/E = organs_by_name[limb_tag]

		if (E && E.is_usable() && !E.is_stump())
			//This organ is fine, skip it
			continue
		else if (!E || E.limb_flags & ORGAN_FLAG_CAN_AMPUTATE)
			missing_limbs |= limb_tag


	//Look for any extensions that may have altered compatibility
	for (var/datum/extension/E as anything in LAZYACCESS(statmods, STATMOD_CONVERSION_COMPATIBILITY))
		.+= E.get_statmod(STATMOD_CONVERSION_COMPATIBILITY)


	//Bodies that are in pieces are less useful
	. -= 0.075 * length(missing_limbs)


	var/datum/job/J = get_job()
	if (istype(J))
		. += J.necro_conversion_compatibility


