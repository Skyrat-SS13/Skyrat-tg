https://github.com/Skyrat-SS13/Skyrat-tg/pull/127

## Title: Alternate Borgs

MODULE ID: TYPING_INDICATOR

### Description:

Shows up a typing indicator when players start typing and emoting.

### TG Proc Changes:
- ADDITION: code\modules\mob\living\life.dm > /mob/living/proc/Life
- ADDITION: code\modules\mob\living\living_say.dm > /mob/living/say
- CHANGE: code\modules\mob\living\living_say.dm > /mob/living/send_speech
- ADDITION: code\modules\mob\mob_say.dm > /mob/verb/say_verb
- ADDITION: code\modules\mob\mob_say.dm > /mob/verb/me_verb
- CHANGE: code\controllers\subsystem\input.dm > /datum/controller/subsystem/input/proc/setup_default_macro_sets()

### Defines:

- N/A

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:

Gandalf2k15 - Porting
Useroth - OG code
