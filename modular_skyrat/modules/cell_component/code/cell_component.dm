/*
Cell Component

What we aim to achieve with cell components is a universal framework for all items that would logically use batteries,
Be it a flashlight, T-ray scanner or multitool. All of them would logically require batteries right? Well, welcome,
to the cell component.

General logic:
Component attaches to parent(flashlight etc)
Registers onhit signal to check if it's being slapped by a battery
Component moves battery to nullspace, keeps a record, and then communicates with
the equipment and controls the behaviour of said equipment.
*/

/datum/component/cell
	/// Our reference to the inserted cell, which will be stored in nullspace.
	var/obj/item/stock_parts/cell/inserted_cell
	/// The item reference to parent
	var/obj/item/equipment
	/// How much power do we use each process?
	var/power_use_amount = 50
	/// What signals have been registered to this component - Used for deletion cleanup
	var/list/registered_signals = list()

/datum/component/cell/Initialize(...)
	. = ..()

	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	equipment = parent

	var/obj/item/stock_parts/cell/crap/new_cell = new()
	inserted_cell = new_cell
	new_cell.moveToNullspace()

	if(istype(parent, /obj/item/flashlight))
		ComponentSetupFlashlight()

	RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/insert_cell)
	registered_signals += COMSIG_PARENT_ATTACKBY
	RegisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT, .proc/remove_cell)
	registered_signals += COMSIG_CLICK_CTRL_SHIFT
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/examine_cell)
	registered_signals += COMSIG_PARENT_EXAMINE

/datum/component/cell/proc/ComponentSetupFlashlight()
	RegisterSignal(parent, COMSIG_FLASHLIGHT_TOGGLED_ON, .proc/start_processing_cell)
	registered_signals += COMSIG_FLASHLIGHT_TOGGLED_ON
	RegisterSignal(parent, COMSIG_FLASHLIGHT_TOGGLED_OFF, .proc/stop_processing_cell)
	registered_signals += COMSIG_FLASHLIGHT_TOGGLED_OFF
	parent.RegisterSignal(src, COMSIG_CELL_OUT_OF_CHARGE, /obj/item/flashlight.proc/turn_off)
	parent.RegisterSignal(src, COMSIG_CELL_NO_CELL, /obj/item/flashlight.proc/turn_off)

/datum/component/cell/Destroy(force, silent)
	if(inserted_cell)
		qdel(inserted_cell)
		inserted_cell = null

	UnregisterSignal(parent, registered_sginals)

	return ..()

/datum/component/cell/proc/start_processing_cell()
	SIGNAL_HANDLER

	if(!inserted_cell)
		SEND_SIGNAL(src, COMSIG_CELL_NO_CELL)
		return

	if(!inserted_cell.use(power_use_amount))
		SEND_SIGNAL(src, COMSIG_CELL_OUT_OF_CHARGE)
		return

	START_PROCESSING(SSobj, src)

/datum/component/cell/proc/stop_processing_cell()
	SIGNAL_HANDLER
	STOP_PROCESSING(SSobj, src)

/datum/component/cell/process(delta_time)
	if(!inserted_cell)
		stop_processing_cell()
		return

	if(!inserted_cell.use(power_use_amount/delta_time))
		cell_out_of_charge()

/datum/component/cell/proc/cell_out_of_charge()
	SIGNAL_HANDLER

	SEND_SIGNAL(src, COMSIG_CELL_OUT_OF_CHARGE)

	stop_processing_cell()

	equipment.visible_message("[equipment] makes a soft humming noise as it shuts off!")

/datum/component/cell/proc/examine_cell(atom/A, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(!inserted_cell)
		examine_list += "<span class='danger'>It does not have a cell inserted!</span>"
	else
		examine_list += "<span class='notice'>It has [inserted_cell] inserted, charge indicator reading [inserted_cell.charge]."

/datum/component/cell/proc/remove_cell(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!equipment.can_interact(user))
		return

	if(inserted_cell)
		to_chat(user, "<span class='notice'>You remove [inserted_cell] from [equipment]!</span>")
		playsound(equipment, 'sound/weapons/magout.ogg', 40, TRUE)
		inserted_cell.forceMove(equipment.loc)
		INVOKE_ASYNC(user, /mob/living.proc/put_in_hands, inserted_cell)
		inserted_cell = null
		SEND_SIGNAL(src, COMSIG_CELL_NO_CELL)
		stop_processing_cell()
	else
		to_chat(user, "<span class='danger'>There is no cell inserted in [equipment]!</span>")

/datum/component/cell/proc/insert_cell(datum/source, obj/item/inserting_item, mob/living/user, params)
	SIGNAL_HANDLER

	if(!equipment.can_interact(user))
		return

	if(!istype(inserting_item, /obj/item/stock_parts/cell))
		return

	var/obj/item/stock_parts/cell/doubleabattery = inserting_item

	if(inserted_cell)
		to_chat(user, "<span class='danger'>There is alread a cell inserted in [equipment]!")
		return

	to_chat(user, "<span class='notice'>You insert [doubleabattery] into [equipment]!")
	playsound(equipment, 'sound/weapons/magin.ogg', 40, TRUE)
	inserted_cell = doubleabattery
	doubleabattery.moveToNullspace()

/obj/item/flashlight/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/cell)

