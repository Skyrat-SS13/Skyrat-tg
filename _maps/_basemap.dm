//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

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
		#include "map_files\Blueshift\BlueShift_upper.dmm"
		#include "map_files\Blueshift\BlueShift_middle.dmm"
		#include "map_files\Blueshift\BlueShift_lower.dmm"
		#include "map_files\VoidRaptor\VoidRaptor.dmm"
		#include "map_files\FlotillaStation\FlotillaStation.dmm"
		// SKYRAT EDIT END

		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
