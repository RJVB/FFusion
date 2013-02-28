/*
 *  NSLoggerClient.h
 *  FFusion-RJVB
 *
 *  Created by René J.V. Bertin on 20130210.
 *  Copyright 2013 RJVB. All rights reserved.
 *
 */

#ifndef _NSLOGGERCLIENT_H

extern int NSCodecvprintf( const char *fileName, int lineNumber, const char *functionName, Boolean doLog,
						  const char *item_name, void *avc, int level, const char *format, va_list ap );
extern int NSCodecprintf( const char *fileName, int lineNumber, const char *functionName, Boolean doLog, const char *format, ...);

extern void NSCodecFlushLog();

extern int SwitchCocoaToMultiThreadedMode();

#define _NSLOGGERCLIENT_H
#endif