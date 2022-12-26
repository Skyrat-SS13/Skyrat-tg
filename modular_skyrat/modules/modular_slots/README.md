https://github.com/Skyrat-SS13/Skyrat-tg/pull/shrug

## Modular Item Slots

Module IDs: MODULAR_SLOTS, PASSPORT_SLOT

### Description:

This module contains example code, along with a framework of small non-modular edits that allow for adding new slots to humans without having to edit ~20 files to do so.

### TG Proc/File Changes:

- `code\__DEFINES\inventory.dm`: `SLOTS_AMT` !! IMPORTANT IF ADDING NEW SLOTS !!
- `code\modules\mob\living\carbon\human\inventory.dm`: `/mob/living/carbon/human/equip_to_slot`, `/mob/living/carbon/human/doUnEquip`
- `code\modules\mob\living\carbon\human\species.dm`: `/datum/species/proc/can_equip`
- `code\modules\mob\mob.dm`: `/mob/proc/equip_to_appropriate_slot` NOTE: Additional slots NEED to edit this to make thier slots work with quick equip (E)!

### Modular Overrides:
(All procs)
- `/datum/hud/human/New`
- `/datum/hud/human/hidden_inventory_update`
- `/datum/hud/human/persistent_inventory_update`
- `/mob/living/carbon/human/get_item_by_slot`
- `/mob/living/carbon/human/get_slot_by_item`
- `/mob/living/carbon/human/get_body_slots`
- `/mob/living/carbon/human/equip_to_slot`
- `/obj/item/update_slot_icon`
- `/slot2body_zone`

### Defines:

- `skyrat_defines/backgrounds.dm`: `ITEM_SLOT_PASSPORT`
- `skyrat_defines/slots.dm`: `CAN_EQUIP_PASS`, `CAN_EQUIP_FALSE`, `CAN_EQUIP_TRUE`

### Included files that are not contained in this module:

- N/A

### Credits:
RimiNosha - Code
