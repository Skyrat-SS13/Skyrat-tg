/obj/effect/mine/shrapnel/human_only
	name = "sophisticated shrapnel mine"
	desc = "A deadly mine, this one seems to be modified to trigger for humans only?"

/obj/effect/mine/shrapnel/human_only/Crossed(atom/movable/AM)
	if(!ishuman(AM))
		return
	. = ..()
