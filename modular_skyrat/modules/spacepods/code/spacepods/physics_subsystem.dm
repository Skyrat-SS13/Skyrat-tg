/**
 * Physics subsystem
 *
 * This subsystem is responsible for processing any and all physics components.
 */

PROCESSING_SUBSYSTEM_DEF(physics)
	name = "Physics"
	priority = FIRE_PRIORITY_PHYSICS
	wait = 0.2 SECONDS
