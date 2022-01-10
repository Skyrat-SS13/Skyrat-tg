//Datums for spawnpoints
/datum/necrospawn
	var/id
	var/atom/spawnpoint				//Where are we spawning things?
	var/name = "Marker"				//What do we call this spawn location?
	var/color = "#ffffff"
	var/datum/crew_objective/event




	//TODO: Support for a preview image of the area

/datum/necrospawn/New(var/atom/origin, var/_name, var/datum/crew_objective/event)
	spawnpoint = origin
	name = _name

	if (event)
		src.event = event
		name = "Event: [event.name] | [name]"
		color = event.color
	id = "\ref[spawnpoint]"





