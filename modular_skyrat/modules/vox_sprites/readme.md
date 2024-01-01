https://github.com/Skyrat-SS13/Skyrat-tg/pull/7522

## Title: Vox sprite fixes, updates, and additions

MODULE ID: VOX_SPRITES

### Description:

Ports the Vox species and clothing sprites from Paradise plus some new GAGS-compatible ones, and adds code to support them.

### TG Proc/File Changes:

- APPEND: code/game/objects/items.dm > /obj/item/update_greyscale()
- APPEND: code/modules/mob/living/carbon/human/human_update_icons.dm > /mob/living/carbon/human/update_worn_gloves()

### Defines:

- N/A

### Master file additions

Species sprites:

- modular_skyrat/master_files/icons/mob/body_markings/vox_secondary.dmi #CHANGE
- modular_skyrat/master_files/icons/mob/species/vox_eyes.dmi #CHANGE
- modular_skyrat/master_files/icons/mob/species/vox_parts_greyscale.dmi #CHANGE
- modular_skyrat/master_files/icons/mob/sprite_accessory/vox_facial_hair.dmi #CHANGE
- modular_skyrat/master_files/icons/mob/sprite_accessory/vox_hair.dmi #CHANGE
- modular_skyrat/master_files/icons/mob/sprite_accessory/vox_snouts.dmi #CHANGE

Clothing sprites:

- modular_skyrat/master_files/icons/mob/clothing/head_vox.dmi #CHANGE
- modular_skyrat/master_files/icons/mob/clothing/mask_vox.dmi #CHANGE
- modular_skyrat/master_files/icons/mob/clothing/species/vox/back.dmi #ADD
- modular_skyrat/master_files/icons/mob/clothing/species/vox/color_gags_vox.dmi #ADD
- modular_skyrat/master_files/icons/mob/clothing/species/vox/ears.dmi #ADD
- modular_skyrat/master_files/icons/mob/clothing/species/vox/eyes.dmi #ADD
- modular_skyrat/master_files/icons/mob/clothing/species/vox/feet.dmi #ADD
- modular_skyrat/master_files/icons/mob/clothing/species/vox/hands.dmi #ADD
- modular_skyrat/master_files/icons/mob/clothing/species/vox/head.dmi #ADD
- modular_skyrat/master_files/icons/mob/clothing/species/vox/helmet.dmi #ADD
- modular_skyrat/master_files/icons/mob/clothing/species/vox/suit.dmi #ADD
- modular_skyrat/master_files/icons/mob/clothing/species/vox/uniform.dmi #ADD

### Included files that are not contained in this module:

- N/A

### Credits:

Vox species and clothing sprites - Paradise Station

PR Code - SabreML
PR Sprite implementation & GAGS compatibility - CandleJaxx
