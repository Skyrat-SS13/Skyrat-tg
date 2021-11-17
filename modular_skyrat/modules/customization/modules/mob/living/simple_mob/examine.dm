/mob/living/simple_animal/examine(mob/user)
	. = ..()
	//Temporary flavor text addition:
	if(temporary_flavor_text)
		if(length_char(temporary_flavor_text) <= 40)
			. += span_notice("[temporary_flavor_text]")
		else
			. += span_notice("[copytext_char(temporary_flavor_text, 1, 37)]... <a href='?src=[REF(src)];temporary_flavor=1'>More...</a>")
