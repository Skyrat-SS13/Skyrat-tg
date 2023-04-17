/**
 * Physics subsystem
 *
 * This subsystem is responsible for processing any and all physics components.
 *
 * For this to be any fun it must be accurate, thus we fire every tick(or as close to it as possible)
 */

PROCESSING_SUBSYSTEM_DEF(physics)
	name = "Physics"
	priority = FIRE_PRIORITY_PHYSICS
	wait = 0.1 SECONDS
