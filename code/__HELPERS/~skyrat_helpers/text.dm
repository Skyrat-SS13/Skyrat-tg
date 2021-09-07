//Assorted text helper procs
#define show_browser(target, content, title)  to_target(target, browse(content, title))
#define to_target(target, payload)            target << (payload)

/datum/language
	var/has_written_form = TRUE

/datum/language/aphasia
	has_written_form = FALSE

/datum/language/beachbum
	has_written_form = FALSE

/datum/language/drone
	has_written_form = FALSE

/datum/language/machine
	has_written_form = FALSE

/datum/language/monkey
	has_written_form = FALSE

/datum/language/mushroom
	has_written_form = FALSE

/datum/language/swarmer
	has_written_form = FALSE

/datum/language/xenocommon
	has_written_form = FALSE

/datum/language/xenoknockoff
	has_written_form = FALSE

//This proc strips html properly, remove < > and all text between
//for complete text sanitizing should be used sanitize()
/proc/strip_html_properly(input)
	if(!input)
		return
	var/opentag = 1 //These store the position of < and > respectively.
	var/closetag = 1
	while(1)
		opentag = findtext(input, "<")
		closetag = findtext(input, ">")
		if(closetag && opentag)
			if(closetag < opentag)
				input = copytext(input, (closetag + 1))
			else
				input = copytext(input, 1, opentag) + copytext(input, (closetag + 1))
		else if(closetag || opentag)
			if(opentag)
				input = copytext(input, 1, opentag)
			else
				input = copytext(input, (closetag + 1))
		else
			break

	return input

// T h e   w a l l
/proc/pencode2html(t)
	t = replacetext(t, "\n", "<BR>")
	t = replacetext(t, "\[center\]", "<center>")
	t = replacetext(t, "\[/center\]", "</center>")
	t = replacetext(t, "\[br\]", "<BR>")
	t = replacetext(t, "\[b\]", "<B>")
	t = replacetext(t, "\[/b\]", "</B>")
	t = replacetext(t, "\[i\]", "<I>")
	t = replacetext(t, "\[/i\]", "</I>")
	t = replacetext(t, "\[u\]", "<U>")
	t = replacetext(t, "\[/u\]", "</U>")
	t = replacetext(t, "\[time\]", "[station_time_timestamp()]")
	t = replacetext(t, "\[date\]", "[time2text(world.realtime, "MMM DD")] [GLOB.year_integer+540]")
	t = replacetext(t, "\[large\]", "<font size=\"4\">")
	t = replacetext(t, "\[/large\]", "</font>")
	t = replacetext(t, "\[field\]", "<span class=\"paper_field\"></span>")
	t = replacetext(t, "\[h1\]", "<H1>")
	t = replacetext(t, "\[/h1\]", "</H1>")
	t = replacetext(t, "\[h2\]", "<H2>")
	t = replacetext(t, "\[/h2\]", "</H2>")
	t = replacetext(t, "\[h3\]", "<H3>")
	t = replacetext(t, "\[/h3\]", "</H3>")
	t = replacetext(t, "\[*\]", "<li>")
	t = replacetext(t, "\[hr\]", "<HR>")
	t = replacetext(t, "\[small\]", "<font size = \"1\">")
	t = replacetext(t, "\[/small\]", "</font>")
	t = replacetext(t, "\[list\]", "<ul>")
	t = replacetext(t, "\[/list\]", "</ul>")
	t = replacetext(t, "\[table\]", "<table border=1 cellspacing=0 cellpadding=3 style='border: 1px solid black;'>")
	t = replacetext(t, "\[/table\]", "</td></tr></table>")
	t = replacetext(t, "\[grid\]", "<table>")
	t = replacetext(t, "\[/grid\]", "</td></tr></table>")
	t = replacetext(t, "\[row\]", "</td><tr>")
	t = replacetext(t, "\[cell\]", "<td>")
	t = replacetext(t, "\[logo\]", "<img src = exologo.png>")
	t = replacetext(t, "\[bluelogo\]", "<img src = bluentlogo.png>")
	t = replacetext(t, "\[solcrest\]", "<img src = sollogo.png>")
	t = replacetext(t, "\[torchltd\]", "<img src = exologo.png>")
	t = replacetext(t, "\[iccgseal\]", "<img src = terralogo.png>")
	t = replacetext(t, "\[ntlogo\]", "<img src = ntlogo.png>")
	t = replacetext(t, "\[daislogo\]", "<img src = daislogo.png>")
	t = replacetext(t, "\[eclogo\]", "<img src = eclogo.png>")
	t = replacetext(t, "\[xynlogo\]", "<img src = xynlogo.png>")
	t = replacetext(t, "\[fleetlogo\]", "<img src = fleetlogo.png>")
	t = replacetext(t, "\[sfplogo\]", "<img src = sfplogo.png>")
	t = replacetext(t, "\[editorbr\]", "")
	return t
