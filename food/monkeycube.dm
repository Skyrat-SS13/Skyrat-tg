/obj/item/food/monkeycube
	name = "猴子方块"
	desc = "只需加水!"
	icon_state = "monkeycube"
	bite_consumption = 12
	food_reagents = list(/datum/reagent/monkey_powder = 30)
	tastes = list("丛林" = 1, "香蕉" = 1)
	foodtypes = MEAT | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	/// Mob typepath to spawn when expanding  Expanding时生成的怪物类型路径
	var/spawned_mob = /mob/living/carbon/human/species/monkey
	/// Whether we've been wetted and are expanding 我们是否被淋湿了，是否在expanding
	var/expanding = FALSE

/obj/item/food/monkeycube/attempt_pickup(mob/user)
	if(expanding)
		return FALSE
	return ..()

/obj/item/food/monkeycube/proc/Expand()
	if(expanding)
		return

	expanding = TRUE

	if(ismob(loc))
		var/mob/holder = loc
		holder.dropItemToGround(src)

	var/mob/spammer = get_mob_by_key(fingerprintslast)
	var/mob/living/bananas = new spawned_mob(drop_location(), TRUE, spammer) // funny that we pass monkey init args to non-monkey mobs, that's totally a future issue 有趣的是，我们将猴子init参数传递给非猴子的mob，这完全是未来的问题
	if (!QDELETED(bananas))
		if(faction)
			bananas.faction = faction

		visible_message(span_notice("[src] 膨胀了!"))
		bananas.log_message("通过 [src] 生成, 最终成为了: [key_name(spammer)].", LOG_ATTACK)

		var/alpha_to = bananas.alpha
		var/matrix/scale_to = matrix(bananas.transform)
		bananas.alpha = 0
		bananas.transform = bananas.transform.Scale(0.1)
		animate(bananas, 0.5 SECONDS, alpha = alpha_to, transform = scale_to, easing = QUAD_EASING|EASE_OUT)

	else if (!spammer) // Visible message in case there are no fingerprints
		visible_message(span_notice("[src] 膨胀失败了!"))
		return

	animate(src, 0.4 SECONDS, alpha = 0, transform = transform.Scale(0), easing = QUAD_EASING|EASE_IN)
	QDEL_IN(src, 0.5 SECONDS)

/obj/item/food/monkeycube/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 将 [src] 放进嘴里! 这看起来是在尝试自杀!"))
	var/eating_success = do_after(user, 1 SECONDS, src)
	if(QDELETED(user)) //qdeletion: the nuclear option of self-harm
		return SHAME
	if(!eating_success || QDELETED(src)) //checks if src is gone or if they failed to wait for a second
		user.visible_message(span_suicide("[user] 退缩了!"))
		return SHAME
	if(HAS_TRAIT(user, TRAIT_NOHUNGER)) //plasmamen don't have saliva/stomach acid 等离子人没有水
		user.visible_message(span_suicide("[user] 意识到自己的身体不会激活 [src]!")
		,span_warning("你的身体不会激活 [src]..."))
		return SHAME
	playsound(user, 'sound/items/eatfood.ogg', rand(10, 50), TRUE)
	user.temporarilyRemoveItemFromInventory(src) //removes from hands, keeps in M
	addtimer(CALLBACK(src, PROC_REF(finish_suicide), user), 15) //you've eaten it, you can run now
	return MANUAL_SUICIDE

/obj/item/food/monkeycube/proc/finish_suicide(mob/living/user) ///internal proc called by a monkeycube's suicide_act using a timer and callback. takes as argument the mob/living who activated the suicide
	if(QDELETED(user) || QDELETED(src))
		return
	if(src.loc != user) //how the hell did you manage this
		to_chat(user, span_warning("有什么事情发生在 [src] 上..."))
		return
	Expand()
	user.visible_message(span_danger("[user]的身体突然爆开，一只灵长类动物出现了!"))
	user.gib(DROP_BRAIN|DROP_BODYPARTS|DROP_ITEMS) // just remove the organs

/obj/item/food/monkeycube/syndicate
	faction = list(FACTION_NEUTRAL, ROLE_SYNDICATE)

/obj/item/food/monkeycube/gorilla
	name = "大猩猩方块"
	desc = "Waffle.co的大猩猩方块。现在有了额外的分子微粒!"
	bite_consumption = 20
	food_reagents = list(
		/datum/reagent/monkey_powder = 30,
		/datum/reagent/medicine/strange_reagent = 5,
	)
	tastes = list("丛林" = 1, "香蕉" = 1, "暴力" = 1)
	spawned_mob = /mob/living/basic/gorilla

/obj/item/food/monkeycube/chicken
	name = "鸡方块"
	desc = "Nanotrasen的新经典,鸡块。什么味道都有!"
	bite_consumption = 20
	food_reagents = list(
		/datum/reagent/consumable/eggyolk = 30,
		/datum/reagent/medicine/strange_reagent = 1,
	)
	tastes = list("鸡" = 1, "乡村" = 1, "鸡精" = 1)
	spawned_mob = /mob/living/basic/chicken

/obj/item/food/monkeycube/bee
	name = "蜜蜂方块"
	desc = "我们确信这是个好主意,只需加水."
	bite_consumption = 20
	food_reagents = list(
		/datum/reagent/consumable/honey = 10,
		/datum/reagent/toxin = 5,
		/datum/reagent/medicine/strange_reagent = 1,
	)
	tastes = list("嗡嗡声" = 1, "蜂蜜" = 1, "后悔" = 1)
	spawned_mob = /mob/living/basic/bee
