# Pull Request Link

'https://github.com/Skyrat-SS13/Skyrat-tg/pull/'<!--PR Number-->

## Title: <!--Title of your addition-->

MODULE ID: SOULSTONE_CHANGES<!-- uppercase, underscore_connected name of your module, that you use to mark files-->

### Description

Makes soulstone no longer permakill people, and makes construct's souls return to their original bodies if the construct is killed.
<!-- Here, try to describe what your PR does, what features it provides and any other directly useful information -->

### TG Proc/File Changes

- code/modules/antagonist/wizard/equipment/soulstone.dm > /obj/item/soulstone/proc/transfer_soul()
- code/modules/antagonist/wizard/equipment/soulstone.dm > /obj/item/soulstone/proc/init_shade()
- code/modules/antagonist/wizard/equipment/soulstone.dm > /obj/item/soulstone/proc/getCultGhost()

<!-- If you had to edit, or append to any core procs in the process of making this PR, list them here. APPEND: Also, please include any files that you've changed. .DM files that is. -->

### Defines

- code/__DEFINES/~skyrat_defines/traits.dm > TRAIT_SACRIFICED
<!-- If you needed to add any defines, mention the files you added those defines in -->

### Master file additions

- N/A
<!-- Any master file changes you've made to existing master files or if you've added a new master file. Please mark either as #NEW or #CHANGE -->

### Included files that are not contained in this module

- N/A
<!-- Likewise, be it a non-modular file or a modular one that's not contained within the folder belonging to this specific module, it should be mentioned here -->

### Credits

`https://github.com/Arturlang`
<!-- Here go the credits to you, dear coder, and in case of collaborative work or ports, credits to the original source of the code -->
