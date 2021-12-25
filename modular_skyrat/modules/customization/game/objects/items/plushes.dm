// MODULAR PLUSHES

/obj/item/toy/plush/borbplushie
	name = "borb plushie"
	desc = "An adorable stuffed toy that resembles a round, fluffy looking bird. Not to be mistaken for his friend, the birb plushie."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_borb"
	inhand_icon_state = "plushie_borb"
	attack_verb_continuous = list("pecks", "peeps")
	attack_verb_simple = list("peck", "peep")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/peep_once.ogg' = 1)

/obj/item/toy/plush/deer
	name = "deer plushie"
	desc = "An adorable stuffed toy that resembles a deer."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_deer"
	inhand_icon_state = "plushie_deer"
	attack_verb_continuous = list("headbutts", "boops", "bapps", "bumps")
	attack_verb_simple = list("headbutt", "boop", "bap", "bump")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

/obj/item/toy/plush/fermis
	name = "medcat plushie"
	desc = "An affectionate stuffed toy that resembles a certain medcat, comes complete with battery operated wagging tail!! You get the impression she's cheering you on to find happiness and be kind to people."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
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
	special_desc_jobs = list(JOB_ASSISTANT, JOB_HEAD_OF_SECURITY)
	special_desc = "There's a pocket under the coat hiding a tiny picture of the medcat plushie and a tinier ribbon diamond ring. D'awww."

/obj/item/toy/plush/sechound
	name = "sec-hound plushie"
	desc = "An adorable stuffed toy of a SecHound, the trusty Nanotrasen sponsored security borg!"
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_securityk9"
	inhand_icon_state = "plushie_securityk9"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep.ogg' = 1)

/obj/item/toy/plush/medihound
	name = "medi-hound plushie"
	desc = "An adorable stuffed toy of a medihound."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_medihound"
	inhand_icon_state = "plushie_medihound"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep.ogg' = 1)

/obj/item/toy/plush/scrubpuppy
	name = "scrub-puppy plushie"
	desc = "An adorable stuffed toy of a Scrubpuppy, the hard-working pup who keeps the station clean!"
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_scrubpuppy"
	inhand_icon_state = "plushie_scrubpuppy"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep.ogg' = 1)

/obj/item/toy/plush/meddrake
	name = "medi-drake plushie"
	desc = "An adorable stuffed toy of a Medidrake."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_meddrake"
	inhand_icon_state = "plushie_meddrake"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep.ogg' = 1)

/obj/item/toy/plush/secdrake
	name = "sec-drake plushie"
	desc = "An adorable stuffed toy of a Secdrake."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_secdrake"
	inhand_icon_state = "plushie_secdrake"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep.ogg' = 1)


/obj/item/toy/plush/fox
	name = "fox plushie"
	desc = "An adorable stuffed toy of a Fox."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_fox"
	inhand_icon_state = "plushie_fox"
	attack_verb_continuous = list("geckers", "boops","nuzzles")
	attack_verb_simple = list("gecker", "boop", "nuzzle")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

/obj/item/toy/plush/duffmoth
	name = "suspicious moth plushie"
	desc = "A plushie depicting a certain moth. He probably got turned into a marketable plushie."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_duffy"
	inhand_icon_state = "plushie_duffy"
	attack_verb_continuous = list("flutters", "flaps", "squeaks")
	attack_verb_simple = list("flutter", "flap", "squeak")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/mothsqueak.ogg'= 1)
	gender = MALE

/obj/item/toy/plush/leaplush
	name = "suspicious deer plushie"
	desc = "A cute and all too familiar deer."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_lea"
	inhand_icon_state = "plushie_lea"
	attack_verb_continuous = list("headbutts", "plaps")
	attack_verb_simple = list("headbutt", "plap")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/leaplush.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/sarmieplush
	name = "cosplayer plushie"
	desc = "A stuffed toy who look like a familiar cosplayer, <b>he looks sad.</b>"
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_sarmie"
	inhand_icon_state = "plushie_sarmie"
	attack_verb_continuous = list("baps")
	attack_verb_simple = list("bap")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/weh.ogg' = 1)
	gender = MALE

/obj/item/toy/plush/sharknet
	name = "gluttonous shark plushie"
	desc = "A heavy plushie of a rather large and hungry shark"
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_sharknet"
	inhand_icon_state = "plushie_sharknet"
	attack_verb_continuous = list("cuddles", "squishes", "wehs")
	attack_verb_simple = list("cuddle", "squish", "weh")
	w_class = WEIGHT_CLASS_NORMAL
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/slime_squish.ogg' = 1)
	young = 1 //No.
//Storage component for Sharknet Plushie//
/obj/item/toy/plush/sharknet/ComponentInitialize()
	var/datum/component/storage/concrete/storage = AddComponent(/datum/component/storage/concrete)
	storage.max_items = 2
	storage.max_w_class = WEIGHT_CLASS_SMALL
	storage.set_holdable(list(
		/obj/item/toy/plush/pintaplush,
		/obj/item/toy/plush/arcplush
		))
//End of storage component//

/obj/item/toy/plush/pintaplush
	name = "smaller deer plushie"
	desc = "A pint-sized cervine with a vacant look."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_pinta"
	inhand_icon_state = "plushie_pinta"
	attack_verb_continuous = list("bonks", "snugs")
	attack_verb_simple = list("bonk", "snug")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/slime_squish.ogg' = 1)
	young = 1 //No.

/obj/item/toy/plush/arcplush
	name = "familiar lizard plushie"
	desc = "A small plushie that resembles a lizard-- Or, not a lizard, it's mouth seems to go horizontally too.. Are those limbs in it's maw?"
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_arc"
	inhand_icon_state = "plushie_arc"
	attack_verb_continuous = list("claws", "bites", "wehs")
	attack_verb_simple = list("claw", "bite", "weh")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/weh.ogg' = 1)
	young = 1 //No.

/obj/item/toy/plush/oleplush
	name = "irritable goat plushie"
	desc = "A plush recreation of a purple ovine. Made with 100% real, all natural wool from the creator herself."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_ole"
	inhand_icon_state = "plushie_ole"
	attack_verb_continuous = list("headbutts", "plaps")
	attack_verb_simple = list("headbutt", "plap")
	squeak_override = list('sound/weapons/punch1.ogg'= 1)
	young = 1 //No.
	gender = FEMALE

/obj/item/toy/plush/szaplush
	name = "suspicious spider"
	desc = "A plushie of a shy looking drider, colored in floortile gray."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_sza"
	inhand_icon_state = "plushie_sza"
	attack_verb_continuous = list("scuttles", "chitters", "bites")
	attack_verb_simple = list("scuttle", "chitter", "bite")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/spiderplush.ogg' = 1)
	young = 1 //No.

/obj/item/toy/plush/riffplush
  name = "valid plushie"
  desc = "A stuffed toy in the likeness of a peculiar demonic one. Likely turned into a plushie to sell such. They look quite alright about it."
  icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
  icon_state = "plushie_riffy"
  inhand_icon_state = "plushie_riffy"
  attack_verb_continuous = list("slaps", "challenges")
  attack_verb_simple = list("slap", "challenge")
  squeak_override = list('sound/weapons/slap.ogg' = 1)

/obj/item/toy/plush/ian
	name = "plush corgi"
	desc = "A plushie of an adorable corgi! Don't you just want to hug it and squeeze it and call it \"Ian\"?"
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "ianplushie"
	inhand_icon_state = "corgi"
	attack_verb_continuous = list("barks", "woofs", "wags his tail at")
	attack_verb_simple = list("lick", "nuzzle", "bite")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/bark2.ogg' = 1)
	young = 1 //No.

/obj/item/toy/plush/ian/small
	name = "small plush corgi"
	desc = "A plushie of an adorable corgi! Don't you just want to hug it and squeeze it and call it \"Ian\"?"
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "corgi"
	inhand_icon_state = "corgi"

/obj/item/toy/plush/ian/lisa
	name = "plush girly corgi"
	desc = "A plushie of an adorable corgi! Don't you just want to hug it and squeeze it and call it \"Lisa\"?"
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "girlycorgi"
	inhand_icon_state = "girlycorgi"
	attack_verb_continuous = list("barks", "woofs", "wags her tail at")
	gender = FEMALE

/obj/item/toy/plush/cat
	name = "cat plushie"
	desc = "A small cat plushie with black beady eyes."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "blackcat"
	inhand_icon_state = "blackcat"
	attack_verb_continuous = list("cuddles", "meows", "hisses")
	attack_verb_simple = list("cuddle", "meow", "hiss")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/merowr.ogg' = 1)

/obj/item/toy/plush/cat/tux
	name = "tux cat plushie"
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "tuxedocat"
	inhand_icon_state = "tuxedocat"

/obj/item/toy/plush/cat/white
	name = "white cat plushie"
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "whitecat"
	inhand_icon_state = "whitecat"

/obj/item/toy/plush/seaduplush
	name = "sneed plushie"
	desc = "A plushie of a particular, bundled up IPC. Underneath the cloak, you can see a plush recreation of the captain's sabre."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_seadu"
	inhand_icon_state = "plushie_seadu"
	attack_verb_continuous = list("beeps","sneeds","swords")
	attack_verb_simple = list("beep","sneed","sword")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/synth_yes.ogg' = 1,'modular_skyrat/modules/emotes/sound/emotes/synth_no.ogg' = 1)

/obj/item/toy/plush/lizzyplush
	name = "odd yoga lizzy plushie"
	desc = "Brought to you by Nanotrasen Wellness Program is the Yoga Odd Lizzy! He smells vaguely of blueberries, and likely resembles a horrible lover."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_lizzy"
	inhand_icon_state = "plushie_lizzy"
	attack_verb_continuous = list("wehs")
	attack_verb_simple = list("weh")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/weh.ogg' = 1)

/obj/item/toy/plush/fox/mia
	name = "Mia’s fox plushie"
	desc = "A small stuffed silver fox with a collar tag that says “Eavy” and a tiny bell in its fluffy tail."
	icon_state = "miafox"

/obj/item/toy/plush/fox/kailyn
	name = "teasable fox plushie"
	desc = "A familiar looking vixen in a peacekeeper attire, perfect for everyone who intends on venturing in the dark alone! There's a little tag which tells you to not boop its nose."
	icon_state = "teasefox"
	attack_verb_continuous = list("sneezes on", "detains", "tazes")
	attack_verb_simple = list("sneeze on", "detain", "taze")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/female/female_sneeze.ogg' = 1)
