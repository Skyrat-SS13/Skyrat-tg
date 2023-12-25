<!-- This should be copy-pasted into the root of your module folder as readme.md -->

https://github.com/Skyrat-SS13/Skyrat-tg/pull/23733

## Skyrat Medical Update <!--Title of your addition.-->

Module ID: death_consequences <!-- Uppercase, UNDERSCORE_CONNECTED name of your module, that you use to mark files. This is so people can case-sensitive search for your edits, if any. -->

### Description:

A highly customizable quirk designed to make you fear death, and introduce a more fair mortality the DNR quirk is unable to.

<!-- Here, try to describe what your PR does, what features it provides and any other directly useful information. -->

### TG Proc/File Changes:

- healthscanner.dm: /proc/healthscan(), added text for the quirk
- species_features.tsx: Necessary for the preference UI
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

- ~skyrat_defines/quirks.dm: A lot of prefixed defines
<!-- If you needed to add any defines, mention the files you added those defines in, along with the name of the defines. -->

### Included files that are not contained in this module:

- modular_skyrat\master_files\code\modules\client\preferences\quirks\death_consequences.dm

<!-- Likewise, be it a non-modular file or a modular one that's not contained within the folder belonging to this specific module, it should be mentioned here. Good examples are icons or sounds that are used between multiple modules, or other such edge-cases. -->

### Credits:

Niko - Original author

<!-- Here go the credits to you, dear coder, and in case of collaborative work or ports, credits to the original source of the code. -->
