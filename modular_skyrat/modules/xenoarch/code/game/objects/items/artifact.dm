/obj/item/ancientartifact
	name = "parent artifact"
	desc = "You shouldn't have this."
	icon = 'modular_skyrat/modules/xenoarch/icons/obj/artifacts.dmi'

/obj/item/ancientartifact/useless
	name = "useless artifact"
	desc = "This artifact is nonfunctional... perhaps it can be researched or sold."

/obj/item/ancientartifact/useless/Initialize()
	icon_state = pick(list("urn","statuette","instrument","unknown1","unknown2","unknown3"))
	..()

/obj/item/ancientartifact/fossil
	name = "parent fossil"
	desc = "You shouldn't have this."

/obj/item/ancientartifact/fossil/fauna
	name = "fauna fossil"
	desc = "This is a fossil of an animal... seems dead."

/obj/item/ancientartifact/fossil/fauna/Initialize()
	icon_state = pick(list("bone1","bone2","bone3","bone4","bone5","bone6"))
	..()

/obj/item/ancientartifact/fossil/flora
	name = "flora fossil"
	desc = "This is a fossil of a plant... seems dead."

/obj/item/ancientartifact/fossil/flora/Initialize()
	icon_state = pick(list("plant1","plant2","plant3","plant4","plant5","plant6"))
	..()
