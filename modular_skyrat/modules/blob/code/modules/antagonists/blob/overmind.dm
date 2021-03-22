/mob/camera/blob
    /// At the halfway point to blob victory, send an automated announcement/distress call, letting all crew know how fucked things are and allowing admins to send (more) ERT
    var/has_announced_emergency = FALSE

/mob/camera/blob/proc/announce_blob_distress_signal()
    has_announced_emergency = TRUE
    if(GLOB.security_level != SEC_LEVEL_RED) // Why the hell is it not red yet?!
        set_security_level("red")
    priority_announce("Biohazard lifeform aboard [GLOB.station_name] is rapidly approaching critical mass. Off-station Response Teams are requested to aid immediately.", "Automated Biohazard Distress Signal", sender_override = "[GLOB.station_name]")
    
