#define MOB_LAYER_SHIFT_INCREMENT 1
/// The amount by which layers are multiplied before being modified.
/// Helps avoiding floating point errors.
#define MOB_LAYER_MULTIPLIER 100
#define MOB_LAYER_SHIFT_MIN 3.95
//#define MOB_LAYER 4   // This is a byond standard define
#define MOB_LAYER_SHIFT_MAX 4.05

/mob/living/verb/layershift_up()
	set name = "Shift Layer Upwards"
	set category = "IC"

	if(incapacitated())
		to_chat(src, span_warning("You can't do that right now!"))
		return

	if(layer >= MOB_LAYER_SHIFT_MAX)
		to_chat(src, span_warning("You cannot increase your layer priority any further."))
		return

	layer = min(((layer * MOB_LAYER_MULTIPLIER) + MOB_LAYER_SHIFT_INCREMENT) / MOB_LAYER_MULTIPLIER, MOB_LAYER_SHIFT_MAX)
	var/layer_priority = round(layer * MOB_LAYER_MULTIPLIER - MOB_LAYER * MOB_LAYER_MULTIPLIER, MOB_LAYER_SHIFT_INCREMENT) // Just for text feedback
	to_chat(src, span_notice("Your layer priority is now [layer_priority]."))

/mob/living/verb/layershift_down()
	set name = "Shift Layer Downwards"
	set category = "IC"

	if(incapacitated())
		to_chat(src, span_warning("You can't do that right now!"))
		return

	if(layer <= MOB_LAYER_SHIFT_MIN)
		to_chat(src, span_warning("You cannot decrease your layer priority any further."))
		return

	layer = max(((layer * MOB_LAYER_MULTIPLIER) - MOB_LAYER_SHIFT_INCREMENT) / MOB_LAYER_MULTIPLIER, MOB_LAYER_SHIFT_MIN)
	var/layer_priority = round(layer * MOB_LAYER_MULTIPLIER - MOB_LAYER * MOB_LAYER_MULTIPLIER, MOB_LAYER_SHIFT_INCREMENT) // Just for text feedback
	to_chat(src, span_notice("Your layer priority is now [layer_priority]."))
