/datum/chemical_reaction/food/soup/clean_up(datum/reagents/holder, datum/equilibrium/reaction, react_vol)
    . = ..()
    var/souptype = results[1]
    var/list/cached_reagents = holder.reagent_list
    for(var/datum/reagent/whatever as anything in cached_reagents)
        if(whatever.type == souptype)
            continue
        var/new_vol = whatever.volume
        holder.del_reagent(whatever.type)
        holder.add_reagent(souptype, new_vol)
