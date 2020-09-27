## Title: Pixel shifting for RP positioning

MODULE ID: PIXEL_SHIFT

### Description:

Adds the ability for living mobs to shift their sprite to fit an RP situation better (standing against a wall for example). Not appended to proc due to it being a busy proc

### TG Proc Changes:

 - ADDITION: \code\modules\mob\living > /mob/living/Moved()
 - CHANGE: Skyrat-tg\code\datums\keybinding\mob.dm > /datum/keybinding/mob/prevent_movement - Keybind changed to ctrl.

### Defines:

 - Skyrat-tg\code\modules\mob\mob_movement.dm > /client/Move(n, direct)

### Included files:

N/A

### Credits:

Azarak - Porting
Gandalf2k15 - Refactoring
