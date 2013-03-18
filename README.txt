RJVB, 20130127

This is a revival of the old FFusion QuickTime component, updated through the Perian project and extracted from there by RJVB.
It aims to be a decode-only codec leveraging FFmpeg to do the actual work.

For now it is based on libavcodec v52, as is Perian; the goal is to port it to use the current libavcodec, and then
to build it for win32 QuickTime. In hope it'll improve playback performance for mp4, h264, etc. files.

20130318
NB: the .git cache folder was growing out of bounds, so I spent some time pruning and removing the binaries from the github repository.
Those files now reside on SourceForge.net, along with Mac OS X and win32 builds.

Those who already cloned the repository may run into conflicts. I did on my secondary machine, and simply checked out a fresh copy.

After a checkout and in order to build the project you will have to fetch the prebuilt ffmpeg libraries from sourceforge.net :
http://sourceforge.net/projects/ffusion/files/FFmpeg.zip/download
This zip archive contains a win32 directory with the files required for building on MS Windows, and an osx86 directory for building on Mac OS X (10.6+). It also includes the ffmpeg sources (which are already present among your checked out files). 
You’ll only need to extract the bin and lib directories from either the win32 and/or the osx86 directories in the archive.