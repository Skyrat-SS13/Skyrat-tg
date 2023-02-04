/obj/item/implant/deathalarm
    name = "death alarm implant"
    desc = "An implant that screams in common when you die. Useful as a head of staff."
    activated = FALSE
    allow_multiple = FALSE
    uses = 1
    //Our internal radio
    var/obj/item/radio/radio = /obj/item/radio
    //The key our internal radio uses
    var/radio_key = /obj/item/encryptionkey/ai
    //The channel we will communicate with when we die, oof
    var/channels = list(RADIO_CHANNEL_MEDICAL,RADIO_CHANNEL_SECURITY)

/obj/item/implant/deathalarm/Initialize()
    . = ..()
    if(ispath(radio))
        radio = new radio(src)
        if(radio_key)
            radio.keyslot = new radio_key(radio)
        radio.listening = FALSE
        radio.recalculateChannels()

/obj/item/implant/deathalarm/Destroy()
    QDEL_NULL(radio)
    return ..()

/obj/item/implant/deathalarm/implant(mob/living/target, mob/user, silent, force)
    . = ..()
    if(!.)
        return
    RegisterSignal(target, COMSIG_LIVING_DEATH, .proc/on_death)

/obj/item/implant/deathalarm/removed(mob/living/source, silent, special)
    . = ..()
    if(!.)
        return
    UnregisterSignal(source, COMSIG_LIVING_DEATH)

/obj/item/implant/deathalarm/proc/on_death(mob/living/owner, gibbed)
    for(var/channel in channels)
        radio.talk_into(src, "[owner] has died at [get_area(owner)]!", channel)

/obj/item/implanter/deathalarm
	name = "deathalarm implanter"
	imp_type = /obj/item/implant/deathalarm
	desc = "An implant that shouts in the medical and security channels whenever the owner dies"

/obj/item/implantcase/deathalarm
	name = "implant case - 'Death Alarm'"
	desc = "A glass case containing an implant that can alert when the owner is dead."
	imp_type = /obj/item/implant/deathalarm
