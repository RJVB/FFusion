#!/bin/sh -x
# this script (C) RJVB is meant to build Perian's FFmpeg version for Win32-shared
# it is supposed to be run on the CLI after building FFmpeg for OS X (i.e. building Perian with XCode)

x86tune="generic"
x86flags=""

CC="gcc"
x86tune=""
x86flags="--param max-completely-peel-times=2"

configureflags="--disable-doc --disable-amd3dnow --disable-pthreads --enable-w32threads --enable-runtime-cpudetect \
     --disable-encoders --disable-ffprobe --disable-ffserver --disable-muxers --disable-network \
     --disable-swscale --disable-avfilter --target-os=mingw32 --enable-memalign-hack --arch=x86 \
	--enable-cross-compile --cross-prefix=/Developer/Cocotron/1.0/Windows/i386/gcc-4.3.1/bin/i386-mingw32msvc- \
	--enable-shared --disable-static"

cflags="-g -O3 -fexpensive-optimizations -finline-functions -funroll-loops \
	-fstrict-aliasing -ftree-vectorize -msse2 -msse3 -arch i386 -Dattribute_deprecated= -w"

if [ "$BUILD_STYLE" = "Development" ] ; then
    configureflags="$configureflags --disable-optimizations --disable-asm"
	buildid_ffmpeg="${buildid_ffmpeg}Dev"
else
    optcflags="-fweb -fstrict-aliasing -finline-limit=1000 -freorder-blocks"
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

BUILD_ID_FILE="$BUILT_PRODUCTS_DIR/win32/buildid"

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

if [ "$buildid_ffmpeg" = "$oldbuildid_ffmpeg" ] ; then
    echo "Static ffmpeg libs are up-to-date ; not rebuilding"
else
    echo "Static ffmpeg libs are out-of-date ; rebuilding"
    
# 	   if [ -e ffmpeg/patched ] ; then
# 		cd ffmpeg && svn revert -R . && rm patched && cd ..
# 	fi
# 
# 	cd ffmpeg
# 	patch -p1 < ../Patches/0001-Disable-some-parts-of-h264.c-Perian-never-uses.patch
# 	##patch -p1 < ../Patches/0002-Use-faltivec-instead-of-maltivec.patch
# 	patch -p1 < ../Patches/0003-Remove-the-warning-Cannot-parallelize-deblocking-typ.patch
# 	##patch -p1 < ../Patches/0004-Hardcode-results-of-runtime-cpu-detection-in-dsputil.patch
# 	patch -p1 < ../Patches/0005-Double-INTERNAL_BUFFER_SIZE-to-fix-running-out-of-bu.patch
# 	patch -p1 < ../Patches/0006-Workaround-for-AVI-audio-tracks-importing-1152x-too-.patch
# 	cd ..
# 
# 	touch ffmpeg/patched
# 
    echo -n "Building "
    
    mkdir -p "$BUILT_PRODUCTS_DIR"
    mkdir -p "$SYMROOT/win32"

    # files we'd like to keep frame pointers in for in-the-wild debugging
    fptargets="libavformat/avformat.dll libavutil/avutil.dll libavcodec/utils.o"
	
    #######################
    # Intel shlibs
    #######################
        BUILDDIR="$BUILT_PRODUCTS_DIR/winx86"
        mkdir -p "$BUILDDIR"

	configureflags="--prefix=${BUILT_PRODUCTS_DIR}/win32 ${configureflags}"
	if [ "$BUILD_STYLE" != "Development" ] ; then
        	optcflags_i386="$optcflags $x86flags" 
		if [ "$x86tune" != "" ] ;then
			optcflags_i386="$optcflags_i386 -mtune=$x86tune" 
		fi
        fi

        cd "$BUILDDIR"
        if [ "$oldbuildid_ffmpeg" != "quick" ] ; then
		 "$SRCROOT/ffmpeg/configure" --extra-ldflags="$cflags" \
		 --extra-cflags="$cflags $optcflags_i386" \
		 $configureflags || exit 1
        
            make depend > /dev/null 2>&1 || true
        fi
        
        fpcflags=`grep -m 1 CFLAGS= "$BUILDDIR"/config.mak | sed -e s/CFLAGS=// -e s/-fomit-frame-pointer//` 

        make -j3 CFLAGS="$fpcflags" $fptargets
        make -j3 || exit 1
	   make -wk install

	#######################
	# lipo/copy shlibs
	#######################
	BUILDDIR="$BUILT_PRODUCTS_DIR/win32"
	INTEL="$BUILT_PRODUCTS_DIR/winx86"
	
	#rm -rf "$BUILDDIR"
	#mkdir "$BUILDDIR"

	archDir="i386"
	BUILDARCHDIR=$INTEL
	# just copy them
# 	for aa in "$BUILDARCHDIR"/*/*.a ; do
# 		echo cp "$aa" `echo -n $aa | sed 's/'$archDir'\/.*\//win32\//'`
# 		cp "$aa" `echo -n $aa | sed 's/'$archDir'\/.*\//win32\//'`
# 	done
	echo -n "$buildid_ffmpeg" > $BUILD_ID_FILE
fi

FINAL_BUILD_ID_FILE="$SYMROOT/win32/buildid"
if [[ -e "$FINAL_BUILD_ID_FILE" ]] ; then
    oldbuildid_ffmpeg=`cat "$FINAL_BUILD_ID_FILE"`
else
    oldbuildid_ffmpeg="buildme"
fi

if [ "$buildid_ffmpeg" = "$oldbuildid_ffmpeg" ] ; then
    echo "Final static ffmpeg libs are up-to-date ; not copying"
else
	cp "$BUILT_PRODUCTS_DIR/win32"/* "$SYMROOT/win32"
fi
