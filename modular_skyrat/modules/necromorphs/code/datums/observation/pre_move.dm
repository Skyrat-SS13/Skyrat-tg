//	Observer Pattern Implementation: Pre Move
//		Registration type: /atom/movable
//
//		Raised when: An /atom/movable instance is just about to move
//
//		Arguments that the called proc should expect:
//			/atom/movable/moving_instance: The instance that pre_move
//			/atom/old_loc: The current location.
//			/atom/new_loc: The location. we're attempting to move into.

GLOBAL_DATUM_INIT(pre_move_event, /decl/observ/pre_move, new)

/decl/observ/pre_move
	name = "Pre Move"
	expected_type = /atom/movable



//The overrides for this are in moved.dm to condense and save performance
