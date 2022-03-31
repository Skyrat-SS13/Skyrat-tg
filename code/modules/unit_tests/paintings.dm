///Checks that all kind of painting frames have a sprite for each canvas type in the game.
/datum/unit_test/paintings

/datum/unit_test/paintings/Run()
<<<<<<< HEAD
	for(var/obj/item/canvas/canvas_prototype as anything in typesof(/obj/item/canvas))
		//SKYRAT EDIT START
		if(canvas_prototype == /obj/item/canvas/drawingtablet) //This doesn't need frames.
			continue
		//SKYRAT EDIT END
		var/canvas_icons = icon_states(initial(canvas_prototype.icon))
		var/canvas_icon_state = initial(canvas_prototype.icon_state)
=======
	for(var/obj/item/canvas/canvas as anything in typesof(/obj/item/canvas))
		canvas = new canvas
		var/canvas_icons = icon_states(canvas.icon)
>>>>>>> 3bc48ce5994 (Extra-large painting canvases: 36x24 and 45x27 (#65642))
		for(var/frame_type in SSpersistent_paintings.frame_types_by_patronage_tier)
			if(!("[canvas.icon_state]frame_[frame_type]" in canvas_icons))
				Fail("Canvas [canvas.icon_state] doesn't have an icon state for frame: [frame_type].")
