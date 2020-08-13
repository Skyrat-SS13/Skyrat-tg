//so, there is the var called sheettype. THere is an issue.
//metal doesnt have a sheet type? and I dont know the consequences for adding a sheet type to it.
//so, playing it safely, Im just doing this
/obj/item/stack/sheet
	var/oretypename = null

/obj/item/stack/sheet/metal
	oretypename = "iron"

/obj/item/stack/sheet/glass
	oretypename = "glass"

/obj/item/stack/sheet/mineral/silver
	oretypename = "silver"

/obj/item/stack/sheet/mineral/titanium
	oretypename = "titanium"

/obj/item/stack/sheet/mineral/plasma
	oretypename = "plasma"

/obj/item/stack/sheet/mineral/gold
	oretypename = "gold"

/obj/item/stack/sheet/mineral/uranium
	oretypename = "uranium"

/obj/item/stack/sheet/mineral/diamond
	oretypename = "diamond"

/obj/item/stack/sheet/bluespace_crystal
	oretypename = "bluespace"

/obj/item/stack/sheet/mineral/bananium
	oretypename = "bananium"

