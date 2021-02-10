https://github.com/Skyrat-SS13/Skyrat-tg/pull/<!--PR Number-->

## Title: Sizeplay stuff

MODULE ID: SIZEPLAY

### Description

The PR introduces:

- a size ray gun that can enlarge or shrinkify people (for now admin-spawn and ghost cafe only)
- picking tiny people up like items (configurable)
- squishing tiny people when you step on them, with effect depending on intent chosen (configurable)
- slowdowns for micros

Be careful. The configs are not designed for being reloaded mid-game, so if you do so, things will get wonky.

This PR is by no means exhaustive in terms of features nor perfect in terms of code quality.
It's just the first iteration.
### TG Proc/File Changes

- code/datums/mutations/body.dm - changed the dwarfism and gigantism to use the new set_size() proc
- code/modules/reagents/chemistry/reagents/other_reagents.dm - growth serum now uses the set_size() proc too

### Defines

- N/A

### Master file additions

- modular_skyrat/master_files/code/controllers/configuration/entries.dm - added config entries for general size settings
- modular_skyrat/master_files/code/modules/mob/living/mob.dm - a quick patch to make mobs contained (picked up or otherwise) in mobs not suffocate

### Included files that are not contained in this module:

- N/A

### Credits:
code: Useroth

Sizegun sprites closely based on the ones from VOREStation, the original ones made by Keeknox according to https://github.com/VOREStation/VOREStation/pull/1911
