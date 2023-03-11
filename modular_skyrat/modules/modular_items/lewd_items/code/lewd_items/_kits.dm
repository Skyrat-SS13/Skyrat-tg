
// Milking machine
/obj/item/storage/box/milking_kit
	name = "DIY milking machine kit"
	desc = "Contains everything you need to build your own milking machine!"

/obj/item/storage/box/milking_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/milking_machine/constructionkit = 1)
	generate_items_inside(items_inside, src)

// X-Stand
/obj/item/storage/box/xstand_kit
	name = "DIY x-stand kit"
	desc = "Contains everything you need to build your own X-stand!"

/obj/item/storage/box/xstand_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/x_stand_kit = 1)
	generate_items_inside(items_inside, src)

// BDSM bed
/obj/item/storage/box/bdsmbed_kit
	name = "DIY BDSM bed kit"
	desc = "Contains everything you need to build your own BDSM bed!"

/obj/item/storage/box/bdsmbed_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/bdsm_bed_kit = 1)
	generate_items_inside(items_inside, src)

// Striptease pole
/obj/item/storage/box/strippole_kit
	name = "DIY stripper pole kit"
	desc = "Contains everything you need to build your own stripper pole!"

/obj/item/storage/box/strippole_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/polepack = 1)
	generate_items_inside(items_inside, src)

// Shibari stand
/obj/item/storage/box/shibari_stand
	name = "DIY shibari stand kit"
	desc = "Contains everything you need to build your own shibari stand!"

/obj/item/storage/box/shibari_stand/PopulateContents()
	var/static/items_inside = list(
		/obj/item/shibari_stand_kit = 1,
		/obj/item/paper/shibari_kit_instructions = 1)
	generate_items_inside(items_inside, src)

// Paper instructions for shibari kit

/obj/item/paper/shibari_kit_instructions
	default_raw_text = "Hello! Congratulations on your purchase of the shibari kit by LustWish! Some newbies may get confused by our ropes, so we prepared a small instructions for you! First of all, you have to have a wrench to construct the stand itself. Secondly, you can use screwdrivers to change the color of your shibari stand. Just replace the plastic fittings! Thirdly, if you want to tie somebody to a bondage stand you need to fully tie their body, on both groin and chest!. To do that you need to use rope on body and then on groin of character, then you can just buckle them to the stand like any chair. Don't forget to have some ropes on your hand to actually tie them to the stand, as there's no ropes included with it! And that's it!"
