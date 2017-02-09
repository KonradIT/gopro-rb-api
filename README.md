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
|     shutter(param) | Starts a video or takes a picture, param can be Shutter::ON or Shutter:OFF |
|     camera_mode(X,Y) | Changes the mode, X=Mode, Y=Submode. Example: camera_mode(Mode::PhotoMode, Mode::SubMode::Photo::Single) |
|     status_raw() | Returns the status dump of the camera in json |
|     status(X,Y) | Returns the status, needs: y=status/setting y=status id. |
|     overview() | Prints a human-readable overview |
|     delete() | Can be: delete(all) or delete(all) |
|     hilight() | HiLights a moment in the video recording |
|     power_on() | Powers the camera on. NOTE: run this to put your H4 Session into app mode first! |
|     power_off() | Powers the camera off |
|     sync_time() | Syncs the camera time to the computer's time |
|     ap_setting(ssid,pass) | Change SSID and Password of the camera. HERO5 not supported. |
|     locate(param) | Makes the camera beep. locate(Locate::Start) for start and locate(Locate::Stop) for stop. |
|     reset() | Reset camera (protune or flash factory setting) |
This API is based on [goprowifihack](http://github.com/konradit/goprowifihack) - GoPro API docs.