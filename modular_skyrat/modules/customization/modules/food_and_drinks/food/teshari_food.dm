/obj/item/food/piru_dough
	name = "piru dough"
	desc = "A coarse, stretchy dough made from piru flour and muli juice, acting as the basis for most teshari cuisine. Puffs up dramatically when grilled."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "piru_dough"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("minty dough" = 1)
	foodtypes = VEGETABLES

/obj/item/food/piru_dough/MakeProcessable()
	AddElement(/datum/element/processable, TOOL_ROLLINGPIN, /obj/item/food/flat_piru_dough, 1, 3 SECONDS, table_required = TRUE)

/obj/item/food/piru_dough/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/piru_loaf, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/piru_loaf
	name = "piru loaf"
	desc = "A loaf of piru bread in a striking dark purple color, ready to be cut into slices. It's surprisingly stretchy, and smells quite minty."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "piru_loaf"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("minty, stretchy bread" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	burns_on_grill = TRUE

/obj/item/food/piru_loaf/MakeProcessable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/breadslice/piru, 4, 3 SECONDS, table_required = TRUE)

/obj/item/food/breadslice/piru
	name = "piru bread slice"
	desc = "A slice of stretchy piru bread."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "piru_bread_slice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("minty, stretchy bread" = 1)
	foodtypes = VEGETABLES

/obj/item/food/flat_piru_dough
	name = "flattened piru dough"
	desc = "Flattened piru dough, can be cooked on a griddle or sliced into pasta."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "flat_piru_dough"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("minty dough" = 1)
	foodtypes = VEGETABLES

/obj/item/food/flat_piru_dough/MakeProcessable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/piru_pasta, 3, 3 SECONDS, table_required = TRUE)

/obj/item/food/flat_piru_dough/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/grilled_piru_flatbread, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/grilled_piru_flatbread
	name = "grilled piru flatbread"
	desc = "Crispy, grilled piru flatbread. No longer as stretchy, but it smells absolutely amazing."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "grilled_piru_flatbread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("minty bread" = 1)
	foodtypes = VEGETABLES
	burns_on_grill = TRUE

/obj/item/food/piru_pasta
	name = "piru pasta"
	desc = "Thick-cut segments of piru dough formed into chewy pasta."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "piru_pasta"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("minty pasta" = 1)
	foodtypes = VEGETABLES

/obj/item/food/baked_kiri
	name = "baked kiri fruit"
	desc = "A kiri fruit baked in an oven, causing the jelly inside to caramelize into a crispy treat. Try not to get addicted."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "baked_kiri"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/kiri_jelly = 6)
	burns_in_oven = TRUE
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("crispy kiri fruit" = 1, "caramelized jelly" = 1)
	foodtypes = FRUIT | SUGAR

/obj/item/food/baked_muli
	name = "baked muli pod"
	desc = "A muli pod baked in an oven, causing the minty liquid inside to condense and the exterior to soften, giving the vegetable a hard-boiled egg consistency. Remarkably tasty and healthy!"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "baked_muli"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 4, /datum/reagent/consumable/muli_juice = 4)
	burns_in_oven = TRUE
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("chewy, savory muli pod" = 1, "mintyness" = 1)
	foodtypes = VEGETABLES

/obj/item/food/spiced_jerky
	name = "spiced jerky"
	desc = "A segment of meat seasoned with nakati spice and dehydrated. Makes for a tasty, chewy snack."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "spiced_jerky"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/protein = 6)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("tough, spicy jerky" = 1)
	foodtypes = MEAT

/obj/item/food/sirisai_wrap
	name = "sirisai wrap"
	desc = "Meat and cabbage seasoned with nakati spice and wrapped tightly in flattened piru bread. Simple, light, delicious."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "sirisai_wrap"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/nutriment/vitamin = 6)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("cabbage" = 1, "spiced meat" = 1, "piru bread" = 1)
	foodtypes = MEAT | VEGETABLES

/obj/item/food/sweet_piru_noodles
	name = "sweet piru noodles"
	desc = "Piru pasta mixed in a bowl with chopped kiri fruit, muli pods, and carrots. It looks bizarre and seems kind of slimy, but the taste cannot be denied."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "sweet_piru_noodles"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/kiri_jelly = 4, /datum/reagent/consumable/muli_juice = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("piru noodles" = 1, "minty muli juice" = 1, "sugary kiri jelly" = 1, "carrots" = 1)
	foodtypes = VEGETABLES | FRUIT | SUGAR

/obj/item/food/kiri_curry
	name = "kiri curry"
	desc = "Spiced meat mixed with finely sliced piru pasta and minced chili all drizzled in piru jelly sauce, just the perfect balance of spicy and sweet."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "kiri_curry"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/protein = 4, /datum/reagent/consumable/kiri_jelly = 6, /datum/reagent/consumable/nutriment/vitamin = 4)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("heavily seasoned meat" = 1, "sweetened noodles" = 1, "chilis" = 1)
	foodtypes = VEGETABLES | FRUIT | SUGAR | MEAT

/obj/item/food/sirisai_flatbread
	name = "sirisai flatbread"
	desc = "Piru flatbread grilled until crispy and topped with meat, chopped muli pods, and tomato sauce. Looks similar to a pizza, but way more purple and blue. Can be sliced!"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "sirisai_flatbread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 24, /datum/reagent/consumable/nutriment/protein = 16, /datum/reagent/consumable/muli_juice = 12, /datum/reagent/consumable/nutriment/vitamin = 16)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("crispy flatbread" = 1, "minty muli juice" = 1, "tomato sauce" = 1, "nakati spice" = 1)
	foodtypes = VEGETABLES | MEAT

/obj/item/food/sirisai_flatbread/MakeProcessable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/sirisai_flatbread_slice, 4, 3 SECONDS, table_required = TRUE)

/obj/item/food/sirisai_flatbread_slice
	name = "sirisai flatbread slice"
	desc = "A slice of piru flatbread grilled until crispy and topped with meat, chopped muli pods, and tomato sauce. Looks similar to a pizza, but way more purple and blue."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "sirisai_flatbread_slice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/protein = 4, /datum/reagent/consumable/muli_juice = 3, /datum/reagent/consumable/nutriment/vitamin = 4)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("crispy flatbread" = 1, "minty muli juice" = 1, "tomato sauce" = 1, "nakati spice" = 1)
	foodtypes = VEGETABLES | MEAT

/obj/item/food/bluefeather_crisp
	name = "bluefeather crisp"
	desc = "A spiced cracker made of flattened, dried piru bread. The name comes from the blue stain often left on feathers when eaten with muli dip."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "bluefeather_crisp"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("chewy, crispy cracker" = 1, "nakati spice" = 1)
	foodtypes = VEGETABLES

/obj/item/food/bluefeather_crisps_and_dip
	name = "bluefeather crisps and dip"
	desc = "Bluefeather crisp crackers, now with dip made of muli juice and tomatoes. The name comes from the blue stain often left on feathers when dripped onto them."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "bluefeather_crisps_and_dip"
	food_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/consumable/muli_juice = 8, /datum/reagent/consumable/nutriment/vitamin = 6)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("chewy, crispy crackers" = 1, "nakati spice" = 1, "zesty muli juice dip" = 1)
	foodtypes = VEGETABLES

/obj/item/food/stewed_muli
	name = "stewed muli"
	desc = "A simple stew of meat, carrots and cabbage all cooked in muli juice. For the growing teshari."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "stewed_muli"
	food_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/protein = 8, /datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/consumable/muli_juice = 6)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("hearty meat" = 1, "carrots" = 1, "cabbage" = 1, "muli juice broth" = 1)
	foodtypes = VEGETABLES | MEAT

/obj/item/food/stuffed_muli_pod
	name = "stuffed mulu pod"
	desc = "A cooked muli pod, now stuffed with meat, minced kiri fruit, and chili. Chewy sweet and spicy all in one!"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "stuffed_muli_pod"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/protein = 4, /datum/reagent/consumable/nutriment/vitamin = 4, /datum/reagent/consumable/muli_juice = 4)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("spiced meat" = 1, "minty muli pod" = 1, "super-sweet kiri fruit" = 1, "chili" = 1)
	foodtypes = VEGETABLES | FRUIT | MEAT | SUGAR

/obj/item/food/caramel_jelly_toast
	name = "caramel jelly toast"
	desc = "A toasted slice of piru bread with a generous slathering of thick caramel and kiri jelly. Is this supposed to be breakfast or desert?"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "caramel_jelly_toast"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 6)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("piru bread" = 1, "caramel" = 1, "super-sweet kiri jelly" = 1)
	foodtypes = VEGETABLES | FRUIT | SUGAR

/obj/item/food/kiri_jellypuff
	name = "kiri jellypuff"
	desc = "A piece of piru bread puffed and rolled into a thick disk, containing a kiri jelly and cream filling and sprinkled with piru flour. Just one will never be enough."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "kiri_jellypuff"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/consumable/kiri_jelly = 4)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("puffed piru bread" = 1, "cream" = 1, "super-sweet kiri jelly" = 1)
	foodtypes = VEGETABLES | FRUIT | SUGAR
