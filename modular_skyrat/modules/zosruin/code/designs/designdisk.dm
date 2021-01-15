/obj/item/disk/design_disk/adv/vxbmag
	name = "V-X Magazine Research Disk"

/obj/item/disk/design_disk/adv/vxbmag/Initialize()
	. = ..()
	var/datum/design/vxbmag/M = new
	blueprints[1] = M
