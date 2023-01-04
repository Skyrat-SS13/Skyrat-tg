https://github.com/Skyrat-SS13/Skyrat-tg/pull/3194

## Title: Suicide verb removal

MODULE ID: SUICIDE_VERB

### Description:

Removes the LRP suicide verb, in the same manner as most RP servers.

### TG Proc/File Changes:

Modified:

- `code/modules/client/verbs/suicide.dm`

Removed:

- `/mob/living/carbon/human/verb/suicide()`
- `/mob/living/brain/verb/suicide()`
- `/mob/living/silicon/ai/verb/suicide()`
- `/mob/living/silicon/robot/verb/suicide()`
- `/mob/living/silicon/pai/verb/suicide()`
- `/mob/living/carbon/alien/adult/verb/suicide()`
- `/mob/living/simple_animal/verb/suicide()`

### Defines:

- N/A

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:

Rohesie
