/datum/mood_event/brushed
	description = span_nicegreen("Someone brushed my hair recently, that felt great!")
	mood_change = 3
	timeout = 4 MINUTES

/datum/mood_event/brushed/add_effects(mob/brusher)
	description = span_nicegreen("[brusher.name] brushed my hair recently, that felt great!")

/datum/mood_event/brushed/self
	description = span_nicegreen("I brushed my hair recently!")
	mood_change = 2		// You can't hit all the right spots yourself, or something

/datum/mood_event/brushed/pet/add_effects(mob/brushed_pet)
	description = span_nicegreen("I brushed [brushed_pet] recently, they're so cute!")
