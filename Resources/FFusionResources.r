#define TARGET_REZ_CARBON_MACHO 1
#define thng_RezTemplateVersion 1	// multiplatform 'thng' resource
#define cfrg_RezTemplateVersion 1	// extended version of 'cfrg' resource

#include <Carbon/Carbon.r>
#include <QuickTime/QuickTime.r>
#include "FFusionResourceIDs.h"
#define kStartTHNGResID 128
resource 'dlle' (kDivX1CodecInfoResID) {
        "FFusionCodecComponentDispatch"
};

#define kCodecManufacturer kFFusionCodecManufacturer
#define kCodecVersion kFFusionCodecVersion
#define kEntryPointID kDivX1CodecInfoResID
#define kDecompressionFlags ( codecInfoDoes32 | codecInfoDoes16 | codecInfoDoes8 | codecInfoDoes1 | codecInfoDoesTemporal | cmpThreadSafe )
#define kFormatFlags ( codecInfoDepth32 | codecInfoDepth24 | codecInfoDepth16 | codecInfoDepth8 | codecInfoDepth1 )

#define kCodecInfoResID kDivX1CodecInfoResID
#define kCodecName "MS-MPEG4 v1"

#define kCodecDescription "Decompresses video stored in MS-MPEG4 version 1 format."
#define kCodecSubType 'MPG4'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'mpg4'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'DIV1'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'div1'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kDivX2CodecInfoResID
#define kCodecName "MS-MPEG4 v2"

#define kCodecDescription "Decompresses video stored in MS-MPEG4 version 2 format."
#define kCodecSubType 'MP42'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'mp42'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'DIV2'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'div2'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kDivX3CodecInfoResID
#define kCodecName "DivX 3"

#define kCodecDescription "Decompresses video stored in DivX 3.11 alpha format."
#define kCodecSubType 'MPG3'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'mpg3'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'MP43'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'mp43'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'DIV3'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'div3'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'DIV4'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'div4'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'DIV5'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'div5'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'DIV6'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'div6'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'AP41'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'COL0'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'col0'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'COL1'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'col1'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kDivX4CodecInfoResID
#define kCodecName "DivX 4"

#define kCodecDescription "Decompresses video stored in OpenDivX format."
#define kCodecSubType 'DIVX'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'divx'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'mp4s'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'MP4S'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'M4S2'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'm4s2'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 0x04000000
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'UMP4'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kDivX5CodecInfoResID
#define kCodecName "DivX 5"

#define kCodecDescription "Decompresses video stored in DivX 5 format."
#define kCodecSubType 'DX50'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID k3ivxCodecInfoResID
#define kCodecName "3ivx"

#define kCodecDescription "Decompresses video stored in 3ivx format."
#define kCodecSubType '3IVD'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType '3ivd'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType '3IV2'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType '3iv2'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kXVIDCodecInfoResID
#define kCodecName "Xvid"

#define kCodecDescription "Decompresses video stored in Xvid format."
#define kCodecSubType 'XVID'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'xvid'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'XviD'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'XVIX'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'BLZ0'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kMPEG4CodecInfoResID
#define kCodecName "MPEG-4 (a)"

#define kCodecDescription "Decompresses video stored in MPEG-4 format."
#define kCodecSubType 'RMP4'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'SEDG'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'WV1F'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'FMP4'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'SMP4'
#include "Resources/FFusionResourceInc.r"  

// FIXME: can we do this without claiming Apple's manufacturer (and thus unregistering their decoder)?
#define kCodecManufacturer 'appl'
#define kCodecVersion kFFusionCodecVersion + 0x10
#define kCodecInfoResID kMPEG4CodecInfoResID


#define kCodecDescription "Decompresses video stored in MPEG-4 format."
#define kCodecSubType 'mp4v'
#include "Resources/FFusionResourceInc.r"  

#define kCodecVersion kFFusionCodecVersion
#define kCodecManufacturer kFFusionCodecManufacturer
#define kCodecInfoResID kH264CodecInfoResID
#define kCodecName "H.264 (FFusion)"

#define kCodecDescription "Decompresses video stored in H.264 format."
#define kCodecSubType 'H264'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'h264'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'X264'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'x264'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'DAVC'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'VSSH'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'AVC1'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'avc1'
#include "Resources/FFusionResourceInc.r"

#define kCodecInfoResID kFLV1CodecInfoResID
#define kCodecName "Sorenson H.263"

#define kCodecDescription "Decompresses video stored in Sorenson H.263 format."
#define kCodecSubType 'FLV1'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kFlashSVCodecInfoResID
#define kCodecName "Flash Screen Video"

#define kCodecDescription "Decompresses video stored in Flash Screen Video format."
#define kCodecSubType 'FSV1'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kVP6CodecInfoResID
#define kCodecName "TrueMotion VP6"

#define kCodecDescription "Decompresses video stored in On2 VP6 format."
#define kCodecSubType 'VP60'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'VP61'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'VP62'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kVP6CodecInfoResID


#define kCodecDescription "Decompresses video stored in On2 VP6 format."
#define kCodecSubType 'VP6F'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'FLV4'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kI263CodecInfoResID
#define kCodecName "Intel H.263"

#define kCodecDescription "Decompresses video stored in Intel H.263 format."
#define kCodecSubType 'I263'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'i263'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kVP3CodecInfoResID
#define kCodecName "On2 VP3"

#define kCodecDescription "Decompresses video stored in On2 VP3 format."
#define kCodecSubType 'VP30'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'VP31'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kHuffYUVCodecInfoResID
#define kCodecName "HuffYUV"

#define kCodecDescription "Decompresses video stored in HuffYUV format."
#define kCodecSubType 'HFYU'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kHuffYUVCodecInfoResID


#define kCodecDescription "Decompresses video stored in HuffYUV format."
#define kCodecSubType 'FFVH'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kMPEG1CodecInfoResID
#define kCodecName "MPEG-1"

#define kCodecDescription "Decompresses video stored in MPEG-1 format."
#define kCodecSubType 'MPEG'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'mpg1'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'mp1v'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kMPEG2CodecInfoResID
#define kCodecName "MPEG-2"

#define kCodecDescription "Decompresses video stored in MPEG-2 format."
#define kCodecSubType 'MPG2'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'mpg2'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'mp2v'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kFRAPSCodecInfoResID
#define kCodecName "Fraps"

#define kCodecDescription "Decompresses video stored in Fraps format."
#define kCodecSubType 'FPS1'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kSnowCodecInfoResID
#define kCodecName "Snow"

#define kCodecDescription "Decompresses video stored in Snow format."
#define kCodecSubType 'SNOW'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kNuvCodecInfoResID
#define kCodecName "NuppelVideo"

#define kCodecDescription "Decompresses video stored in NuppelVideo format."
#define kCodecSubType 'RJPG'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'NUV1'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kIndeo2CodecInfoResID
#define kCodecName "Indeo 2"

#define kCodecDescription "Decompresses video stored in Intel's Indeo 2 format."
#define kCodecSubType 'RT21'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kIndeo3CodecInfoResID
#define kCodecName "Indeo 3"

#define kCodecDescription "Decompresses video stored in Intel's Indeo 3 format."
#define kCodecSubType 'IV32'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'iv32'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'IV31'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'iv31'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kIndeo5CodecInfoResID
#define kCodecName "Indeo 5"

#define kCodecDescription "Decompresses video stored in Intel's Indeo 5 format."
#define kCodecSubType 'IV50'
#include "Resources/FFusionResourceInc.r"  
#define kCodecSubType 'iv50'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kTSCCCodecInfoResID
#define kCodecName "Techsmith Screen Capture"

#define kCodecDescription "Decompresses video stored in Techsmith Screen Capture format."
#define kCodecSubType 'tscc'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kZMBVCodecInfoResID
#define kCodecName "DosBox Capture"

#define kCodecDescription "Decompresses video stored in DosBox Capture format."
#define kCodecSubType 'ZMBV'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kVP6ACodecInfoResID
#define kCodecName "On2 VP6A"

#define kCodecDescription "Decompresses video stored in On2 VP6A format."
#define kCodecSubType 'VP6A'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kVP8CodecInfoResID
#define kCodecName "On2 VP8"

#define kCodecDescription "Decompresses video stored in On2 VP8 format."
#define kCodecSubType 'VP80'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kFFv1CodecInfoResID
#define kCodecName "FFv1"

#define kCodecDescription "Decompresses video stored in FFv1 format."
#define kCodecSubType 'FFV1'
#include "Resources/FFusionResourceInc.r"  

#define kCodecInfoResID kCompressMP3CodecResourceID
#define kCodecName "MP3"

#define kCodecDescription "Decompresses compressed video stream stored in MPEG-4 format."
#define kCodecSubType kCompressedMP3
#include "Resources/FFusionResourceInc.r"  
