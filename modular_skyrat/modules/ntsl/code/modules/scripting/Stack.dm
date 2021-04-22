/stack
	var/list
		contents=new
/stack/proc/Push(value)
	contents+=value

/stack/proc/Pop()
	if(!contents.len) return null
	. = contents[contents.len]
	contents.len--

/stack/proc/Top() //returns the item on the top of the stack without removing it
	if(!contents.len) return null
	return contents[contents.len]

/stack/proc/Copy()
	var/stack/S=new()
	S.contents=src.contents.Copy()
	return S

/stack/proc/Clear()
	contents.Cut()
