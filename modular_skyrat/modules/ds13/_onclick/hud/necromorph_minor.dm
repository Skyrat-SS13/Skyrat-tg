/*
	Hud used for small non humanoid necromorphs. Divider component, swarmer, maybe others
	Things that come in one piece and are much simpler codewise
*/

/mob/living/simple_animal/necromorph
	hud_type = /datum/hud/necromorph_minor

/datum/hud/necromorph_minor/FinalizeInstantiation(var/ui_style='icons/mob/screen1_White.dmi', var/ui_color = "#ffffff", var/ui_alpha = 255)

	var/list/hud_elements = list()

	mymob.fire = new /obj/screen()
	mymob.fire.icon = ui_style
	//mymob.fire.icon_state = "fire0"
	//mymob.fire.SetName("fire")
	//mymob.fire.screen_loc = ui_fire
	//hud_elements |= mymob.fire

	mymob.pain = mymob.overlay_fullscreen("pain", /obj/screen/fullscreen/pain, INFINITY)//new /obj/screen/fullscreen/pain( null )

	if (istype(mymob.pain))
		hud_elements |= mymob.pain


	hud_elements |= new /obj/screen/healthbar(mymob.client)

	mymob.zone_sel = new /obj/screen/zone_sel( null )
	mymob.zone_sel.icon = ui_style
	mymob.zone_sel.color = ui_color
	mymob.zone_sel.alpha = ui_alpha
	mymob.zone_sel.overlays.Cut()
	mymob.zone_sel.overlays += image('icons/mob/zone_sel.dmi', "[mymob.zone_sel.selecting]")
	hud_elements |= mymob.zone_sel

	mymob.pullin = new /obj/screen()
	mymob.pullin.icon = ui_style
	mymob.pullin.icon_state = "pull0"
	mymob.pullin.SetName("pull")
	mymob.pullin.screen_loc = ui_pull_resist
	src.hotkeybuttons += mymob.pullin
	hud_elements |= mymob.pullin


	mymob.client.screen = list()
	mymob.client.add_to_screen(hud_elements)
