/obj/projectile/beam/disabler/disgust // Disgusting beam...
	damage = 0
	icon_state = "omnilaser"
	light_color = LIGHT_COLOR_GREEN

/obj/projectile/beam/disabler/disgust/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	var/mob/living/carbon/hit = target
	if(iscarbon(hit))
		hit.disgust += 15

/obj/projectile/beam/disabler/warcrime
	damage = 0
	icon_state = "toxin"
	light_color = LIGHT_COLOR_BLOOD_MAGIC

/obj/projectile/beam/disabler/warcrime/on_hit(atom/target, blocked, pierce_hit) // Might be a Traitor(sec) thing.
	. = ..()
	var/mob/living/carbon/human/hit = target
	var/effects = rand(5,15)
	if(ishuman(hit))
		hit.disgust += DISGUST_LEVEL_GROSS
		hit.stuttering += effects
		hit.slurring += effects
		hit.derpspeech += effects
		hit.losebreath += effects
		hit.dizziness += effects
		hit.jitteriness += effects

/obj/projectile/beam/disabler/drowsy
	icon_state = "omnilaser"
	light_color = LIGHT_COLOR_LAVENDER

/obj/projectile/beam/disabler/drowsy/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	var/mob/living/carbon/hit = target
	if(iscarbon(hit))
		hit.adjust_drowsyness(rand(10,20))
