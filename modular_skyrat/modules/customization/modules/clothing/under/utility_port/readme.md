## Title: Utility Port

MODULE ID: utility_port

### Description:

Ports several outfits from citbase, with the highlight being Utility Uniforms: dark-grey jumpsuits with departmental markings, with the same stats as the department's default jumpsuit.
It also ports:
    Other "utility" uniforms such as a gas/chemical hazard uniform;
    Japanese and Victorian costumes;
    Two short dresses;
    Several departmental/head-of-staff berets;
All items are avaliable through either the Loadout, Vendors, or Both. 


PART 2!
Ports the rest of what I was given with the utility uniforms, namely the Suits that go with all the previously added outfits. Also tweaks some of the previously added items (i.e., making the gas/chemical haz-uniform actually acidproof)

### TG Proc/File Changes:

To show items in vendors:
- core/modules/vending/autodrobe.dm
- core/modules/vending/clothesmate.dm
- core/modules/vending/wardrobes.dm

### Defines:

- N/A

### Master file additions

To add digitigrade variants:
- Skyrat-tg/modular_skyrat/master_files/icons/mob/clothing/uniform_digi.dmi
- Skyrat-tg/modular_skyrat/master_files/icons/mob/clothing/under/uniform_digi.dmi

### Included files that are not contained in this module:

Modifications to:
- modules/client/loadout/head.dm
- modules/client/loadout/uniform.dm
- icons/mob/clothing/uniform.dmi
- icons/obj/clothing/uniforms.dmi

### Credits:

Orion_the_Fox, with help from SarmentiCampbell
Sprites taken from https://github.com/Citadel-Station-13/Citadel-Station-13/pull/13475