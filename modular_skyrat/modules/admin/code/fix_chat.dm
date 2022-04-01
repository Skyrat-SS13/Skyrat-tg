/client/proc/fix_say()
    set name = "FIX SAY"
    set category = "Admin"
    set desc = "fixes bug where people can't say shid"
    for(var/player in GLOB.player_list)
        if(isnull(player))
            GLOB.player_list -= player
