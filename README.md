# GoPro Ruby API Wrapper

A unofficial Ruby API wrapper for controlling GoPro HERO cameras over WiFi.

###Supported cameras:

- HERO4 Black, Silver
- HERO4 Session
- HERO+ / HERO+ LCD
- HERO5 Black, Session

####Planned:

- HERO3/3+


###Usage:

| Code | Explanation |
|------|-------------|
|     gpControlCommand(X,Y) | Sends a command to the camera, using GoPro constants |
|     shutter(Shutter::ON) | Starts a video or takes a picture |
|     camera_mode() | Changes the mode |
