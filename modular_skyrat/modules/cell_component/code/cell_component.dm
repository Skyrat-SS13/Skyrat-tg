/*
CELL COMPONENT

What we aim to achieve with cell components is a universal framework for all items that would logically use batteries,
Be it a flashlight, T-ray scanner or multitool. All of them would logically require batteries right? Well, welcome,
to the cell component.

General logic:
Component attaches to parent(flashlight etc)
Registers onhit signal to check if it's being slapped by a battery
Component moves battery to equipment loc, keeps a record, and then communicates with
the equipment and controls the behaviour of said equipment.

If it's a robot, it uses the robot cell - Using certified shitcode.

If you are adding this to an item that is active for a period of time, register signal to COMSIG_CELL_START_USE when it would start using the cell
and COMSIG_CELL_STOP_USE when it should stop. To handle the turning off of said item once the cell is depleted, add your code into the component_cell_out_of_charge proc
using loc where necessary.
*/

/datum/component/cell
	/// Our reference to the inserted cell, which will be stored in nullspace.
	var/obj/item/stock_parts/cell/inserted_cell
	/// The item reference to parent
	var/atom/equipment
	/// How much power do we use each process?
	var/power_use_amount = 50
	/// What signals have been registered to this component - Used for deletion cleanup
	var/list/registered_signals = list()
	/// What signals have been registered to the parent - Used for deletion cleanuo
	var/list/parent_registered_signals = list()
	/// Are we using a robot's powersource?
	var/inside_robot = FALSE

/datum/component/cell/Initialize(cell_override, cell_power_use)
	. = ..()

	if(cell_power_use)
		power_use_amount = cell_power_use

	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	equipment = parent

	if(istype(equipment.loc, /mob/living/silicon/robot)) //Le shitcode for le shitcode robits
		var/mob/living/silicon/robot/robit = equipment.loc
		inserted_cell = robit.cell
		inside_robot = TRUE
	else
		var/obj/item/stock_parts/cell/new_cell
		if(cell_override)
			new_cell = new cell_override()
		else
			new_cell = new /obj/item/stock_parts/cell/crap()
		inserted_cell = new_cell
		new_cell.forceMove(parent)


/datum/component/cell/RegisterWithParent()
	//Component to Parent signal registries
	RegisterSignal(parent, COMSIG_CELL_START_USE, .proc/start_processing_cell)
	RegisterSignal(parent, COMSIG_CELL_STOP_USE, .proc/stop_processing_cell)
	RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/insert_cell)
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND , .proc/remove_cell)
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/examine_cell)
	registered_signals += COMSIG_CELL_START_USE
	registered_signals += COMSIG_CELL_STOP_USE
	registered_signals += COMSIG_PARENT_ATTACKBY
	registered_signals += COMSIG_CLICK_CTRL_SHIFT
	registered_signals += COMSIG_PARENT_EXAMINE
	registered_signals += COMSIG_CELL_SIMPLE_POWER_USE

	//Parent to Component signal registires
	if(istype(parent, /obj/item/flashlight))
		parent.RegisterSignal(src, COMSIG_CELL_OUT_OF_CHARGE, /obj/item/flashlight.proc/turn_off)
		parent.RegisterSignal(src, COMSIG_CELL_REMOVED, /obj/item/flashlight.proc/turn_off)
		parent_registered_signals += COMSIG_CELL_OUT_OF_CHARGE
		parent_registered_signals += COMSIG_CELL_REMOVED


/datum/component/cell/UnregisterFromParent()
	UnregisterSignal(parent, registered_signals)
	if(parent_registered_signals)
		parent.UnregisterSignal(src, parent_registered_signals)

/datum/component/cell/Destroy(force, silent)
	if(inserted_cell)
		if(!inside_robot)
			qdel(inserted_cell)
		inserted_cell = null
	return ..()

/datum/component/cell/proc/simple_power_use(mob/user, use_amount, check_only = FALSE)
	SIGNAL_HANDLER

	if(!use_amount)
		use_amount = power_use_amount

	if(!inserted_cell)
		to_chat(user, "<span class='danger'>There is no cell inside [equipment]</span>")
		return FALSE

	if(check_only && inserted_cell.charge < use_amount)
		SEND_SIGNAL(src, COMSIG_CELL_OUT_OF_CHARGE)
		to_chat(user, "<span class='danger'>The cell inside [equipment] does not have enough charge to perform this action!</span>")
		return FALSE
	else if(!inserted_cell.use(use_amount))
		inserted_cell.update_appearance()
		SEND_SIGNAL(src, COMSIG_CELL_OUT_OF_CHARGE)
		to_chat(user, "<span class='danger'>The cell inside [equipment] does not have enough charge to perform this action!</span>")
		return FALSE

	inserted_cell.update_appearance()

	SEND_SIGNAL(src, COMSIG_CELL_POWER_USED)
	return TRUE

/datum/component/cell/proc/start_processing_cell()
	SIGNAL_HANDLER

	if(!inserted_cell)
		return FALSE

	if(inserted_cell.charge < power_use_amount)
		SEND_SIGNAL(src, COMSIG_CELL_OUT_OF_CHARGE)
		return FALSE

	START_PROCESSING(SSobj, src)
	return TRUE

/datum/component/cell/proc/stop_processing_cell()
	SIGNAL_HANDLER
	STOP_PROCESSING(SSobj, src)

/datum/component/cell/process(delta_time)
	if(!inserted_cell)
		stop_processing_cell()
		return

	if(!inserted_cell.use(power_use_amount))
		cell_out_of_charge()
		return

	inserted_cell.update_appearance()

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

/datum/component/cell/proc/remove_cell(atom/parent_atom, mob/living/carbon/user)
	SIGNAL_HANDLER

	if(!(equipment.loc == user) && !user.is_holding(equipment))
		return

	if(inside_robot)
		return

	if(inserted_cell)
		to_chat(user, "<span class='notice'>You remove [inserted_cell] from [equipment]!</span>")
		playsound(equipment, 'sound/weapons/magout.ogg', 40, TRUE)
		inserted_cell.forceMove(equipment.loc)
		INVOKE_ASYNC(user, /mob/living.proc/put_in_hands, inserted_cell)
		inserted_cell = null
		SEND_SIGNAL(src, COMSIG_CELL_REMOVED)
		stop_processing_cell()
	else
		to_chat(user, "<span class='danger'>There is no cell inserted in [equipment]!</span>")

/datum/component/cell/proc/insert_cell(datum/source, obj/item/inserting_item, mob/living/user, params)
	SIGNAL_HANDLER

	if(!equipment.can_interact(user))
		return

	if(inside_robot)
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
	doubleabattery.forceMove(parent)
