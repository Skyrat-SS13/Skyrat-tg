## Title: Gunpoint

MODULE ID: GUNHUD

### Description:

Adds a dynamic hud system for energy and some ballistics guns.

### TG Proc Changes:
- N/A
### Defines:

.code\__DEFINES\atom_hud.dm > #define AMMO_HUD	"25"

.code\modules\projectiles\guns\ballistic.dm > /obj/item/gun/ballistic/examine(mob/user)

### Master file additions

- Hud directory > _defines.dm, human.dm, hud.dm
- `modular_skyrat\master_files\code\game\objects\items\tools\weldingtool.dm`: `proc/Initialize`, `proc/set_welding`
- `modular_skyrat\master_files\code\modules\projectiles\guns\ballistic.dm`: `proc/eject_magazine`, `proc/insert_magazine`
- `modular_skyrat\master_files\code\modules\projectiles\guns\energy.dm`: `proc/process`, `proc/select_fire`

### Included files that are not contained in this module:

- N/A

### Credits:
Gandalf2k15 - OG creation.
Larentoun - modularisation
