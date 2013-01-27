RJVB, 20130127

This is the old FFusion QuickTime component, updated through the Perian project and extracted from there by RJVB.
It aims to be a decode-only codec leveraging FFmpeg to do the actual work.

For now it is based on libavcodec v52, as is Perian; the goal is to port it to use the current libavcodec, and then
to build it for win32 QuickTime. In hope it'll improve playback performance for mp4, h264, etc. files.
