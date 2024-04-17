/// The subsystem used to tick [/datum/ai_controllers] instances. Handling the re-checking of plans.
SUBSYSTEM_DEF(ai_controllers)
	name = "AI Controller Ticker"
	flags = SS_POST_FIRE_TIMING|SS_BACKGROUND
	priority = FIRE_PRIORITY_NPC
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	init_order = INIT_ORDER_AI_CONTROLLERS
	wait = 0.5 SECONDS //Plan every half second if required, not great not terrible.

	///List of all ai_subtree singletons, key is the typepath while assigned value is a newly created instance of the typepath. See setup_subtrees()
	var/list/ai_subtrees = list()
	///List of all ai controllers currently running
	var/list/active_ai_controllers = list()

/datum/controller/subsystem/ai_controllers/Initialize()
	setup_subtrees()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/ai_controllers/proc/setup_subtrees()
	ai_subtrees = list()
	for(var/subtree_type in subtypesof(/datum/ai_planning_subtree))
		var/datum/ai_planning_subtree/subtree = new subtree_type
		ai_subtrees[subtree_type] = subtree

/datum/controller/subsystem/ai_controllers/fire(resumed)
<<<<<<< HEAD
	for(var/datum/ai_controller/ai_controller as anything in active_ai_controllers)
=======
	var/timer = TICK_USAGE_REAL
	cost_idle = MC_AVERAGE(cost_idle, TICK_DELTA_TO_MS(TICK_USAGE_REAL - timer))

	timer = TICK_USAGE_REAL
	for(var/datum/ai_controller/ai_controller as anything in ai_controllers_by_status[AI_STATUS_ON])
>>>>>>> f01035fb27c (ai controllers use cell trackers to know when to idle (#82691))
		if(!COOLDOWN_FINISHED(ai_controller, failed_planning_cooldown))
			continue

		if(!ai_controller.able_to_plan())
			continue
		ai_controller.SelectBehaviors(wait * 0.1)
		if(!LAZYLEN(ai_controller.current_behaviors)) //Still no plan
			COOLDOWN_START(ai_controller, failed_planning_cooldown, AI_FAILED_PLANNING_COOLDOWN)
<<<<<<< HEAD
=======

	cost_on = MC_AVERAGE(cost_on, TICK_DELTA_TO_MS(TICK_USAGE_REAL - timer))

///Creates all instances of ai_subtrees and assigns them to the ai_subtrees list.
/datum/controller/subsystem/ai_controllers/proc/setup_subtrees()
	for(var/subtree_type in subtypesof(/datum/ai_planning_subtree))
		var/datum/ai_planning_subtree/subtree = new subtree_type
		ai_subtrees[subtree_type] = subtree

///Called when the max Z level was changed, updating our coverage.
/datum/controller/subsystem/ai_controllers/proc/on_max_z_changed()
	if (!islist(ai_controllers_by_zlevel))
		ai_controllers_by_zlevel = new /list(world.maxz,0)
	while (SSai_controllers.ai_controllers_by_zlevel.len < world.maxz)
		SSai_controllers.ai_controllers_by_zlevel.len++
		SSai_controllers.ai_controllers_by_zlevel[ai_controllers_by_zlevel.len] = list()
>>>>>>> f01035fb27c (ai controllers use cell trackers to know when to idle (#82691))
