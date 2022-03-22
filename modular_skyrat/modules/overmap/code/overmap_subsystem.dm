SUBSYSTEM_DEF(overmap)
	name = "Overmap"
	init_order = INIT_ORDER_MAPPING + 1 //Always before mapping
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 0.5 SECONDS
	/// All the existing sun systems, it's gonna be atleast 1 including the main system
	var/list/sun_systems = list()
	/// The mandatory and main sun system
	var/datum/overmap_sun_system/main_system
	/// Next unique ID to pass to newly created overmap objects
	var/next_unique_id = 0
	var/list/id_object_lookup = list()

	var/list/objects_to_process = list()

	var/datum/space_level/overmap_reserved_level
	var/reserved_z_level

/datum/controller/subsystem/overmap/proc/AddObjToProcess(datum/overmap_object/ovobj)
	objects_to_process += ovobj

/datum/controller/subsystem/overmap/proc/RemoveObjFromProcess(datum/overmap_object/ovobj)
	objects_to_process -= ovobj

/datum/controller/subsystem/overmap/proc/RegisterObject(datum/overmap_object/ovobj)
	next_unique_id++
	ovobj.id = next_unique_id
	id_object_lookup["[next_unique_id]"] = ovobj
	if(ovobj.overmap_process)
		AddObjToProcess(ovobj)

/datum/controller/subsystem/overmap/proc/UnregisterObject(datum/overmap_object/ovobj)
	if(ovobj.overmap_process)
		RemoveObjFromProcess(ovobj)
	id_object_lookup -= "[ovobj.id]"

/datum/controller/subsystem/overmap/proc/GetObjectByID(id)
	return id_object_lookup["[id]"]

/datum/controller/subsystem/overmap/Initialize()
	return ..()

/**
 * MappingInit() is called shortly after SSmapping starts initializing.
 *
 * It needs to be called there so mapping initializes all sorts of templates and other things that will be nessecary in here.
*/
/datum/controller/subsystem/overmap/proc/MappingInit()
	//Initialize our reserved level
	SSmapping.add_new_zlevel("Overmap Level", list(ZTRAIT_LINKAGE = UNAFFECTED))
	reserved_z_level = world.maxz
	overmap_reserved_level = SSmapping.z_list[reserved_z_level]
	//Initialize sun systems
	main_system = CreateNewSunSystem(new /datum/overmap_sun_system(overmap_reserved_level))
	//Seed some random objects in the main system
	//Seed some space trash here that will yield random loots
	//Seed some asteroids that will be mine'able

/**
 * CreateNewSunSystem() is called to create and register a new sunsystem
*/
/datum/controller/subsystem/overmap/proc/CreateNewSunSystem(datum/overmap_sun_system/new_sunsystem)
	if(length(sun_systems) >= 1)
		WARNING("Attempted to create more than 1 sun system. Currently not supported! Bother Azarak to implement that")
	sun_systems += new_sunsystem
	return new_sunsystem

/datum/controller/subsystem/overmap/fire(resumed = FALSE)
	for(var/i in objects_to_process)
		var/datum/overmap_object/ov_obj = i
		ov_obj.process()
