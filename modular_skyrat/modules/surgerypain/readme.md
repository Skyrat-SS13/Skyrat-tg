https://github.com/Skyrat-SS13/Skyrat-tg/pull/5899

## Title: Surgery Pain.

MODULE ID: SURGERYPAIN

### Description:

Adds a few unique surgical pain messages to certain surgical steps Surgeries with a timer of 50+ get a message for pre-op, success and failure, below that, steps either get preop or success/failure.

### TG Proc Changes:

- /datum/surgery_step/reshape_face/success() at code\modules\surgery\plastic_surgery.dm; 42. - Had to be done non-modularly due to input.
- /datum/surgery_step/heal/preop() at code\modules\surgery\healing.dm; 61 - Non-modular so as to correctly get woundtype without re-defining the entire proc modularly.

### Defines:

- N/A

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:
- FlamingLily
