https://github.com/Skyrat-SS13/Skyrat-tg/pull/9081

## Title: Re-implements complete records functionality, my old records on examine PR, implements a exploitables menu.

MODULE ID: records_on_examine

### Description:

This PR allows med/sec huds to view medical/security records on examine, respectively, as well as allowing you to view general records. It
also allows certain antags to view exploitables on examine as well. It also fully restores what functionality records had prior to the pref rework. Basically,
my last 2 prs in one.

### TG Proc/File Changes:

EDIT: examine.dm, human.dm, datacore.dm, flavor_text.dm, species_features.tx, tgui.dm, preferences.dm, preferences_savefile.dm. Allowed links to appear in chat when viewing people with huds/as certain antags, allows clikcing them to paste the records of the other party into chat. Re-implements the storing and handling of records into datacore, adds UI for that in flavor_text and species_features. Modified TGUI to recognize the exploitable manifest. Adds a var in preferences.dm, adds a copy of tgui pref migration code to preferences_savefile.dm to migrate old records into the new way of handling them.

### Defines:

- N/A

### Master file additions

- code/modules/antagonists/_common/antag_datum.dm

### Included files that are not contained in this module:

- RecordManifest.js, skyrat_records_migration.dm

### Credits:

Niko#7526, and #development_discuss for giving me the help I needed
