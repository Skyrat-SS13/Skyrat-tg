/*
	Hud used for small non humanoid necromorphs. Divider component, swarmer, maybe others
	Things that come in one piece and are much simpler codewise
*/

/mob/living/simple_animal/necromorph
	hud_type = /datum/hud/necromorph_minor

/datum/hud/necromorph_minor/New(mob/owner)
	..()

	fire = new /atom/movable/screen()
	fire.icon = ui_style
	fire.icon_state = "fire0"
	fire.SetName("fire")
	fire.screen_loc = ui_fire
	infodisplay += fire

	hud_healthbar = new /atom/movable/screen/meter/health(owner, src)
	infodisplay += hud_healthbar

	zone_sel = new /atom/movable/screen/zone_sel( null )
	zone_sel.icon = ui_style
	zone_sel.color = ui_color
	zone_sel.alpha = ui_alpha
	zone_sel.overlays.Cut()
	zone_sel.overlays += image('icons/hud/zone_sel.dmi', "[zone_sel.selecting]")
	infodisplay += zone_sel

	pullin = new /atom/movable/screen()
	pullin.icon = ui_style
	pullin.icon_state = "pull0"
	pullin.SetName("pull")
	pullin.screen_loc = ui_pull_resist
	src.hotkeybuttons += pullin
	static_inventory += pullin
