/datum/design/ladder_skill_chip
	name = "Ladder Lover Skill Chip"
	desc = "A skill chip designed to increase ladder climbing proformance."
	id = "ladder_skill_chip"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list (/datum/material/iron = 2500, /datum/material/glass = 800)
	construction_time = 100
	build_path = /obj/item/skillchip/fastclimb
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE
