call "c:\Program Files (x86)\VS2010\VC\bin\vcvars32.bat"

echo Correcting import .lib libraries
cd FFmpeg\win32\lib

lib.exe /verbose /machine:i386 /def:avcodec-52.def /out:avcodec-52.lib
lib.exe /verbose /machine:i386 /def:avformat-52.def /out:avformat-52.lib
lib.exe /verbose /machine:i386 /def:avdevice-52.def /out:avdevice-52.lib
lib.exe /verbose /machine:i386 /def:avutil-50.def /out:avutil-50.lib
lib.exe /verbose /machine:i386 /def:avcore-0.def /out:avcore-0.lib
