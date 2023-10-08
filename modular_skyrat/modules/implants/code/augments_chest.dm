// for readability's sake, define here to match the healthscan() proc's use of it
// if someone updates that upstream, fix that here too, wouldja?
#define SCANNER_VERBOSE 1

/obj/item/organ/internal/cyberimp/chest/scanner
	name = "internal health analyzer"
	desc = "An advanced health analyzer implant, designed to directly interface with a host's body and relay scan information to the brain on command."
	slot = ORGAN_SLOT_SCANNER
	icon = 'modular_skyrat/modules/implants/icons/internal_HA.dmi'
	icon_state = "internal_HA"
	implant_overlay = null
	implant_color = null
	actions_types = list(/datum/action/item_action/organ_action/use/internal_analyzer)
	w_class = WEIGHT_CLASS_SMALL

/datum/action/item_action/organ_action/use/internal_analyzer
	desc = "LMB: Health scan. RMB: Chemical scan. Requires implanted analyzer to not be failing due to EMPs or other causes. Does not provide treatment assistance."

/datum/action/item_action/organ_action/use/internal_analyzer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/internal/cyberimp/chest/scanner/our_scanner = target
	if(our_scanner.organ_flags & ORGAN_FAILING)
		to_chat(owner, span_warning("Your health analyzer relays an error! It can't interface with your body in its current condition!"))
		return
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		chemscan(owner, owner)
	else
		healthscan(owner, owner, SCANNER_VERBOSE, TRUE)

#undef SCANNER_VERBOSE
