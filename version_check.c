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
#	include <intrin.h>
#endif
#include <libavcodec/avcodec.h>
#include <libavutil/avutil.h>
#include <libavcore/avcore.h>

#ifdef _MSC_VER
#	define DLLIMPORT	__declspec(dllimport)
#else
#	define DLLIMPORT	/**/
#endif

#if LIBAVCODEC_VERSION_MAJOR > 52 
	extern DLLIMPORT AVCodecParser ff_mpeg4video_parser;
#	define mpeg4video_parser	ff_mpeg4video_parser
#else
	extern DLLIMPORT AVCodecParser mpeg4video_parser;
#endif

#if defined(i386) || defined(__i386__)
#	define REG_b	"ebx"
#	define REG_S	"esi"
#	define cpuid(index,eax,ebx,ecx,edx)\
    __asm__ volatile\
        ("mov %%"REG_b", %%"REG_S"\n\t"\
         "cpuid\n\t"\
         "xchg %%"REG_b", %%"REG_S\
         : "=a" (eax), "=S" (ebx),\
           "=c" (ecx), "=d" (edx)\
         : "0" (index));

#	define cpuid2(func,ax,bx,cx,dx)\
	__asm__ __volatile__ ("cpuid":\
	"=a" (ax), "=b" (bx), "=c" (cx), "=d" (dx) : "a" (func));
#endif

int main( int argc, char *argv[] )
{ const char *license, *configuration;
  unsigned version;
  int cpuFlags;
  AVCodecParser *pp = &mpeg4video_parser;
	fprintf( stderr, "avcodec,avcore,avutil version functions at %p,%p,%p\n",
		avcodec_version, avcore_version, avutil_version );

	version = avcodec_version();
	license = avcodec_license();
	configuration = avcodec_configuration();
	fprintf( stdout, "libavcodec, version %u / \"%s\"\n", version, configuration );
	fprintf( stderr, "            license \"%s\"\n", license );
	fprintf( stderr, "mpeg4video_parser @ %p\n", pp );
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
#if defined(i386) || defined(_MSC_VER)
	{ int val[4];
#ifdef _MSC_VER
	  union { int i[4]; char c[16]; } vendor;
		__cpuid( vendor.i, 0 );
		vendor.c[16] = '\0';
		fprintf( stderr, "CPU vendor: 0x%x,%s ", vendor.i[0], &vendor.c[4] );
		__cpuid( val, 1 );
		fprintf( stderr, "cpuid(1) -> {0x%x,0x%x,0x%x,0x%x}\n", val[0], val[1], val[2], val[3] );
		
		__cpuid( val, 0x80000000 );
		fprintf( stderr, "cpuid(0x80000000) -> {0x%x,0x%x,0x%x,0x%x}\n", val[0], val[1], val[2], val[3] );
#else
	  union { int i[3]; char c[12]; } vendor;
		cpuid( 0, val[0], vendor.i[0], vendor.i[1], vendor.i[2] );
		vendor.c[11] = '\0';
		fprintf( stderr, "CPU vendor: 0x%x,%s ", val[0], vendor.c );
		cpuid( 1, val[0], val[1], val[2], val[3] );
		fprintf( stderr, "cpuid(1) -> {0x%x,0x%x,0x%x,0x%x} ", val[0], val[1], val[2], val[3] );
		cpuid2( 0, val[0], vendor.i[0], vendor.i[1], vendor.i[2] );
		vendor.c[11] = '\0';
		fprintf( stderr, "/\n\t0x%x,%s ", val[0], vendor.c );
		cpuid2( 1, val[0], val[1], val[2], val[3] );
		fprintf( stderr, "cpuid(1) -> {0x%x,0x%x,0x%x,0x%x}\n", val[0], val[1], val[2], val[3] );

		cpuid(0x80000000, val[0], val[1], val[2], val[3]);
		fprintf( stderr, "cpuid(0x80000000) -> {0x%x,0x%x,0x%x,0x%x} ", val[0], val[1], val[2], val[3] );
		cpuid2(0x80000000, val[0], val[1], val[2], val[3]);
		fprintf( stderr, "/ {0x%x,0x%x,0x%x,0x%x}\n", val[0], val[1], val[2], val[3] );
#endif
	}
#endif
	exit(0);
}
