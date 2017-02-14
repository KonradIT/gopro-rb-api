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

First of all:

```ruby
require '../GoPro/GoPro'
require '../GoPro/constants'
```

###Imitialising:

```ruby
gpCamera = Camera.new
```

| Code | Explanation |
|------|-------------|
|     gpControlCommand(X,Y) | Sends a command to the camera, using GoPro constants |
|     shutter(param) | Starts a video or takes a picture, param can be Shutter::ON or Shutter::OFF |
|     camera_mode(X,Y) | Changes the mode, X=Mode, Y=Submode (default is 0). Example: camera_mode(Mode::PhotoMode, Mode::SubMode::Photo::Single) |
|     status_raw() | Returns the status dump of the camera in json |
|     status(X,Y) | Returns the status, needs: X=Status::Status or Status::Settings - H=status id (Status/Setup/Video/Photo/MultiShot).|
|     overview() | Prints a human-readable overview |
|     delete() | Can be: delete(last) or delete(all) |
|     delete_file(folder,file) | Deletes a specific file |
|     hilight() | HiLights a moment in the video recording |
|     power_on() | Powers the camera on. NOTE: run this to put your H4 Session into app mode first! |
|     power_off() | Powers the camera off |
|     sync_time() | Syncs the camera time to the computer's time |
|     ap_setting(ssid,pass) | Change SSID and Password of the camera. HERO5 not supported. |
|     locate(param) | Makes the camera beep. locate(Locate::Start) for start and locate(Locate::Stop) for stop. |
|     reset() | Reset camera (protune or flash factory setting) |
|     get_media() | returns the last media taken URL |
|     dl_media() | Downloads latest media taken |
|     livestream(param) | Starts, restarts or stops the livefeed via UDP. |

###Examples:


- **Get Status:**
	You can get the current status for all aspects of the camera. Status messages are divided into sections:
	- Status
	- Settings
	
	See [constants.rb](constants.rb) file for the status and settings available. For settings, you can use any Setup/Video/Photo/MultiShot variable.
	```ruby
	gpCamera = Camera.new
	puts gpCamera.status(Status::Status, Status::STATUS::Mode) #returns current mode
	puts gpCamera.status(Status::Status, Status::STATUS::isRecording) #returns recording status
	puts gpCamera.status(Status::Settings, Video::FRAME_RATE) #returns frame rate
	puts gpCamera.status(Status::Settings, Photo::RESOLUTION)
	```
	If you want to get the raw status: ```gpCamera.status_raw()```
	
	
- **Send a command:**
	You can send a command to your camera wuth ```gpControlCommand```, this way you can change settings.
	
	```ruby
	gpCamera = Camera.new
	gpCamera.gpControlCommand(Multishot::BURST_RATE, Multishot::BurstRate::B5_1)
	gpCamera.gpControlCommand(Setup::ORIENTATION,Setup::Orientation::Down)
	```
	
- **Shutter:**

	You can start/stop a video or timelapse and take pictures.

	```ruby
	gpCamera = Camera.new
	gpCamera.shutter(Shutter::ON) #takes a picture or starts a video
	gpCamera.shutter(Shutter:OFF) #stops a video or timelapse
	```

- **Change Modes:**

	Modes available are: video,photo,multishot
	
	Submodes available: 
	
	- VideoMode: Video, Looping, TimeLapseVideo, VideoPhoto
	- PhotoMode: Single, Continuous, Night
	- MultiShotMode: Burst, TimeLapse, NightLapse
	
	**NOTE**: You can leave the submode empty and it will default to 0 (first submode in the mode).
	 
	```ruby
	gpCamera = Camera.new
	gpCamera.camera_mode(Mode::VideoMode, Mode::SubModes::Video::TimeLapseVideo) #includes submode
	gpCamera.camera_mode(Mode::PhotoMode)
	```
	
- **Get Last Media**

	You can get the last media's URL and also download it to the working directory. Also you can get a list of all the files in the SD card.
	
	```ruby
	gpCamera = Camera.new
	puts gpCamera.get_media() #outputs last media url
	gpCamera.dl_media() #downloads last media
	puts gpCamera.list_media() #lists camera media
	```
	
**For more examples see the examples folder**

This API is based on [goprowifihack](http://github.com/konradit/goprowifihack) - GoPro API docs.