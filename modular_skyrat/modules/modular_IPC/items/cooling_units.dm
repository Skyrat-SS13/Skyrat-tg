/obj/item/coolingpack
    name = "Cooling Unit"
    desc = "A backpack modified to cool robotic entities."
    icon = 'modular_skyrat/modules/modular_IPC/icons/suitcooler.dmi'
    icon_state = "suitcooler0"
    inhand_icon_state = "holdingpack"
    slot_flags = ITEM_SLOT_BACK //Because anything else is broken
    resistance_flags = FIRE_PROOF
    var/obj/item/stock_parts/cell/high/cell
    var/coolingcost = 5 //5 power per tick to cool. Will likely be adjusted for balance.
    var/on = FALSE //Have them start off.
    var/powered = FALSE //Needed.

/obj/item/coolingpack/get_cell()
    return cell

/obj/item/coolingpack/proc/update_power()
    if(!QDELETED(cell))
        if(cell.charge < coolingcost)
            powered = FALSE
            icon_state = "suitcooler0"
        else
            powered = TRUE
            icon_state = "suitcooler1"
    else
        powered = FALSE
    update_icon()

/obj/item/coolingpack/Initialize() //starts without a cell for rnd
    . = ..()
    update_power()
    return

/obj/item/coolingpack/Initialize() //starts with hicap
    . = ..()
    cell = new(src)
    update_power()
    return

/obj/item/coolingpack/attack_self(mob/user)
    . = ..()
    if(on == TRUE)
        on = FALSE
        update_power()
    else
        on = TRUE //im so fucking lazy
        update_power()

/obj/item/coolingpack/examine(mob/user)
    . = ..()
    . += "<span class='warning'>Charge Left: [cell.charge]/[cell.maxcharge]</span>"

/obj/item/coolingpack/equipped(mob/user, slot)
    ..()
    if((slot_flags == ITEM_SLOT_BACK) && powered == TRUE && on == TRUE)
        update_power()
        user.adjust_bodytemperature(-65)//Enough to sustain you indefinitely in space, but not while on fire.
        cell.charge =  (cell.charge - coolingcost)












