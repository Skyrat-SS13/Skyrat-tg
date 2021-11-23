https://github.com/Skyrat-SS13/Skyrat-tg/pull/892
https://github.com/Skyrat-SS13/Skyrat-tg/pull/1925
https://github.com/Skyrat-SS13/Skyrat-tg/pull/2320
https://github.com/Skyrat-SS13/Skyrat-tg/pull/6259

## Title: All the emotes.

MODULE ID: EMOTES

### Description:

Adds all the emotes we once had on the oldbase, and shoves them right into here.

Adds some new emotes, and adjusted sound files.

Pretty much anything that changes emotes is in here

### TG Proc Changes:

File Location | Changed TG Proc
------------- | ---------------
code/datums/emotes.dm | `/datum/emote/proc/check_cooldown(mob/user, intentional)`
code/datums/emotes.dm | `/datum/emote/proc/run_emote(mob/user, params, type_override, intentional = FALSE)`
code/modules/mob/living/carbon/carbon_defense.dm | `/mob/living/carbon/proc/help_shake_act(mob/living/carbon/M)`

### TG File Changes:

- code/datums/emotes.dm
- code/modules/mob/living/emote.dm
- code/modules/mob/living/carbon/emote.dm

### Defines:

File Location | Defines
------------- | -------
code/__DEFINES/~skyrat_defines/traits.dm 		| `#define TRAIT_EXCITABLE	"wagwag"`
modular_skyrat/modules/emotes/code/emotes.dm 	| `#define EMOTE_DELAY`

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:
- Gandalf2k15 - porting and refactoring
- Avunia Takiya
  - refactoring code
  - adjusting existing sound files
  - adding more emotes
- TheOOZ Additional emotes
  - overlay emotes
  - turf emotes
- VOREstation - a couple of the soundfiles and emote texts
