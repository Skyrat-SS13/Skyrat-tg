## Title: SerenityStation

MODULE ID: SERENITYSTATION

### Description:

A nova-specific map featuring a station located on a forest planet. The forest planet has underground caves filled with mushrooms, and underground cold liquid plasma springs bubbling to the surface.

This includes 3 z-levels: the underground mushroom level; the surface forest level; and a space level that has a small orbital station and linkage to other space z levels.

This station features a custom shuttle to go between the orbital and planetary shuttle, though the public mining shuttle can also go between them (with 3 docking options now: planetary dock, orbital dock and lavaland).

There are custom mushroom tree, mushroom floor, mushroom flora, stillcap and megadeer sprites for this map. The megadeer is more or less a reskinned wolf and drops a reskinned wolf crusher trophy. The stillcap is a basic mob that hides as a mushroom when a target is not nearby.

There are two main cave generation types: the surface, which functions as normal cave generation such as icebox, and the lower mushroom level which uses biome generation to mix in three different biomes (red, blue and green)

The mushroom floor and liquid plasma sprites were cut using the icon cutter; I included the .png and .toml files needed for the cutter if that sprite gets edited.
To rerun the cutting tool move the relevant .dmi .png and .png.toml files to the \icons\turf\floors file and rerun the icon cutter, as it checks that non-modular folder for them.

### TG Proc/File Changes:

- _maps/_basemap.dm -> adds SerenityStation.dmm to the map file includes
- code/datums/ai/basic_mobs/basic_ai_behaviors/targeting.dm -> removes aggro_range in /datum/ai_behavior/find_potential_targets
- code/datums/map_config.dm -> added reading "allow_space_when_planetary" from the config json
- code/game/structures/flora.dm -> added variable tree stump types
- code/modules/unit_tests/mapload_space_verification -> made to check if planetary map allows space from the config
- config/maps.txt -> adds SerenityStation to the map config
- tgstation.dme -> adds new modular files to the includes

### Modular File Changes:

- modular_skyrat/modules/aesthetics/floors/icons/floors.dmi -> added mushroom turf icon
- modular_skyrat/modules/automapper/code/area_spawn_subsystem.dm -> added SerenityStation to the automapper's blacklisted stations
- modular_skyrat/modules/mapping/code/areas/shuttles.dm -> added the area for the planetary_ferry
- modular_skyrat/modules/mapping/code/areas/station.dm -> added the areas used in the station (as these might be reused in mapping; forest-related areas are in the module's folder)
- modular_skyrat/modules/mapping/code/shuttles.dm -> added map_template and computer for the planetary feery
- modular_skyrat/modules/mapping/code/vgdecals.dm -> added BZ floor decals
- modular_skyrat/modules/mapping/icons/areas/areas_station.dmi -> added icons for new station areas (cargo projects room, orbital areas, cyborg storage)
- modular_skyrat/modules/mapping/icons/turf/decals/vgstation_decals.dmi -> added BZ floor decals

### Defines:

- code/__DEFINES/icon_smoothing.dm -> SMOOTH_GROUP_MUSHROOM
- code/__DEFINES/~nova_defines/atmospherics.dm -> FOREST_DEFAULT_ATMOS

### Included files that are not contained in this module:

- modular_skyrat/master_files/code/controllers/subsystem/mapping.dm -> added proc to return is_planetary_with_space maps
- _maps/map_files/SerenityStation/SerenityStation.dmm
- _maps/serenitystation.json
- _maps/shuttles/nova/planetary_planetary_ferry.dmm
- code/__DEFINES/~nova_defines/atmospherics.dm

### Credits:

Credits to SableSteel (sable.steel on Discord, thlumyn on Github) for the map and sprites
Credits to GoldenAlpharex for the biome generation and other code
