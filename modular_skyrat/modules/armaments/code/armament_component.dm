/**
 * This is the componentised version of the armaments vendor.
 *
 * It's intended to be used with NPC vendors, or atoms that otherwise aren't vending machines.
 */

/datum/component/armament
	/// The types of armament datums we wish to add to this component.
	var/list/products
	/// What access do we require to use this machine?
	var/list/required_access
	/// Our parent machine.
	var/atom/parent_atom

/datum/component/armament/Initialize(list/required_products, list/required_access)
	if(!required_products)
		stack_trace("No products specified for armament")
		return COMPONENT_INCOMPATIBLE

	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	parent_atom = parent

	products = required_products


	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, .proc/on_attack_hand)


/datum/component/armament/proc/on_attack_hand(datum/source, mob/living/user)
	SIGNAL_HANDLER

	if(!user)
		return

	if(!user.can_interact_with(parent_atom))
		return

	INVOKE_ASYNC(src, .proc/ui_interact, user)

/datum/component/armament/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ArmamentStation")
		ui.open()



