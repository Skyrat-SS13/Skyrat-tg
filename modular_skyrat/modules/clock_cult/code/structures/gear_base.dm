/obj/structure/destructible/clockwork/gear_base
	name = "gear base"
	desc = "A large cog lying on the floor at feet level."
	icon_state = "gear_base"
	clockwork_desc = "A large cog lying on the floor at feet level."
	anchored = FALSE
	break_message = span_warning("Oh, that broke. I guess you could report it to the coders, or just you know ignore this message and get on with killing those god damn heretics coming to break the Ark.")
	/// What's appeneded to the structure when unanchored
	var/unwrenched_suffix = "_unwrenched"


/obj/structure/destructible/clockwork/gear_base/wrench_act(mob/living/user, obj/item/tool)
	if(!IS_CLOCK(user))
		return

	balloon_alert(user, "[anchored ? "unwrenching" : "wrenching"]...")

	if(!tool.use_tool(src, user, 2 SECONDS, volume = 50))
		return

	visible_message("[user] [anchored ? "unwrench" : "wrench"] [src].", "You [anchored ? "unwrench" : "wrench"] [src].")

	anchored = !anchored
	update_icon_state()

	return TRUE


/obj/structure/destructible/clockwork/gear_base/update_icon_state()
	. = ..()
	icon_state = initial(icon_state)

	if(!anchored)
		icon_state += unwrenched_suffix
