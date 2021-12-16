https://github.com/Skyrat-SS13/Skyrat-tg/9922/

## Title: Lets mechs use CI, also adds a seperate emote_flick proc to allow emote_flick to be used on objects.

MODULE ID: mech_ci_change

### Description:

Changes the way vehicle code works to attach the CI overlay to mechs when the master user (pilot/only occupant) changes CI status. Changes a bunch of CI code to make this work.

### TG Proc/File Changes:

- _mecha.dm
<!-- If you had to edit, or append to any core procs in the process of making this PR, list them here. APPEND: Also, please include any files that you've changed. .DM files that is. -->

### Defines:

- N/A
<!-- If you needed to add any defines, mention the files you added those defines in -->

### Master file additions

- #CHANGE signals.dm to have COMSIG_MOB_CI_TOGGLED
<!-- Any master file changes you've made to existing master files or if you've added a new master file. Please mark either as #NEW or #CHANGE -->

### Included files that are not contained in this module:

- N/A
<!-- Likewise, be it a non-modular file or a modular one that's not contained within the folder belonging to this specific module, it should be mentioned here -->

### Credits:
Niko
<!-- Here go the credits to you, dear coder, and in case of collaborative work or ports, credits to the original source of the code -->
