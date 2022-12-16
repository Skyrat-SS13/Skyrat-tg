## Title: HVAC grenades

MODULE ID: deployable_HVAC

### Description:

Adds deployable space heater grenades.  They have a custom grenade and machine texture in `deployable_hvac.dmi`
They work based off of the usual grenade code, but when they detonate, they will spawn a special space heater that has less health can doesn't leave a frame on destruction.  (Instead it leaves cardboard!)

### Non-Modular stuff:

This module modifies `engivend.dm` to add:
`/obj/item/grenade/heater = 5  // SKYRAT EDIT ADDITON`
`/obj/item/grenade/clusterbuster/heater = 1  // SKYRAT EDIT ADDITON`
`/obj/item/storage/box/heatergrenades = 1  // SKYRAT EDIT ADDITON`
