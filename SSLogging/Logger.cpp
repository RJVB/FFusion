// (C) 20100630 RJVB, INRETS
// SS_Log facility to C interface

#define _LOGGER_INTERNAL_
#include "Logger.h"

#include <stdarg.h>

#ifdef _SS_LOG_ACTIVE
static SS_Log qtLog;
#endif

static DWORD filter = LOGTYPE_LOGTOWINDOW|LOGTYPE_TRACE;

SS_Log *Initialise_Log(char *title, char *progName)
{
#ifdef _SS_LOG_ACTIVE
	qtLog.Filter( filter );
	qtLog.WindowName( title );
	if( progName && *progName ){
		qtLog.ProgName(progName);
	}
	qtLog.EraseLog();
	Log( &qtLog, "%s initalised", title );
	return &qtLog;
#else
	return (SS_Log*) NULL;
#endif
}

void vcWriteLog(SS_Log *pLog, char* pMsg, va_list ap)
{
#ifdef _SS_LOG_ACTIVE
	WriteLog( &qtLog, filter, pMsg, &ap );
#endif
}

void cWriteLog(SS_Log *pLog, char* pMsg, ...)
{ va_list ap;
	va_start( ap, pMsg );
#ifdef _SS_LOG_ACTIVE
	WriteLog( &qtLog, filter, pMsg, &ap );
#endif
	va_end(ap);
}

void cLogStoreFileLine(char* szFile, int nLine)
{
#ifdef _SS_LOG_ACTIVE
	LogStoreFileLine( (TCHAR*) szFile, nLine );
#endif
}