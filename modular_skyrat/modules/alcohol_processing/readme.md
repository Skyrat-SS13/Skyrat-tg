## Title: Alcohol Processing

MODULE ID: ALCOHOL_PROCESSING

### Description:

Adjusts the rate of alcohol processing, its effects, and thresholds. Drinks last longer with a smoother up and down for more predictable roleplay drinking.

### TG Proc Changes:
- EDIT: code/datums/mood.dm > /datum/mood/proc/print_mood(mob/user)
- EDIT: code/datums/status_effects/debuffs/drunk.dm  > /datum/status_effect/inebriated/drunk/on_tick_effects(), /datum/status_effect/inebriated/tick()
- EDIT: code/modules/reagents/chemistry/reagents/drinks/alcohol_reagents.dm > /datum/reagent/consumable/ethanol/on_mob_life()

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:
LT3
