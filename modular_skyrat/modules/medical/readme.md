<!-- This should be copy-pasted into the root of your module folder as readme.md -->

https://github.com/Skyrat-SS13/Skyrat-tg/pull/2336
https://github.com/Skyrat-SS13/Skyrat-tg/pull/23733

## Skyrat Medical Update <!--Title of your addition.-->

Module ID: SKYRAT_MEDICAL_UPDATE <!-- Uppercase, UNDERSCORE_CONNECTED name of your module, that you use to mark files. This is so people can case-sensitive search for your edits, if any. -->

### Description:

Various changes to the medical system, from adding bandage overlays, to new wounds, to modularized procs.

<!-- Here, try to describe what your PR does, what features it provides and any other directly useful information. -->

### TG Proc/File Changes:

- code/_DEFINES/wounds.dm: Added muscle/synth wound series, added them to the global list of wound series
- cat2_medicine_reagents.dm: /datum/reagent/medicine/c2/hercuri/on_mob_life, Allowed hercuri to affect synthetics, also changed hercuri process flags for this purpose
- quirks.dm: Commented out the quadruple_amputee/frail blacklist as frail can now apply to prosthetics
<!-- If you edited any core procs, you should list them here. You should specify the files and procs you changed.
E.g: 
- `code/modules/mob/living.dm`: `proc/overriden_proc`, `var/overriden_var`
-->

### Modular Overrides:

- N/A
<!-- If you added a new modular override (file or code-wise) for your module, you should list it here. Code files should specify what procs they changed, in case of multiple modules using the same file.
E.g: 
- `modular_skyrat/master_files/sound/my_cool_sound.ogg`
- `modular_skyrat/master_files/code/my_modular_override.dm`: `proc/overriden_proc`, `var/overriden_var`
-->

### Defines:

- Many local synthetic wound defines
<!-- If you needed to add any defines, mention the files you added those defines in, along with the name of the defines. -->

### Included files that are not contained in this module:

- strings/wounds/metal_scar_desc.json -- Required to be here for _string_lists.dm usage
<!-- Likewise, be it a non-modular file or a modular one that's not contained within the folder belonging to this specific module, it should be mentioned here. Good examples are icons or sounds that are used between multiple modules, or other such edge-cases. -->

### Credits:

Azarak - Original medical update, muscle wounds, bandage overlays
Niko - Synthetic wounds
TG coding/Skyrat coding channels and community - Support, ideas, reviews

<!-- Here go the credits to you, dear coder, and in case of collaborative work or ports, credits to the original source of the code. -->
