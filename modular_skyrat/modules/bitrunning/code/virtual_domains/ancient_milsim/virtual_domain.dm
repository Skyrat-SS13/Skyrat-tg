/datum/lazy_template/virtual_domain/ancient_milsim
	name = "Ancient Military Simulator"
	cost = BITRUNNER_COST_HIGH
	desc = "Recreate the events of the Border War's 'hot' part-long-gone as a Solarian strike team sweeping CIN compounds; sponsored by the SolFed recreation enthusiasts. \
	Multiplayer playthrough and proper preparation highly recommended."
	extra_loot = list(/obj/item/bitrunning_disk/item/ancient_milsim = 1)
	difficulty = BITRUNNER_DIFFICULTY_HIGH
	help_text = "The last part of this domain has a chance to be very PvP-centric. It's best if you don't come alone, and smuggle some ability and gear disks."
	forced_outfit = /datum/outfit/solfed_bitrun
	key = "ancient_milsim"
	map_dir = "_maps/skyrat/virtual_domains"
	map_name = "ancient_milsim"
	reward_points = BITRUNNER_REWARD_HIGH
	safehouse_path = /datum/map_template/safehouse_skyrat/ancient_milsim

/datum/map_template/safehouse_skyrat/ancient_milsim
	filename = "ancient_milsim.dmm"
