# Skyrat Map Information

## Modifications to /tg/ maps

The list of items that are modular requiring adding/modifying to /tg/ maps:

- Positronic Alert Consoles (inside Robotics area)
- Command Vendor (inside Meeting area)
- LustWish Vendor (inside Recreational/Dormitory area)
- Barbershop Room (including the vendors, chairs, mirrors, and more)
- NanoTrasen Consultant's Office
- Blueshield Office
- Cryopods (inside Recreational/Dormitory area)
- Stasis Beds to Stasis Pods
- Armory/Gun Change
- Prison Change
- Security Medical Room
- Arrival Tram and Console (inside Arrival area)
- Central Command Ferry Hangar (inside Arrival area)
- Update roundstart_template variable on mining/public/labour stationary docks: mining/x > mining/skyrat, mining_common/x > mining_common/skyrat, labour/x > labour/skyrat , mining/large > mining/large/skyrat
- Replace the security outposts with their departmental guards
- Xenoarch Base (Lavaland)
- Modular pets: E-N (Robotics), Poppy (Engineering), Bumbles (Hydroponics) and Markus (Cargo)
- Drone Dispensers added to all maps

## Rules

- If a map consists of multiple z-levels, each z-level should be a separate dmm file rather than one dmm with multiple z-levels.
Reason: MapDiffBot is unable to load dmms with multiple z-levels within it. This makes viewing changes needlessly difficult.

- Modular (Skyrat-exclusive) station-maps should aim to only be one z-level; if the map creator is going to use more than one z-level, the maximum amount of z-levels for the station will be two.
Reason: There can be issues when multiple z-levels are considered station-level z-levels; additionally, more station z-levels means less space z-levels.
