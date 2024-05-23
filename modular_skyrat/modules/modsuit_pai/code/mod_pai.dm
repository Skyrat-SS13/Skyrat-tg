/**
 * Misc stuff to avoid having files with three lines in them.
 */
/obj/item/mod/control
	/// Whether or not an on-board pAI can move the suit. FALSE by default, intended to be modified either via VV or via a possible future pAI program.
	var/can_pai_move_suit = FALSE
	/// Whether or not this MODsuit can hold AIs, or if it's restricted to just pAIs.
	var/allow_ai = FALSE
