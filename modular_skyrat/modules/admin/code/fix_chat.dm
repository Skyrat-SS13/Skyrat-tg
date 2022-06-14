/client/proc/fix_say()
    set name = "Fix say for players"
    set category = "Admin"
    for(var/player in GLOB.player_list)
        if(isnull(player))
            GLOB.player_list -= player
