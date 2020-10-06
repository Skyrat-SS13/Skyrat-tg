https://github.com/Skyrat-SS13/Skyrat-tg/pulls

## Title: Events

MODULE ID: EVENT

### Description:

Changes to the existing TG events, aswell our own events

### TG Proc Changes:
- OVERRIDE: modular_skyrat/modules/events/code/modules/events/meteor_wave.dm > /datum/round_event/meteor_wave/setup()
- code/modules/events/meteor_wave.dm > /datum/round_event/meteor_wave/announce()

### Defines:

- code/modules/events/brain_trauma.dm > /datum/round_event_control/brain_trauma > max_occurences = 0
- code/modules/events/wisdomcow.dm  > /datum/round_event_control/wisdomcow > max_occurences = 0
- code/modules/events/pirates.dm > /datum/round_event_control/pirates > weight = 2
- code/modules/events/meteor_wave.dm > /datum/round_event/meteor_wave/threatening > weight = 2
- code/modules/events/meteor_wave.dm > /datum/round_event/meteor_wave/catastrophic > weight = 2

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:
Azarak
