#ifdef AI_VOX

GLOBAL_LIST_INIT(vox_sounds_bms, list(
	"and" = 'modular_skyrat/modules/alt_vox/sound/vox_bms/and.ogg',
	"audit" = 'modular_skyrat/modules/alt_vox/sound/vox_bms/audit.ogg',
	"b" = 'modular_skyrat/modules/alt_vox/sound/vox_bms/b.ogg',
	"c" = 'modular_skyrat/modules/alt_vox/sound/vox_bms/c.ogg',
	"complex" = 'modular_skyrat/modules/alt_vox/sound/vox_bms/complex.ogg',
))

#endif

/proc/generate_vox_list()
	var/list/vox_list = flist("modular_skyrat/modules/alt_vox/sound/vox_bms/")

	for(var/S in vox_list)
		to_chat(world, {""[S]" = 'modular_skyrat/modules/alt_vox/sound/vox_bms/[S].ogg',"})

