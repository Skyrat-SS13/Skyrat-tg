/datum/delivery_run/mineral_delivery
	name = "Mineral Delivery"
	desc = "We've got some minerals that need to be delivered."
	possible_cargo_names = list("stacks of plasma", "stacks of uranium", "stacks of diamonds", "stacks of titanium")
	reward_cash = 2000

/datum/delivery_run/industrial_equipment_delivery
	name = "Industrial Equipment Delivery"
	desc = "We've got a large package of some industrial equipment that needs to be delivered."
	cargo_type = /obj/item/delivery_cargo/bulky
	possible_cargo_names = list("mining drill", "100 crates of self-sealing stem bolts", "mech")
	reward_cash = 2000

/datum/delivery_run/medical_supplies_delivery
	name = "Medical Supplies Delivery"
	desc = "I hope my customers didn't bleed out because I totally forgotten about this."
	possible_cargo_names = list("medical supplies")
	reward_cash = 2000

/datum/delivery_run/delicate_biological_matter
	name = "Delicate Biological Matter"
	desc = "I've got very.. delicate.. and uh.. well to put in words 'dangerous' cargo. Best not to spill it."
	cargo_type = /obj/item/delivery_cargo/tiny
	possible_cargo_names = list("deadly virus", "dangerous chemicals")
	reward_cash = 4000

/datum/delivery_run/food_delivery
	name = "Food Delivery"
	desc = "We've got some food that needs to be delivered! Before it goes cold hopefully."
	possible_cargo_names = list("food")
	reward_cash = 1000

/datum/delivery_run/food_delivery/pizza
	possible_cargo_names = list("mushroom pizza", "havaian pizza", "meat pizza", "vegetable pizza", "cheese pizza")

/datum/delivery_run/food_delivery/chinese
	possible_cargo_names = list("ramen", "sushi", "fried rice", "kung pao chicken")

/datum/delivery_run/artifact_delivery
	name = "Artifact Delivery"
	desc = "I have precious gift for a dear friend of mine, but I need someone to help me deliver it."
	cargo_type = /obj/item/delivery_cargo/small
	possible_cargo_names = list("a collection of fossils", "ancient artifact", "shining crystals")
	possible_recipients = list("dear friend")
	reward_cash = 2000
