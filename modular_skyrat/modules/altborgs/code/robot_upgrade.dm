/obj/item/borg/upgrade/transform/syndicatejack
    name = "borg module picker (Syndicate)"
    desc = "Allows you to to turn a cyborg into a experimental syndicate cyborg."
    icon_state = "cyborg_upgrade3"
    new_model = /obj/item/robot_model/syndicatejack

/obj/item/borg/upgrade/transform/syndicatejack/action(mob/living/silicon/robot/R, user = usr) //Only useable on Emagged Cyborg, In exchange. make you unable to get locked down or detonated
    if(R.emagged)
        return ..()
