// Make sure that glasses are layered underneath the mask when the same alternate_worn_layers are being used for both items
// example: snouted mobs wearing glass gas masks, which use ABOVE_BODY_FRONT_HEAD_LAYER to draw both masks and glasses over the snout
/mob/living/carbon/human/update_worn_glasses()
	. = ..()

	if(!glasses || !glasses.alternate_worn_layer)
		return

	if(!wear_mask || !wear_mask.alternate_worn_layer || wear_mask.flags_inv & HIDEEYES) // we only need to do this if the glasses are visible through the mask
		return

	if(glasses.alternate_worn_layer == wear_mask.alternate_worn_layer) // we only need to do this if the glasses are on the same level as the mask. otherwise, assume them being layered over is intentional
		update_worn_mask()			
