/atom/proc/do_jiggle(targetangle = 45, timer = 20)
	var/matrix/OM = matrix(transform)
	var/matrix/M = matrix(transform)
	var/halftime = timer * 0.5
	M.Turn(pick(-targetangle, targetangle))
	animate(src, transform = M, time = halftime, easing = ELASTIC_EASING)
	animate(src, transform = OM, time = halftime, easing = ELASTIC_EASING)

/atom/proc/do_squish(squishx = 1.2, squishy = 0.6, timer = 20)
	var/matrix/OM = matrix(transform)
	var/matrix/M = matrix(transform)
	var/halftime = timer * 0.5
	M.Scale(squishx, squishy)
	animate(src, transform = M, time = halftime, easing = BOUNCE_EASING)
	animate(src, transform = OM, time = halftime, easing = BOUNCE_EASING)

/proc/validate_mutant_RGB(color)
	// 19-5-2021: making our customization work with RRGGBB instead of RGB would break every stored character without this. Whelp!
	// This is because of how colors are now stored as RGB, with length 3. They need to become length 6, otherwise handling mutant matrixed color in species.dm breaks.
	// It adds '00' as alpha to the end of the color, which would give it length 5, which readRGB() can't handle.
	if(length(color) == 3)
		color = sanitize_hexcolor(color, 6) // Turn the 3 length RGB into 6 length RRGGBB by duplicating the values.
	return color
