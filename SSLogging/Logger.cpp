// (C) 20100630 RJVB, INRETS
// SS_Log facility to C interface

#define _LOGGER_INTERNAL_
#include "Logger.h"

#include <stdarg.h>

#ifdef _SS_LOG_ACTIVE
static SS_Log qtLog;
#endif

static DWORD filter = LOGTYPE_LOGTOWINDOW|LOGTYPE_TRACE;

#ifdef _SS_LOG_ACTIVE
SS_Log *Initialise_Log(char *title, char *progName)
{
	qtLog.Filter( filter );
	qtLog.WindowName( title );
	if( progName && *progName ){
		qtLog.ProgName(progName);
	}
	qtLog.EraseLog();
	Log( &qtLog, "%s initalised", title );
	return &qtLog;
}

void vcWriteLog(SS_Log *pLog, char* pMsg, va_list ap)
{
	WriteLog( &qtLog, filter, pMsg, &ap );
}

void cWriteLog(SS_Log *pLog, char* pMsg, ...)
{ va_list ap;
	va_start( ap, pMsg );
	WriteLog( &qtLog, filter, pMsg, &ap );
	va_end(ap);
}

void cLogStoreFileLine(char* szFile, int nLine)
{
	LogStoreFileLine( (TCHAR*) szFile, nLine );
}
#endif
