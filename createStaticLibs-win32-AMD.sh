#!/bin/bash -x
# this script (C) RJVB is meant to build Perian's FFmpeg version for Win32-shared
# it is supposed to be run on the CLI after building FFmpeg for OS X (i.e. building Perian with XCode)

if [ "$1" = "-check" ] ;then
	TEST="-n"
	shift
else
	TEST=""
fi

if [ "$1" = "-remake" ] ;then
	NOCONFIGURE="yes"
	shift
else
	NOCONFIGURE=""
fi

x86tune="generic"
x86flags=""

CC="gcc"
x86tune=""
x86flags="--param max-completely-peel-times=2"

if [ "$SRCROOT" = "" ] ;then
	cd "`dirname $0`"
	SRCROOT="`pwd`"
fi

MINGPREF="/Developer/Cocotron/1.0/Windows/i386/gcc-4.3.1/bin/i386-mingw32msvc-"
MINGPREF="/usr/local/mingw/32/bin/i686-w64-mingw32-"
CC="${MINGPREF}gcc"

# NB: i686-w64-mingw32 bails on compiling libavcodec/x86/dsputil_mmx.c (operand type mismatch for `cmp'?!)
# but the Cocotron compiler doesn't have that issue. Simply compile that file using Cocotron and the
# arguments given in the failed command, and relaunch this script afterwards.

configureflags="--disable-doc --enable-pthreads --disable-w32threads --enable-runtime-cpudetect \
     --disable-encoders --disable-ffprobe --disable-ffserver --disable-muxers --disable-network --disable-avdevice \
     --disable-swscale --enable-avfilter --target-os=mingw32 --disable-memalign-hack --arch=x86 --enable-libopenjpeg \
	--enable-hwaccels --enable-dxva2 --malloc-prefix=_aligned_ \
	--extra-cflags=-I${SRCROOT}/FFmpeg/win32/include/openjpeg-1.5 \
	--extra-ldflags=-L${SRCROOT}/FFmpeg/win32/lib \
	--enable-cross-compile --cross-prefix=${MINGPREF} \
	--enable-ffprobe --enable-shared --disable-static --disable-stripping --enable-amd3dnow --enable-amd3dnowext"

# 
#cflags="-march=amdfam10 -g -msse2 -msse3 -mssse3 -msse4a -mthreads -m3dnow -arch i386 -Dattribute_deprecated= -w"
# _WIN32_WINNT must be set to >= 0x0600 to activate dxva2 support
cflags="-march=amdfam10 -g -msse2 -msse3 -mssse3 -msse4a -mthreads -m3dnow -m32 -D_WIN32_WINNT=0x0600 -Dattribute_deprecated= -w"

if [ "$BUILD_STYLE" = "Development" ] ; then
    configureflags="$configureflags --disable-optimizations --disable-asm"
	buildid_ffmpeg="${buildid_ffmpeg}Dev"
else
    optcflags="-fweb -fno-tree-vectorize -ftracer -O3 -fexpensive-optimizations -finline-functions -funroll-loops -fstrict-aliasing -finline-limit=1000 -freorder-blocks"
	buildid_ffmpeg="${buildid_ffmpeg}Dep"
fi

if [ "$SRCROOT" = "" ] ;then
	cd "`dirname $0`"
	SRCROOT="`pwd`"
fi
if [ "$BUILT_PRODUCTS_DIR" = "" ] ;then
	BUILT_PRODUCTS_DIR="${SRCROOT}/build"
fi
if [ "$SYMROOT" = "" ] ;then
	SYMROOT="${BUILT_PRODUCTS_DIR}/win32.build"
fi
if [ "${DESTDIR}" = "" ] ;then
	DESTDIR="${SRCROOT}/FFmpeg/win32"
fi

PATH="${PATH}:${DESTDIR}" ; export PATH

BUILD_ID_FILE="${DESTDIR}/buildid"

if [[ -e "$BUILD_ID_FILE" ]] ; then
    oldbuildid_ffmpeg=`cat "$BUILD_ID_FILE"`
else
    oldbuildid_ffmpeg="buildme"
fi

QUICKBUILD="$BUILT_PRODUCTS_DIR/win32/quickbuild"
if [[ -e "$QUICKBUILD" ]] ; then
    oldbuildid_ffmpeg="quick"
    rm "$QUICKBUILD"
fi

buildi386=1

mkdir -p "$BUILT_PRODUCTS_DIR"
mkdir -p "$SYMROOT/win32"

BUILDDIR="$BUILT_PRODUCTS_DIR/winx86"
mkdir -p "$BUILDDIR"

do_exit () {
	if [ $1 != 0 ] ;then
		${CC} --version 2>&1 | line | fgrep '4.7.' > /dev/null
		if [ $? = 0 ] ;then
			echo "Hand-Compile dsputil_mmx.c using an earlier gcc version before calling '$0 -remake', using something like"
			echo "(cd ${BUILDDIR} ; CC -I. -I/Volumes/Debian/Users/bertin/work/src/MacOSX/FFusion-124R/FFmpeg/source -D_ISOC99_SOURCE -D_POSIX_C_SOURCE=200112 -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DHAVE_AV_CONFIG_H -march=amdfam10 -g -msse2 -msse3 -mssse3 -msse4a -mthreads -m3dnow -m32 -D_WIN32_WINNT=0x0600 -Dattribute_deprecated= -w -fweb -fno-tree-vectorize -ftracer -O3 -fexpensive-optimizations -finline-functions -funroll-loops -fstrict-aliasing -finline-limit=1000 -freorder-blocks --param max-completely-peel-times=2 -I/Volumes/Debian/Users/bertin/work/src/MacOSX/FFusion-124R/FFmpeg/win32/include/openjpeg-1.5 -std=c99 -fno-common -fomit-frame-pointer -g -Wdeclaration-after-statement -Wall -Wno-parentheses -Wno-switch -Wdisabled-optimization -Wpointer-arith -Wredundant-decls -Wno-pointer-sign -Wcast-qual -Wwrite-strings -Wtype-limits -Wundef -Wmissing-prototypes -O3 -fno-math-errno -fno-signed-zeros -Werror=implicit-function-declaration -Werror=missing-prototypes -MMD -MF libavcodec/x86/dsputil_mmx.d -MT libavcodec/x86/dsputil_mmx.o -c -o libavcodec/x86/dsputil_mmx.o /Volumes/Debian/Users/bertin/work/src/MacOSX/FFusion-124R/FFmpeg/source/libavcodec/x86/dsputil_mmx.c )"
			echo "for instance with the Cocotron mingw32 compiler, /Developer/Cocotron/1.0/Windows/i386/gcc-4.3.1/bin/i386-mingw32msvc-gcc"
		fi
	fi
	exit $1
}

if [ "$buildid_ffmpeg" = "$oldbuildid_ffmpeg" ] ; then
    echo "Shared ffmpeg libs are up-to-date ; not rebuilding"
else
    echo "Shared ffmpeg libs are out-of-date ; reconfiguring"
    
    echo -n "Configuring "
 
    # files we'd like to keep frame pointers in for in-the-wild debugging
    fptargets="libavformat/avformat.dll libavutil/avutil.dll libavcodec/utils.o"

	configureflags="--prefix=${DESTDIR} --bindir=${DESTDIR}/bin.amd --shlibdir=${DESTDIR}/bin.amd ${configureflags}"
	if [ "$BUILD_STYLE" != "Development" ] ; then
		optcflags_i386="$optcflags $x86flags" 
		if [ "$x86tune" != "" ] ;then
			optcflags_i386="$optcflags_i386 -mtune=$x86tune" 
		fi
	fi

	cd "$BUILDDIR"
	if [ "$oldbuildid_ffmpeg" != "quick" -a "${NOCONFIGURE}" = "" ] ; then
		"$SRCROOT/FFmpeg/source/configure" --extra-ldflags="$cflags" \
			--extra-cflags="$cflags $optcflags_i386" \
			$configureflags || exit 1

		make depend > /dev/null 2>&1 || true
	fi
	cd "${SRCROOT}"

fi

cd "$BUILDDIR"
fpcflags=`grep -m 1 CFLAGS= "$BUILDDIR"/config.mak | sed -e s/CFLAGS=// -e s/-fomit-frame-pointer//` 

make -j3 CFLAGS="$fpcflags" $fptargets ${TEST}
make -j3 ${TEST} || do_exit 1
make -wk install ${TEST}

echo -n "$buildid_ffmpeg" > $BUILD_ID_FILE

FINAL_BUILD_ID_FILE="$SYMROOT/win32/buildid"
if [[ -e "$FINAL_BUILD_ID_FILE" ]] ; then
    oldbuildid_ffmpeg=`cat "$FINAL_BUILD_ID_FILE"`
else
    oldbuildid_ffmpeg="buildme"
fi

if [ "$buildid_ffmpeg" = "$oldbuildid_ffmpeg" ] ; then
    echo "Final ffmpeg libs are up-to-date ; not copying"
else
	cd "${SRCROOT}"
	gcp -p "${BUILDDIR}/config.h" "${DESTDIR}/include/config.h"
	gcp -puv "${BUILDDIR}"/*/*.def "${DESTDIR}/lib"
	gcp -puv "${BUILDDIR}"/*/*.lib "${DESTDIR}/lib"
	rm -rf "${DESTDIR}"/lib/av*.dll.a "${DESTDIR}"/lib/libav*.dll.a "${DESTDIR}/lib/pkgconfig"
	cd "${DESTDIR}/bin.amd"
	find . -type l | xargs rm
	mv avcodec-52.*.dll avcodec-52.dll
	mv avutil-50.*.dll avutil-50.dll
	mv avdevice-52.*.dll avdevice-52.dll
	mv avformat-52.*.dll avformat-52.dll
	mv avcore-0.*.dll avcore-0.dll
	mv avfilter-1.*.dll avfilter-1.dll
	echo "Now run correctDotLibFiles.bat to use MSVC's lib.exe on the .def export files to regenerate the .lib export libraries properly!"
	echo "or do NOT use linker references when building optimised code with MSVC (/OPT:NOREF)"
fi

