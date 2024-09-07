///Checks that all kind of painting frames have a sprite for each canvas type in the game.
/datum/unit_test/paintings

/datum/unit_test/paintings/Run()
	for(var/obj/item/canvas/canvas as anything in typesof(/obj/item/canvas))
<<<<<<< HEAD
		//SKYRAT EDIT START
		if(canvas == /obj/item/canvas/drawingtablet) //This doesn't need frames.
			continue
		//SKYRAT EDIT END
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
		canvas = new canvas
		var/canvas_icons = icon_states(canvas.icon)
		for(var/frame_type in SSpersistent_paintings.frame_types_by_patronage_tier)
			if(!("[canvas.icon_state]frame_[frame_type]" in canvas_icons))
				TEST_FAIL("Canvas [canvas.icon_state] doesn't have an icon state for frame: [frame_type].")
