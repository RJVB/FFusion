#!/bin/bash -x
# this script (C) RJVB is meant to build Perian's FFmpeg version for Win32-shared
# it is supposed to be run on the CLI after building FFmpeg for OS X (i.e. building Perian with XCode)

if [ "$1" = "-check" ] ;then
	TEST="-n"
	shift
else
	TEST=""
fi

x86tune="generic"
x86flags=""

CC="gcc"
x86tune=""
x86flags="--param max-completely-peel-times=2"

configureflags="--disable-doc --disable-pthreads --enable-w32threads --enable-runtime-cpudetect \
     --disable-encoders --disable-ffprobe --disable-ffserver --disable-muxers --disable-network \
     --disable-swscale --disable-avfilter --target-os=mingw32 --enable-memalign-hack --arch=x86 \
	--enable-cross-compile --cross-prefix=/Developer/Cocotron/1.0/Windows/i386/gcc-4.3.1/bin/i386-mingw32msvc- \
	--enable-shared --disable-static"

cflags="-g -msse2 -msse3 -arch i386 -Dattribute_deprecated= -w"

if [ "$BUILD_STYLE" = "Development" ] ; then
    configureflags="$configureflags --disable-optimizations --disable-asm"
	buildid_ffmpeg="${buildid_ffmpeg}Dev"
else
    optcflags="-fweb -ftree-vectorize -ftracer -O3 -fexpensive-optimizations -finline-functions -funroll-loops -fstrict-aliasing -finline-limit=1000 -freorder-blocks"
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

if [ "$buildid_ffmpeg" = "$oldbuildid_ffmpeg" ] ; then
    echo "Shared ffmpeg libs are up-to-date ; not rebuilding"
else
    echo "Shared ffmpeg libs are out-of-date ; reconfiguring"
    
    echo -n "Configuring "
 
    # files we'd like to keep frame pointers in for in-the-wild debugging
    fptargets="libavformat/avformat.dll libavutil/avutil.dll libavcodec/utils.o"

	configureflags="--prefix=${DESTDIR} ${configureflags}"
	if [ "$BUILD_STYLE" != "Development" ] ; then
		optcflags_i386="$optcflags $x86flags" 
		if [ "$x86tune" != "" ] ;then
			optcflags_i386="$optcflags_i386 -mtune=$x86tune" 
		fi
	fi

	cd "$BUILDDIR"
	if [ "$oldbuildid_ffmpeg" != "quick" ] ; then
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
make -j3 ${TEST} || exit 1
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
	rm -rf "${DESTDIR}"/lib/*.dll.a "${DESTDIR}/lib/pkgconfig"
	cd "${DESTDIR}/bin"
	find . -type l | xargs rm
	mv avcodec-52.*.dll avcodec-52.dll
	mv avutil-50.*.dll avutil-50.dll
	mv avdevice-52.*.dll avdevice-52.dll
	mv avformat-52.*.dll avformat-52.dll
	mv avcore-0.*.dll avcore-0.dll
	echo "Now run correctDotLibFiles.bat to use MSVC's lib.exe on the .def export files to regenerate the .lib export libraries properly!"
fi

