/datum/component/two_hand_reach
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS // Only one of the component can exist on an item
	/// the reach of the item before being two-handed
	var/unwielded_reach = 1
	/// the reach of the item after being two-handed
	var/wielded_reach = 2

/datum/component/two_hand_reach/Initialize(unwield_reach = 1, wield_reach = 1)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	src.unwielded_reach = unwield_reach
	src.wielded_reach = wield_reach

/datum/component/two_hand_reach/InheritComponent(datum/component/new_comp, original, unwield_reach, wield_reach)
	if(!original)
		return
	if(unwield_reach)
		src.unwielded_reach = unwield_reach
	if(wield_reach)
		src.wielded_reach = wielded_reach

/datum/component/two_hand_reach/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(unwield))
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(unwield))
	RegisterSignal(parent, COMSIG_TWOHANDED_UNWIELD, PROC_REF(unwield))
	RegisterSignal(parent, COMSIG_TWOHANDED_WIELD, PROC_REF(wield))

/datum/component/two_hand_reach/proc/unwield()
	var/obj/item/item_parent = parent
	item_parent.reach = unwielded_reach

/datum/component/two_hand_reach/proc/wield()
	var/obj/item/item_parent = parent
	item_parent.reach = wielded_reach
