//SKYRAT GOOD TRAITS

/datum/quirk/hard_soles
	name = "Hardened Soles"
	desc = "You're used to walking barefoot, and won't receive the negative effects of doing so."
	value = 2
	mob_trait = TRAIT_HARD_SOLES
	gain_text = "<span class='notice'>The ground doesn't feel so rough on your feet anymore.</span>"
	lose_text = "<span class='danger'>You start feeling the ridges and imperfections on the ground.</span>"
	medical_record_text = "Patient's feet are more resilient against traction."

/datum/quirk/steel_fists
	name = "Brawler"
	desc = "You are exceptionally good at unarmed combat. Punching and clawing will deal more damage and you has more chance to knock-down people."
	value = 25
	medical_record_text = "Patient is skilled in hand to hand combat."

/datum/quirk/steel_fists/add()
	. = ..()
	if(.)
		var/mob/living/carbon/human/H = quirk_holder
		if(H && istype(H))
			H.dna.species.punchdamagehigh += 17
			H.dna.species.punchdamagelow += 7
			H.dna.species.punchstunthreshold += 12

/datum/quirk/quick_picker
	name = "Hard Back"
	desc = "You're used to fireman carry wounded, and is faster than others person doing so! Not better than a paramedic."
	value = 7
	mob_trait = TRAIT_QUICK_CARRY

/datum/quirk/nodamageslowdown
	name = "High Endurance"
	desc = "Due to several traumas in your past life or just high resilience, you don't suffer a slowdown from damage. But this does not make you invincible in any kind of way."
	value = 20
	mob_trait = TRAIT_IGNOREDAMAGESLOWDOWN

/datum/quirk/nosoftcrit
	name = "High Pain Tolerance"
	desc = "Due to lack of pain receptors or just pure will to survive you can survive a little bit more in critical conditions."
	value = 20
	mob_trait = TRAIT_NOSOFTCRIT

/datum/quirk/hardwounds
	name = "Limbs Endurance"
	desc = "You limbs are stronger againts wounds"
	value = 10
	mob_trait = TRAIT_HARDLY_WOUNDED

/datum/quirk/handsonfire
	name = "Enduranced Hands"
	desc = "You can pick bulbs without any problems even without gloves"
	value = 1
	mob_trait = TRAIT_RESISTHEATHANDS
