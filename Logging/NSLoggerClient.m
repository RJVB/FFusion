/*
 *  NSLoggerClient.m
 *  FFusion-RJVB
 *
 *  Created by René J.V. Bertin on 20130210.
 *  Copyright 2013 RJVB. All rights reserved.
 
	C to ObjC bridge to NSLogger functionality
 *
 */

#import "NSLoggerClient.h"
#import "LoggerClient.h"

int NSCodecvprintf( const char *fileName, int lineNumber, const char *functionName, Boolean doLog,
				   int level, const char *format, va_list ap )
{ NSString *string;
  int ret = 0;
  static char inited = 0;
	if( !inited ){
		LoggerSetOptions( NULL, kLoggerOption_BufferLogsUntilConnection|kLoggerOption_BrowseBonjour|kLoggerOption_CaptureSystemConsole );
		inited = 1;
	}
	if( doLog ){
		string = [[NSString alloc] initWithFormat:[NSString stringWithUTF8String:format] arguments:ap];
		ret = [string length];
		LogMessageF( fileName, lineNumber, functionName, @"FFusionCodec", level, string );
		[string release];
	}
	return ret;
}

int NSCodecprintf( const char *fileName, int lineNumber, const char *functionName, Boolean doLog, const char *format, ...)
{ va_list ap;
  int ret = 0;
	va_start(ap, format);
	ret = NSCodecvprintf( fileName, lineNumber, functionName, doLog, 0, format, ap );
	va_end(ap);
	return ret;
}
