#!/bin/bash -x
# this script (C) RJVB is meant to build Perian's FFmpeg version for osx86-shared
# it is supposed to be run on the CLI after building FFmpeg for OS X (i.e. building Perian with XCode)

if [ "$1" = "-check" ] ;then
	TEST="-n"
	shift
else
	TEST=""
fi 

x86tune="generic"
x86flags=""

if [ -e /usr/bin/gcc-4.2 ]; then
	CC="gcc-4.2"
	x86tune="core2"
	x86flags="--param max-completely-peel-times=2"
fi

if [ "$MACOSX_DEPLOYMENT_TARGET" = "" ]; then
	MACOSX_DEPLOYMENT_TARGET="10.6"
fi

configureflags="--cc=$CC --disable-amd3dnow --disable-doc --disable-encoders \
     --enable-ffprobe --disable-ffserver --disable-muxers --disable-network --enable-libopenjpeg \
	--extra-cflags=-I/opt/local/include --extra-ldflags=-L/opt/local/lib \
     --enable-swscale --enable-avfilter --disable-avdevice --enable-ffmpeg --target-os=darwin"

cflags="-mmacosx-version-min=$MACOSX_DEPLOYMENT_TARGET \
        -D__DARWIN_UNIX03=0 -Dattribute_deprecated= -w -msse3 -msse4 -mssse3"

if [ "$BUILD_STYLE" = "Development" ] ; then
    configureflags="$configureflags --disable-optimizations --disable-asm"
	buildid_ffmpeg="${buildid_ffmpeg}Dev"
else
    optcflags="-fweb -fstrict-aliasing -finline-limit=1000 -freorder-blocks -O3 -finline-functions -funroll-loops -ftree-vectorize -ftracer"
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
	SYMROOT="${BUILT_PRODUCTS_DIR}/osx86.build"
fi
if [ "${DESTDIR}" = "" ] ;then
	DESTDIR="${SRCROOT}/FFmpeg/osx86"
fi

PATH="${PATH}:${DESTDIR}" ; export PATH

BUILD_ID_FILE="${DESTDIR}/buildid"

if [[ -e "$BUILD_ID_FILE" ]] ; then
    oldbuildid_ffmpeg=`cat "$BUILD_ID_FILE"`
else
    oldbuildid_ffmpeg="buildme"
fi

QUICKBUILD="$BUILT_PRODUCTS_DIR/Universal/quickbuild"
if [[ -e "$QUICKBUILD" ]] ; then
    oldbuildid_ffmpeg="quick"
    rm "$QUICKBUILD"
fi

   buildi386=1

mkdir -p "$BUILT_PRODUCTS_DIR"
mkdir -p "$SYMROOT/osx86"

BUILDDIR="$BUILT_PRODUCTS_DIR/osx86"
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
        	optcflags_i386="$optcflags -mdynamic-no-pic -mtune=$x86tune $x86flags" 
        fi

        cd "$BUILDDIR"
        if [ "$oldbuildid_ffmpeg" != "quick" ] ; then
            if [ "$arch" = ppc ] ; then
                "$SRCROOT/FFmpeg/source/configure" --enable-cross-compile --arch=i386 \
                --cpu=core2 --extra-ldflags="$cflags -arch i386" \
                --extra-cflags="-arch i386 $cflags $optcflags_i386" $configureflags || exit 1
            else
                "$SRCROOT/FFmpeg/source/configure" --extra-ldflags="$cflags -arch i386" \
                --cpu=core2 --extra-cflags="-arch i386 $cflags $optcflags_i386" \
                $configureflags || exit 1
            fi
        
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

FINAL_BUILD_ID_FILE="$SYMROOT/osx86/buildid"
if [[ -e "$FINAL_BUILD_ID_FILE" ]] ; then
    oldbuildid_ffmpeg=`cat "$FINAL_BUILD_ID_FILE"`
else
    oldbuildid_ffmpeg="buildme"
fi

if [ "$buildid_ffmpeg" = "$oldbuildid_ffmpeg" ] ; then
    echo "Final static ffmpeg libs are up-to-date ; not copying"
else
	cd "${SRCROOT}"
	gcp -p "${BUILDDIR}/config.h" "${DESTDIR}/include/config.h"
	gcp -puv "${BUILDDIR}"/*/*.def "${DESTDIR}/lib"
	gcp -puv "${BUILDDIR}"/*/*.lib "${DESTDIR}/lib"
fi
