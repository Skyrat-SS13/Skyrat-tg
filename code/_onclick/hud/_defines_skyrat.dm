/proc/ui_hand_position(i) //values based on old hand ui positions (CENTER:-/+16,BOTTOM:5)
	var/x_off = -(!(i % 2))
	var/y_off = round((i-1) / 2)
	return"CENTER+[x_off]:16,BOTTOM+[y_off]:5"

/proc/ui_equip_position(mob/M)
	var/y_off = round((M.held_items.len-1) / 2) //values based on old equip ui position (CENTER: +/-16,BOTTOM+1:5)
	return "CENTER:-16,BOTTOM+[y_off+1]:5"

/proc/ui_swaphand_position(mob/M, which = 1) //values based on old swaphand ui positions (CENTER: +/-16,BOTTOM+1:5)
	var/x_off = which == 1 ? -1 : 0
	var/y_off = round((M.held_items.len-1) / 2)
	return "CENTER+[x_off]:16,BOTTOM+[y_off+1]:5"

//Lower left, persistent menu
#define ui_inventory "LEFT:6,BOTTOM:5"

//Middle left indicators
#define ui_lingchemdisplay "LEFT,CENTER-1:15"
#define ui_lingstingdisplay "LEFT:6,CENTER-3:11"

//Lower center, persistent menu
#define ui_sstore1 "CENTER-5:10,BOTTOM:5"
#define ui_id "CENTER-4:12,BOTTOM:5"
#define ui_belt "CENTER-3:14,BOTTOM:5"
#define ui_back "CENTER-2:14,BOTTOM:5"
#define ui_storage1 "CENTER+1:18,BOTTOM:5"
#define ui_storage2 "CENTER+2:20,BOTTOM:5"
#define ui_combo "CENTER+4:24,BOTTOM+1:7" //combo meter for martial arts
//SKYRAT EDIT ADDITION BEGIN - ERP_SLOT_SYSTEM
#define ui_vagina "LEFT+1:8,BOTTOM+4:14"
#define ui_vagina_down "LEFT+1:8,BOTTOM+1:8"
#define ui_anus "LEFT+2:10,BOTTOM+4:14"
#define ui_anus_down "LEFT+2:10,BOTTOM+1:8"
#define ui_nipples "LEFT:6,BOTTOM+5:17"
#define ui_nipples_down "LEFT:6,BOTTOM+2:11"
#define ui_penis "LEFT+1:8,BOTTOM+5:17"
#define ui_penis_down "LEFT+1:8,BOTTOM+2:11"
#define ui_erp_inventory "LEFT:6,BOTTOM+1:8"
#define ui_erp_inventory_up "LEFT:6,BOTTOM+4:14"
//SKYRAT EDI ADDITION END

//Lower right, persistent menu
#define ui_drop_throw "RIGHT-1:28,BOTTOM+1:7"
#define ui_above_movement "RIGHT-2:26,BOTTOM+1:7"
#define ui_above_intent "RIGHT-3:24, BOTTOM+1:7"
#define ui_movi "RIGHT-2:26,BOTTOM:5"
#define ui_acti "RIGHT-3:24,BOTTOM:5"
#define ui_combat_toggle "RIGHT-3:24,BOTTOM:5"
#define ui_zonesel "RIGHT-1:28,BOTTOM:5"
#define ui_acti_alt "RIGHT-1:28,BOTTOM:5" //alternative intent switcher for when the interface is hidden (F12)
#define ui_crafting "RIGHT-4:22,BOTTOM:5"
#define ui_building "RIGHT-4:22,BOTTOM:21"
#define ui_language_menu "RIGHT-4:6,BOTTOM:21"
#define ui_skill_menu "RIGHT-4:22,BOTTOM:5"

//Upper-middle right (alerts)
#define ui_alert1 "RIGHT-1:28,CENTER+5:27"
#define ui_alert2 "RIGHT-1:28,CENTER+4:25"
#define ui_alert3 "RIGHT-1:28,CENTER+3:23"
#define ui_alert4 "RIGHT-1:28,CENTER+2:21"
#define ui_alert5 "RIGHT-1:28,CENTER+1:19"

//Middle right (status indicators)
#define ui_healthdoll "RIGHT-1:28,CENTER-2:13"
#define ui_health "RIGHT-1:28,CENTER-1:15"
#define ui_internal "RIGHT-1:28,CENTER-3:10"
#define ui_mood "RIGHT-1:28,CENTER:17"
#define ui_spacesuit "RIGHT-1:28,CENTER-4:10"

//Pop-up inventory
#define ui_shoes "LEFT+1:8,BOTTOM:5"
#define ui_iclothing "LEFT:6,BOTTOM+1:7"
#define ui_oclothing "LEFT+1:8,BOTTOM+1:7"
#define ui_gloves "LEFT+2:10,BOTTOM+1:7"
#define ui_glasses "LEFT:6,BOTTOM+3:11"
#define ui_mask "LEFT+1:8,BOTTOM+2:9"
#define ui_ears "LEFT+2:10,BOTTOM+2:9"
#define ui_neck "LEFT:6,BOTTOM+2:9"
#define ui_head "LEFT+1:8,BOTTOM+3:11"

//Generic living
#define ui_living_pull "RIGHT-1:28,CENTER-3:15"
#define ui_living_healthdoll "RIGHT-1:28,CENTER-1:15"

//Monkeys
#define ui_monkey_head "CENTER-5:13,BOTTOM:5"
#define ui_monkey_mask "CENTER-4:14,BOTTOM:5"
#define ui_monkey_neck "CENTER-3:15,BOTTOM:5"
#define ui_monkey_back "CENTER-2:16,BOTTOM:5"

//Drones
#define ui_drone_drop "CENTER+1:18,BOTTOM:5"
#define ui_drone_pull "CENTER+2:2,BOTTOM:5"
#define ui_drone_storage "CENTER-2:14,BOTTOM:5"
#define ui_drone_head "CENTER-3:14,BOTTOM:5"

//Cyborgs
#define ui_borg_health "RIGHT-1:28,CENTER-1:15"
#define ui_borg_pull "RIGHT-2:26,BOTTOM+1:7"
#define ui_borg_radio "RIGHT-1:28,BOTTOM+1:7"
#define ui_borg_intents "RIGHT-2:26,BOTTOM:5"
#define ui_borg_lamp "CENTER-3:16, BOTTOM:5"
#define ui_borg_tablet "CENTER-4:16, BOTTOM:5"
#define ui_inv1 "CENTER-2:16,BOTTOM:5"
#define ui_inv2 "CENTER-1  :16,BOTTOM:5"
#define ui_inv3 "CENTER  :16,BOTTOM:5"
#define ui_borg_module "CENTER+1:16,BOTTOM:5"
#define ui_borg_store "CENTER+2:16,BOTTOM:5"
#define ui_borg_camera "CENTER+3:21,BOTTOM:5"
#define ui_borg_alerts "CENTER+4:21,BOTTOM:5"
#define ui_borg_language_menu "CENTER+4:19,BOTTOM+1:6"
// SKYRAT EDIT ADDITION BEGIN - Cyborg PDA
#define ui_borg_pda_send "CENTER+5:21,BOTTOM:5" // To the right of the alert panel
#define ui_borg_pda_log "CENTER+6:21,BOTTOM:5"
// SKYRAT EDIT ADDITION END

//Aliens
#define ui_alien_health "RIGHT,CENTER-1:15"
#define ui_alienplasmadisplay "RIGHT,CENTER-2:15"
#define ui_alien_queen_finder "RIGHT,CENTER-3:15"
#define ui_alien_storage_r "CENTER+1:18,BOTTOM:5"
#define ui_alien_language_menu "RIGHT-4:20,BOTTOM:5"

//AI
#define ui_ai_core "BOTTOM:6,LEFT"
#define ui_ai_camera_list "BOTTOM:6,LEFT+1"
#define ui_ai_track_with_camera "BOTTOM:6,LEFT+2"
#define ui_ai_camera_light "BOTTOM:6,LEFT+3"
#define ui_ai_crew_monitor "BOTTOM:6,LEFT+4"
#define ui_ai_crew_manifest "BOTTOM:6,LEFT+5"
#define ui_ai_alerts "BOTTOM:6,LEFT+6"
#define ui_ai_announcement "BOTTOM:6,LEFT+7"
#define ui_ai_shuttle "BOTTOM:6,LEFT+8"
#define ui_ai_state_laws "BOTTOM:6,LEFT+9"
#define ui_ai_pda_send "BOTTOM:6,LEFT+10"
#define ui_ai_pda_log "BOTTOM:6,LEFT+11"
#define ui_ai_take_picture "BOTTOM:6,LEFT+12"
#define ui_ai_view_images "BOTTOM:6,LEFT+13"
#define ui_ai_sensor "BOTTOM:6,LEFT+14"
#define ui_ai_multicam "BOTTOM+1:6,LEFT+13"
#define ui_ai_add_multicam "BOTTOM+1:6,LEFT+14"
#define ui_ai_language_menu "BOTTOM+1:8,LEFT+11:30"

//pAI
#define ui_pai_software "BOTTOM:6,LEFT"
#define ui_pai_shell "BOTTOM:6,LEFT+1"
#define ui_pai_chassis "BOTTOM:6,LEFT+2"
#define ui_pai_rest "BOTTOM:6,LEFT+3"
#define ui_pai_light "BOTTOM:6,LEFT+4"
#define ui_pai_newscaster "BOTTOM:6,LEFT+5"
#define ui_pai_host_monitor "BOTTOM:6,LEFT+6"
#define ui_pai_crew_manifest "BOTTOM:6,LEFT+7"
#define ui_pai_state_laws "BOTTOM:6,LEFT+8"
#define ui_pai_pda_send "BOTTOM:6,LEFT+9"
#define ui_pai_pda_log "BOTTOM:6,LEFT+10"
#define ui_pai_internal_gps "BOTTOM:6,LEFT+11"
#define ui_pai_take_picture "BOTTOM:6,LEFT+12"
#define ui_pai_view_images "BOTTOM:6,LEFT+13"
#define ui_pai_radio "BOTTOM:6,LEFT+14"
#define ui_pai_language_menu "BOTTOM+1:8,LEFT+13:31"

//Ghosts
#define ui_ghost_spawners_menu "BOTTOM:6,CENTER-3:24"
#define ui_ghost_orbit "BOTTOM:6,CENTER-2:24"
#define ui_ghost_reenter_corpse "BOTTOM:6,CENTER-1:24"
#define ui_ghost_teleport "BOTTOM:6,CENTER:24"
#define ui_ghost_pai "BOTTOM: 6, CENTER+1:24"
#define ui_ghost_minigames "BOTTOM: 6, CENTER+2:24"
#define ui_ghost_language_menu "BOTTOM: 22, CENTER+3:8"

//Blobbernauts
#define ui_blobbernaut_overmind_health "RIGHT-1:28,CENTER+0:19"

//Families
#define ui_wanted_lvl "NORTH,11"

//SKYRAT HUD DEFINES BELOW
#define ui_ammocounter "RIGHT-1:28,CENTER-5:9"
