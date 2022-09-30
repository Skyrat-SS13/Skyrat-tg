/atom/movable/screen/plane_master/mouse_transparent
	name = "mouse transparent plane master"
	plane = RENDER_PLANE_GAME_WORLD
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_planes = list(RENDER_PLANE_GAME)
