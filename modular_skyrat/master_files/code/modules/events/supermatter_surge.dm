/datum/round_event_control/supermatter_surge
	name = "Supermatter Surge"
	typepath = /datum/round_event/supermatter_surge
	weight = 20
	max_occurrences = 4
	earliest_start = 10 MINUTES

/datum/round_event_control/supermatter_surge/canSpawnEvent()
	if(GLOB.main_supermatter_engine?.has_been_powered)
		return ..()

/datum/round_event/supermatter_surge
	var/power = 2000

/datum/round_event/supermatter_surge/setup()
	if(prob(70))
		power = rand(200,100000)
	else
		power = rand(200,200000)

/datum/round_event/supermatter_surge/announce()
	var/severity = ""
	switch(power)
		if(-INFINITY to 100000)
			var/low_threat_perc = 100-round(100*((power-200)/(100000-200)))
			if(prob(low_threat_perc))
				if(prob(low_threat_perc))
					severity = "low; the supermatter should return to normal operation shortly."
				else
					severity = "medium; the supermatter should return to normal operation, but check NT CIMS to ensure this."
			else
				severity = "high; if the supermatter's cooling is not fortified, coolant may need to be added."
		if(100000 to INFINITY)
			severity = "extreme; emergency action is likely to be required even if coolant loop is fine."
	if(power > 20000 || prob(round(power/200)))
		priority_announce("Supermatter surge detected. Estimated severity is [severity]", "Anomaly Alert")

/datum/round_event/supermatter_surge/start()
	GLOB.main_supermatter_engine.matter_power += power
