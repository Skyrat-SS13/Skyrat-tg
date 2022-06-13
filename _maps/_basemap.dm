
//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom_skyrat.dmm" //SKYRAT EDIT ADDITION - SMMS

#include "map_files\generic\CentCom_skyrat_z2.dmm" //SKYRAT EDIT ADDITION - SMMS

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\Mining\Lavaland.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\debug\multiz.dmm"
		#include "map_files\Deltastation\DeltaStation2.dmm"
		#include "map_files\KiloStation\KiloStation.dmm"
		#include "map_files\MetaStation\MetaStation.dmm"
		#include "map_files\IceBoxStation\IceBoxStation.dmm"
		#include "map_files\tramstation\tramstation.dmm"
		// SKYRAT EDIT ADDITON START - Compiling our modular maps too!
		#include "map_files\Deltastation\DeltaStation2_skyrat.dmm"
		#include "map_files\KiloStation\KiloStation_skyrat.dmm"
		#include "map_files\MetaStation\MetaStation_skyrat.dmm"
		#include "map_files\IceBoxStation\IceBoxStation_skyrat.dmm"
		#include "map_files\tramstation\tramstation_skyrat.dmm"
		#include "map_files\Blueshift\BlueShift_upper.dmm"
		#include "map_files\Blueshift\BlueShift_middle.dmm"
		#include "map_files\Blueshift\BlueShift_lower.dmm"
		#include "map_files\tramstation\tramstation_skyrat.dmm"
		// The mining maps
		#include "map_files\Mining\Icemoon.dmm"
		#include "map_files\Mining\Rockplanet.dmm"
		#include "map_files\Mining\TidalLock.dmm"
		// SKYRAT EDIT END

		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
