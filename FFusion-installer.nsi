; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "FFusion"
!define PRODUCT_VERSION "1.25"
!define PRODUCT_PUBLISHER "RJVB"
!define PRODUCT_WEB_SITE "http://rjvbertin.free.fr"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\QTVODm2.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_STARTMENU_REGVAL "NSIS:StartMenuDir"

;!define SF_SELECTED   1
;!define SF_SUBSEC     2
;!define SF_SUBSECEND  4
;!define SF_BOLD       8
;!define SF_RO         16
;!define SF_EXPAND     32

;!define SECTION_OFF   0xFFFFFFFE

SetCompressor lzma
ShowInstDetails show

; MUI 1.67 compatible ------
!include "MUI.nsh"
;!include "FontRegAdv.nsh"
;!include "FontName.nsh"
!include "winmessages.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

;--------------------------------
;Interface Configuration

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "S:\MacOSX\FFusion-124R\Resources\Perian_icon.bmp"

; Language Selection Dialog Settings
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Welcome page
;Request application privileges for Windows Vista
RequestExecutionLevel admin

; setting env.vars:
!define env_hklm 'HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"'


var QTDIR

 
; Welcome page
!insertmacro MUI_PAGE_WELCOME
Page Custom LockedListShow
; Components page
Function LockedListShow
  !insertmacro MUI_HEADER_TEXT "$(KillProcs1)" "$(KillProcs2)"
  LockedList::AddModule "QTVODm2.exe"
  LockedList::AddModule "\FFusion.qtx"
  LockedList::AddModule "\avcodec-52.dll"
  LockedList::AddModule "\avutil-50.dll"
  LockedList::AddModule "\avcore-0.dll"
  LockedList::AddModule "\libopenjpeg-1.dll"
  LockedList::Dialog /autonext /autoclose "" "" "" ""
    pop $R0
FunctionEnd

Section
SectionEnd

!insertmacro MUI_PAGE_COMPONENTS
; Directory page
;!define MUI_PAGE_CUSTOMFUNCTION_PRE dirPre
;!insertmacro MUI_PAGE_DIRECTORY

; Start menu page
;var ICONS_GROUP
;!define MUI_STARTMENUPAGE_NODISABLE
;!define MUI_STARTMENUPAGE_DEFAULTFOLDER "FFusion"
;!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
;!define MUI_STARTMENUPAGE_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
;!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${PRODUCT_STARTMENU_REGVAL}"
;!insertmacro MUI_PAGE_STARTMENU Application $ICONS_GROUP

; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "French"
!insertmacro MUI_LANGUAGE "English"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "FFusion-v${PRODUCT_VERSION}-installer.exe"
InstallDir "$TEMP"
;InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

; AddBrandingImage left 128

LangString Name ${LANG_ENGLISH} "English"
LangString Name ${LANG_FRENCH} "French"
LangString Sec2Name ${LANG_ENGLISH} "FFusion Codec QuickTime Component"
LangString Sec2Name ${LANG_FRENCH} "Composante QuickTime FFusion Codec"
LangString Sec1Descr ${LANG_ENGLISH} "The QuickTime Codec FFusion that uses FFmpeg's libavcodec to play back a range of codecs, including mp4v and H264. Installs in $QTDIR QTComponents"
LangString Sec1Descr ${LANG_FRENCH} "Le 'QuickTime Codec' FFusion qui utilise libavcodec de FFmpeg pour jouer une vari�t� de codecs dont mp4v et H264.  s'Installe dans $QTDIR QTComponents"
LangString Sec2Descr ${LANG_ENGLISH} "FFmpeg libraries (avcodec,avutil,avcore) optimised for recent Intel CPUs ($QTDIR QTSystem)"
LangString Sec2Descr ${LANG_FRENCH} "Libraries FFmpeg (avcodec,avutil,avcore) optimis�es pour CPUs Intel r�cents ($QTDIR QTSystem)"
LangString Sec3Descr ${LANG_ENGLISH} "FFmpeg libraries (avcodec,avutil,avcore) optimised for recent AMD CPUs ($QTDIR QTSystem)"
LangString Sec3Descr ${LANG_FRENCH} "Libraries FFmpeg (avcodec,avutil,avcore) optimis�es pour CPUs AMD r�cents ($QTDIR QTSystem)"
LangString QI2Mfail  ${LANG_ENGLISH} "could not be installed; to be copied manually into"
LangString QI2Mfail  ${LANG_FRENCH} "echec d'installation, � copier � la main dans"
LangString DirSelectSText  ${LANG_ENGLISH} "Install dir (FFusion will go into $QTDIR QTComponents!)"
LangString DirSelectSText  ${LANG_FRENCH} "R�pertoire d'installation (FFusion ira dans $QTDIR QTComponents!)"
LangString AuthorText  ${LANG_ENGLISH} "FFusion � 2002-2003 Jerome Cornet; -2011 Perian; 2013 R.J.V. Bertin"
LangString AuthorText  ${LANG_FRENCH} "FFusion � 2002-2003 Jerome Cornet; -2011 Perian; 2013 R.J.V. Bertin"
LangString KillProcs1   ${LANG_ENGLISH} "Please wait"
LangString KillProcs1   ${LANG_FRENCH} "Merci de patienter"
LangString KillProcs2   ${LANG_ENGLISH} "Verifying running processes"
LangString KillProcs2   ${LANG_FRENCH} "Verification des processus en cours d'execution"

;DirText "" "$(DirSelectSText)"

ComponentText "$(AuthorText)"

Section "QuickTime FFusion Codec Component" SEC01
  SetRegView 32
;  ReadRegStr $0 HKLM "SOFTWARE\Apple Computer, Inc.\QuickTime" "InstallDir"
;  IfErrors 0 +2
;           Abort "QuickTime is required"
  DetailPrint "QuickTime is installed in $QTDIR"
  KillProcDLL::KillProc "QuickTimePlayer.exe"
  DetailPrint "KillProc QuickTimePlayer returned $R0"
  KillProcDLL::KillProc "QTVODm2.exe"
  DetailPrint "KillProc QTVODm2 returned $R0"
  KillProcDLL::KillProc "Safari.exe"
  DetailPrint "KillProc Safari returned $R0"
  SetOutPath "$QTDIR\QTComponents"
  SetOverwrite ifnewer
  File "S:\MacOSX\FFusion-124R\Release\FFusion.qtx"
  IfErrors 0 +2
           MessageBox MB_ICONEXCLAMATION|MB_OK "FFusion.qtx $(QI2Mfail) $QTDIR\QTComponents"
;  Sleep 1000
SectionEnd

Section "FFmpeg Libraries, Intel" SEC02
  SetRegView 32
;  ReadRegStr $0 HKLM "SOFTWARE\Apple Computer, Inc.\QuickTime" "InstallDir"
;  IfErrors 0 +2
;           Abort "QuickTime is required"
  DetailPrint "QuickTime is installed in $QTDIR"
  KillProcDLL::KillProc "QuickTimePlayer.exe"
  DetailPrint "KillProc QuickTimePlayer returned $R0"
  KillProcDLL::KillProc "QTVODm2.exe"
  DetailPrint "KillProc QTVODm2 returned $R0"
  KillProcDLL::KillProc "Safari.exe"
  DetailPrint "KillProc Safari returned $R0"
  SetOutPath "$QTDIR\QTSystem"
  SetOverwrite ifnewer
  File "s:\MacOSX\FFusion-124R\FFmpeg\win32\bin\avcodec-52.dll"
  File "s:\MacOSX\FFusion-124R\FFmpeg\win32\bin\avutil-50.dll"
  File "s:\MacOSX\FFusion-124R\FFmpeg\win32\bin\avcore-0.dll"
  File "s:\MacOSX\FFusion-124R\FFmpeg\win32\bin\libopenjpeg-1.dll"
  File "s:\MacOSX\FFusion-124R\FFmpeg\source\FFmpeg-LICENSE.txt"
  File "s:\MacOSX\FFusion-124R\LICENSE-libopenjpeg1.txt"
SectionEnd

Section "FFmpeg Libraries, AMD" SEC03
  SetRegView 32
;  ReadRegStr $0 HKLM "SOFTWARE\Apple Computer, Inc.\QuickTime" "InstallDir"
;  IfErrors 0 +2
;           Abort "QuickTime is required"
  DetailPrint "QuickTime is installed in $QTDIR"
  KillProcDLL::KillProc "QuickTimePlayer.exe"
  DetailPrint "KillProc QuickTimePlayer returned $R0"
  KillProcDLL::KillProc "QTVODm2.exe"
  DetailPrint "KillProc QTVODm2 returned $R0"
  KillProcDLL::KillProc "Safari.exe"
  DetailPrint "KillProc Safari returned $R0"
  SetOutPath "$QTDIR\QTSystem"
  SetOverwrite ifnewer
  File "s:\MacOSX\FFusion-124R\FFmpeg\win32\bin.amd\avcodec-52.dll"
  File "s:\MacOSX\FFusion-124R\FFmpeg\win32\bin.amd\avutil-50.dll"
  File "s:\MacOSX\FFusion-124R\FFmpeg\win32\bin.amd\avcore-0.dll"
  File "s:\MacOSX\FFusion-124R\FFmpeg\source\FFmpeg-LICENSE.txt"
  File "s:\MacOSX\FFusion-124R\FFmpeg\win32\bin\libopenjpeg-1.dll"
  File "s:\MacOSX\FFusion-124R\LICENSE-libopenjpeg1.txt"
SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} $(Sec1Descr)
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} $(Sec2Descr)
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC03} $(Sec3Descr)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
  SetAutoClose false
  SetRegView 32
  ReadRegStr $0 HKLM "SOFTWARE\Apple Computer, Inc.\QuickTime" "InstallDir"
  IfErrors 0 +3
           MessageBox MB_ICONEXCLAMATION|MB_OK "QuickTime is required. http://www.apple.com/quicktime/download"
           Abort "QuickTime is required. http://www.apple.com/quicktime/download "
  StrCpy $QTDIR $0
  DetailPrint "QuickTime is installed in $QTDIR"
;  MessageBox MB_ICONEXCLAMATION|MB_OK "QuickTime is installed in $QTDIR"
; from http://nsis.sourceforge.net/Mutually_Exclusive_Sections :
	Push $0

	StrCpy $R9 ${SEC02} ; Gotta remember which section we are at now...
	SectionGetFlags ${SEC02} $0
	IntOp $0 $0 | ${SF_SELECTED}
	SectionSetFlags ${SEC02} $0

	SectionGetFlags ${SEC03} $0
	IntOp $0 $0 & ${SECTION_OFF}
	SectionSetFlags ${SEC03} $0

	Pop $0
FunctionEnd

Function .onSelChange
	Push $0

	StrCmp $R9 ${SEC02} check_SEC02

	SectionGetFlags ${SEC02} $0
	IntOp $0 $0 & ${SF_SELECTED}
	IntCmp $0 ${SF_SELECTED} 0 done done
		StrCpy $R9 ${SEC02}
		SectionGetFlags ${SEC03} $0
		IntOp $0 $0 & ${SECTION_OFF}
		SectionSetFlags ${SEC03} $0

	Goto done

	check_SEC02:

	SectionGetFlags ${SEC03} $0
	IntOp $0 $0 & ${SF_SELECTED}
	IntCmp $0 ${SF_SELECTED} 0 done done
		StrCpy $R9 ${SEC03}
		SectionGetFlags ${SEC02} $0
		IntOp $0 $0 & ${SECTION_OFF}
		SectionSetFlags ${SEC02} $0

	done:

	Pop $0
FunctionEnd



Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
!insertmacro MUI_UNGETLANGUAGE
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

;Section Uninstall
;  !insertmacro MUI_STARTMENU_GETFOLDER "Application" $ICONS_GROUP
;  Delete "$INSTDIR\uninst.exe"
;  Delete "$INSTDIR\QTImage2Mov-v1.1.pdf"
;  Delete "$INSTDIR\QTImage2Mov.qtx"
;  Delete "$INSTDIR\QTilities-v1.2.pdf"
;  Delete "$INSTDIR\POSIXm2.dll"
;  Delete "$INSTDIR\QTils.dll"
;  Delete "$INSTDIR\VODdesign.xml"
;  Delete "$INSTDIR\LanceQTVODm2.bat"
;  Delete "$INSTDIR\QTVODm2.exe"
;
;  Delete "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk"
;
;  RMDir "$SMPROGRAMS\$ICONS_GROUP"
;  RMDir "$INSTDIR"
;
;  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
;  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
;  SetAutoClose true
;SectionEnd
