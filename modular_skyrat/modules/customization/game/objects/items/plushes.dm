// MODULAR PLUSHES

/obj/item/toy/plush/borbplushie
	name = "borb plushie"
	desc = "An adorable stuffed toy that resembles a round, fluffy looking bird. Not to be mistaken for his friend, the birb plushie."
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_borb"
	inhand_icon_state = "plushie_borb"
	attack_verb_continuous = list("pecks", "peeps")
	attack_verb_simple = list("peck", "peep")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/peep_once.ogg' = 1)

/obj/item/toy/plush/deer
	name = "deer plushie"
	desc = "An adorable stuffed toy that resembles a deer."
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_deer"
	inhand_icon_state = "plushie_deer"
	attack_verb_continuous = list("headbutts", "boops", "bapps", "bumps")
	attack_verb_simple = list("headbutt", "boop", "bap", "bump")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

/obj/item/toy/plush/fermis
	name = "medcat plushie"
	desc = "An affectionate stuffed toy that resembles a certain medcat, comes complete with battery operated wagging tail!! You get the impression she's cheering you on to find happiness and be kind to people."
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_fermis"
	inhand_icon_state = "plushie_fermis"
	attack_verb_continuous = list("cuddles", "petpatts", "wigglepurrs")
	attack_verb_simple = list("cuddle", "petpatt", "wigglepurr")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/merowr.ogg' = 1)
	gender = FEMALE
	
/obj/item/toy/plush/fermis/chen
	name = "securicat plushie"
	desc = "The official stuffed companion to the medcat plushie!! It resembles a certain securicat. You get the impression she's encouraging you to be brave and protect those you care for."
	icon_state = "plushie_chen"
	inhand_icon_state = "plushie_chen"
	attack_verb_continuous = list("snuggles", "meowhuggies", "wigglepurrs")
	attack_verb_simple = list("snuggle", "meowhuggie", "wigglepurr")
	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list("Assistant", "Head of Security")
	special_desc = "There's a pocket under the coat hiding a tiny picture of the medcat plushie and a tinier ribbon diamond ring. D'awww."

/obj/item/toy/plush/sechound
	name = "Sechound plushie"
	desc = "An adorable stuffed toy of a SecHound, the trusty Nanotrasen sponsored security borg!"
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_securityk9"
	inhand_icon_state = "plushie_securityk9"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep.ogg' = 1)

/obj/item/toy/plush/medihound
	name = "Medihound plushie"
	desc = "An adorable stuffed toy of a medihound."
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_medihound"
	inhand_icon_state = "plushie_medihound"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep.ogg' = 1)

/obj/item/toy/plush/scrubpuppy
	name = "Scrubpuppy plushie"
	desc = "An adorable stuffed toy of a Scrubpuppy, the hard-working pup who keeps the station clean!"
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_scrubpuppy"
	inhand_icon_state = "plushie_scrubpuppy"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep.ogg' = 1)

/obj/item/toy/plush/meddrake
	name = "MediDrake Plushie"
	desc = "An adorable stuffed toy of a Medidrake."
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_meddrake"
	inhand_icon_state = "plushie_meddrake"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep.ogg' = 1)

/obj/item/toy/plush/secdrake
	name = "SecDrake Plushie"
	desc = "An adorable stuffed toy of a Secdrake."
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_secdrake"
	inhand_icon_state = "plushie_secdrake"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep.ogg' = 1)


/obj/item/toy/plush/fox
	name = "Fox plushie"
	desc = "An adorable stuffed toy of a Fox."
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_fox"
	inhand_icon_state = "plushie_fox"
	attack_verb_continuous = list("geckers", "boops","nuzzles")
	attack_verb_simple = list("gecker", "boop", "nuzzle")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

/obj/item/toy/plush/duffmoth
	name = "Suspicious moth plushie"
	desc = "A plushie depicting a certain moth. He probably got turned into a marketable plushie."
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_duffy"
	inhand_icon_state = "plushie_duffy"
	attack_verb_continuous = list("flutters", "flaps", "squeaks")
	attack_verb_simple = list("flutter", "flap", "squeak")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/mothsqueak.ogg'= 1)
	gender = MALE

/obj/item/toy/plush/leaplush
	name = "Suspicious deer plushie"
	desc = "A cute and all too familiar deer."
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_lea"
	inhand_icon_state = "plushie_lea"
	attack_verb_continuous = list("headbutts", "plaps")
	attack_verb_simple = list("headbutt", "plap")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/leaplush.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/sarmieplush
	name = "Cosplayer plushie"
	desc = "A stuffed toy who look like a familiar cosplayer, <b>He looks sad.</b>"
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_sarmie"
	inhand_icon_state = "plushie_sarmie"
	attack_verb_continuous = list("baps")
	attack_verb_simple = list("bap")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/weh.ogg' = 1)
	gender = MALE

/obj/item/toy/plush/oglaplush
	name = "Suspicious lizzy"
	desc = "It would appear that, as a part of a certain lizard's plan to up his reputation, he manufactured a plushie of himself. At least it smells like blueberries."
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_ogla"
	inhand_icon_state = "plushie_ogla"
	attack_verb_continuous = list("claws", "hisses", "tail slaps")
	attack_verb_simple = list("claw", "hiss", "tail slap")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)
	gender = MALE

/obj/item/toy/plush/arcplush
	name = "Familiar lizard plushie"
	desc = "A small plushie that resembles a lizard-- Or, not a lizard, it's mouth seems to go horizontally too.. Are those limbs in it's maw?"
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_arc"
	inhand_icon_state = "plushie_arc"
	attack_verb_continuous = list("claws", "bites", "wehs")
	attack_verb_simple = list("claw", "bite", "weh")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/weh.ogg' = 1)
	young = 1 //No.

/obj/item/toy/plush/oleplush
	name = "Irritable goat plushie"
	desc = "A plush recreation of a purple ovine. Made with 100% real, all natural wool from the creator herself."
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_ole"
	inhand_icon_state = "plushie_ole"
	attack_verb_continuous = list("headbutts", "plaps")
	attack_verb_simple = list("headbutt", "plap")
	squeak_override = list('sound/weapons/punch1.ogg'= 1)
	young = 1 //No.
	gender = FEMALE

/obj/item/toy/plush/szaplush
	name = "Suspicious spider"
	desc = "A plushie of a shy looking drider, colored in floortile gray."
	icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
	icon_state = "plushie_sza"
	inhand_icon_state = "plushie_sza"
	attack_verb_continuous = list("scuttles", "chitters", "bites")
	attack_verb_simple = list("scuttle", "chitter", "bite")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/spiderplush.ogg' = 1)
	young = 1 //No.

/obj/item/toy/plush/riffplush
  name = "Valid plushie"
  desc = "A stuffed toy in the likeness of a peculiar demonic one. Likely turned into a plushie to sell such. They look quite alright about it."
  icon = 'modular_skyrat/modules/customization/icons/obj/plushes.dmi'
  icon_state = "plushie_riffy"
  inhand_icon_state = "plushie_riffy"
  attack_verb_continuous = list("slaps", "challenges")
  attack_verb_simple = list("slap", "challenge")
  squeak_override = list('sound/weapons/slap.ogg' = 1)
