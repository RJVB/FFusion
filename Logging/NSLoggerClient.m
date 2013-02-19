/*
 *  NSLoggerClient.m
 *  FFusion-RJVB
 *
 *  Created by René J.V. Bertin on 20130210.
 *  Copyright 2013 RJVB. All rights reserved.
 
	C to ObjC bridge to NSLogger functionality
 *
 */

#import <stdarg.h>
#import <Foundation/Foundation.h>
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
	  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		string = [[NSString alloc] initWithFormat:[NSString stringWithUTF8String:format] arguments:ap];
		ret = [string length];
		LogMessageF( fileName, lineNumber, functionName, @"FFusionCodec", level, string );
		[string release];
		[pool drain];
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

void NSCodecFlushLog()
{
	LoggerFlush( NULL, NO );
}

@implementation NSString (NSLoggerClient)
- (void) nsLog:(id)it
{ NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSLog(self);
	[pool drain];
}
@end

int SwitchCocoaToMultiThreadedMode()
{
	if( ![NSThread isMultiThreaded] ){
	  NSString *dum = @"Cocoa is now in multi-threaded mode";
		[NSThread detachNewThreadSelector:@selector(nsLog:) toTarget:dum withObject:nil];
		return 1;
	}
	else{
		return 0;
	}
}