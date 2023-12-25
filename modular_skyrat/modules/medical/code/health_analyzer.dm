/// If TRUE, this analyzer can be used for medibot construction. If FALSE, it cannot. Returns TRUE by default.
/obj/item/healthanalyzer/proc/can_be_used_in_medibot()
	return TRUE

/obj/item/healthanalyzer/no_medibot
	name = "surplus health analyzer"
	desc = "A hand-held body scanner capable of distinguishing vital signs of the subject. Has a side button to scan for chemicals, and can be toggled to scan wounds. \
	This one seems to lack the mounting braces usually found on medibot-compatable analyzers..."

/obj/item/healthanalyzer/no_medibot/can_be_used_in_medibot()
	return FALSE
