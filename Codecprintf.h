/*
 * Codecprintf.h
 * Created by Augie Fackler on 7/16/06.
 *
 * This file was part of Perian.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with FFmpeg; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

#ifndef CODECPRINTF_H
#define CODECPRINTF_H
#include <stdio.h>
#include <stddef.h>
#include <stdint.h>
#ifdef _MSC_VER
	// prevent the GNU compatibility stdint.h header included with the QuickTime SDK from being included:
#	define _STDINT_H
#endif
#ifdef __MACH__
#	include <QuickTime/QuickTime.h>
#	include "NSLoggerClient.h"
#else
#	include <ConditionalMacros.h>
#	include <Endian.h>
#	include <ImageCodec.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#undef printf
#ifdef _MSC_VER
	extern int ffCodecprintf(FILE *, const char *format, ...);
#else
	int ffCodecprintf(FILE *, const char *format, ...) __attribute__((format (printf, 2, 3)));
#endif
void FourCCprintf(const char *string, FourCharCode a);
const char *FourCCString(FourCharCode c);

void FFMpegCodecprintf(void* ptr, int level, const char* fmt, va_list vl);

#ifdef _NSLOGGERCLIENT_H
#	define Codecprintf(file,form,...)	NSCodecprintf(__FILE__,__LINE__,__FUNCTION__,((file)!=NULL),(form),##__VA_ARGS__)
#else
#	define Codecprintf	ffCodecprintf
#endif

#ifdef __cplusplus
}
#endif
#endif