/obj/structure/wargame_hologram
	name = "broken holographic wargame marker"
	icon = 'modular_skyrat/modules/wargame_projectors/icons/projectors_and_holograms.dmi'
	icon_state = "broke"
	anchored = TRUE
	max_integrity = 1
	/// What object created this projection? Can be null as a projector isn't required for this to exist
	var/obj/item/wargame_projector/projector

/obj/structure/wargame_hologram/Initialize(mapload, source_projector)
	. = ..()
	if(source_projector)
		projector = source_projector
		LAZYADD(projector.projections, src)

/obj/structure/wargame_hologram/Destroy()
	if(projector)
		LAZYREMOVE(projector.projections, src)
		projector = null
	return ..()
