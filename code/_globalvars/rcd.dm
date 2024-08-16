GLOBAL_VAR_INIT(icon_holographic_wall, init_holographic_wall())
GLOBAL_VAR_INIT(icon_holographic_window, init_holographic_window())

/proc/init_holographic_wall()
	return icon('icons/turf/walls/wall.dmi', "wall-0")

/proc/init_holographic_window()
<<<<<<< HEAD
	var/icon/grille_icon = icon('icons/obj/structures.dmi', "grille")
	var/icon/window_icon = icon('icons/obj/smooth_structures/window.dmi', "window-0")

	grille_icon.Blend(window_icon, ICON_OVERLAY)

	return grille_icon
=======
	var/mutable_appearance/window_frame = mutable_appearance('icons/obj/structures/smooth/window_frames/window_frame_normal.dmi', "window_frame_normal-0")
	var/mutable_appearance/window = mutable_appearance('icons/obj/structures/smooth/windows/normal_window.dmi', "0-lower")
	var/mutable_appearance/window_frill = mutable_appearance('icons/obj/structures/smooth/windows/normal_window.dmi', "0-upper")
	window_frill.pixel_z = 32
	window_frame.add_overlay(list(window, window_frill))
	return window_frame
>>>>>>> fec946e9c007 (/Icon/ Folder cleansing crusade part, I think 4; post-wallening clean-up. (#85823))
