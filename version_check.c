/*
 *  version_check.c
 *  FFusion
 *
 *  Created by René J.V. Bertin on 20130125.
 *  Copyright 2013 Perian. All rights reserved.
 *
 */


#include <stdio.h>
#include <stddef.h>
#ifdef _MSC_VER
#	define inline	__inline
#endif
#include <libavcodec/avcodec.h>
#include <libavutil/avutil.h>
#include <libavcore/avcore.h>

int main( int argc, char *argv[] )
{ const char *license, *configuration;
  unsigned version;
  int cpuFlags;
	fprintf( stderr, "avcodec,avcore,avutil version functions at %p,%p,%p\n",
		avcodec_version, avcore_version, avutil_version );

	version = avcodec_version();
	license = avcodec_license();
	configuration = avcodec_configuration();
	fprintf( stdout, "libavcodec, version %u / \"%s\"\n", version, configuration );
	fprintf( stderr, "            license \"%s\"\n", license );
	fflush(stderr), fflush(stdout);

	version = avcore_version();
	license = avcore_license();
	configuration = avcore_configuration();
	fprintf( stdout, "libavcore, version %u / \"%s\"\n", version, configuration );
	fprintf( stderr, "           license \"%s\"\n", license );
	fflush(stderr), fflush(stdout);

	version = avutil_version();
	license = avutil_license();
	configuration = avutil_configuration();
	fprintf( stdout, "libavutil, version %u / \"%s\"\n", version, configuration );
	fprintf( stderr, "           license \"%s\"\n", license );
	fflush(stderr), fflush(stdout);

	cpuFlags = av_get_cpu_flags();
	fprintf( stdout, "Extensions supported by the current CPU:\n" );

	if( cpuFlags & AV_CPU_FLAG_FORCE ){
		fputs( "Force usage of selected flags\n", stdout );
	}

	if( cpuFlags & AV_CPU_FLAG_MMX ){
		fputs( "MMX\n", stdout );
	}
	if( cpuFlags & AV_CPU_FLAG_MMX2 ){
		fputs( "MMX2\n", stdout );
	}
	if( cpuFlags & AV_CPU_FLAG_3DNOW ){
		fputs( "3DNOW\n", stdout );
	}
	if( cpuFlags & AV_CPU_FLAG_SSE ){
		fputs( "SSE\n", stdout );
	}
	if( cpuFlags & AV_CPU_FLAG_SSE2 ){
		fputs( "SSE2\n", stdout );
	}
	if( cpuFlags & AV_CPU_FLAG_SSE2SLOW ){
		fputs( "SSE2SLOW\n", stdout );
	}
	if( cpuFlags & AV_CPU_FLAG_3DNOWEXT ){
		fputs( "3DNOWEXT\n", stdout );
	}
	if( cpuFlags & AV_CPU_FLAG_SSE3 ){
		fputs( "SSE3\n", stdout );
	}
	if( cpuFlags & AV_CPU_FLAG_SSE3SLOW ){
		fputs( "SSE3SLOW\n", stdout );
	}
	if( cpuFlags & AV_CPU_FLAG_SSSE3 ){
		fputs( "SSSE3\n", stdout );
	}
	if( cpuFlags & AV_CPU_FLAG_SSE4 ){
		fputs( "SSE4\n", stdout );
	}
	if( cpuFlags & AV_CPU_FLAG_SSE42 ){
		fputs( "SSE42\n", stdout );
	}
	if( cpuFlags & AV_CPU_FLAG_IWMMXT ){
		fputs( "IWMMXT\n", stdout );
	}
// "standard" => always set even if not on a G4 or G5 cpu?!
// 	if( cpuFlags & AV_CPU_FLAG_ALTIVEC ){
// 		fputs( "ALTIVEC\n", stdout );
// 	}

	exit(0);
}
