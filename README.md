# GoPro Ruby API Wrapper

A unofficial Ruby API wrapper for controlling GoPro HERO cameras over WiFi.

[![Gem Version](https://badge.fury.io/rb/goprocam.svg)](https://badge.fury.io/rb/goprocam)

###Installation:

**From source**
```
git clone http://github.com/konradit/gopro-rb-api
cd gopro-rb-api
gem build goprocam.gemspec
gem install goprocam.gemspec
```

**From RubyGems**

    gem install goprocam
    

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
require '../lib/goprocam'
require '../lib/constants'
```

or

```ruby
require 'goprocam'
```

###Initialising:

```ruby
gpCamera = Camera.new
```

| Code | Explanation |
|------|-------------|
|     gpControlCommand(X,Y) | Sends a command to the camera, using GoPro constants |
|     shutter(param) | Starts a video or takes a picture<br>param=Shutter::ON or Shutter::OFF |
|     camera_mode(X,Y) | Changes the mode, X=Mode, Y=Submode (default is 0). Example: camera_mode(Mode::PhotoMode, Mode::SubMode::Photo::Single) |
|     status_raw() | Returns the status dump of the camera in json |
|     status(X,Y) | Returns the status. <br><ul><li>X = Status::Status or Status::Settings</li><li>Y = status id (Status/Setup/Video/Photo/MultiShot).</li><li>NOTE: This returns the status of the camera as an integer. To get the value in a human form use parse_value() </li></ul>|
|     parse_value(option, param) | Parse the raw value of status and print a human value.<br><ul><li>option="mode","sub_mode","recording","battery","video_res","video_fr","rem_space"</li><li>param = Status ID</ul>
|     overview() | Prints a human-readable overview |
|     info_camera(option) | Returns camera information<br>option = Name/Number/Firmware/SSID/MacAddress/SerialNumber
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
|     list_media() | Outputs a prettified JSON media list |
|     get_media_info(option) | Gets the media info<br>option=file/folder/size |
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
	>0
	puts gpCamera.status(Status::Status, Status::STATUS::IsRecording) #returns recording status
	>1
	puts gpCamera.status(Status::Settings, Video::FRAME_RATE) #returns frame rate
	>3
	puts gpCamera.status(Status::Settings, Photo::RESOLUTION)
	>9
	puts status(Status::Status, Status::STATUS::RemPhotos).to_s #some values do not need to be processed
	>1998
	puts status(Status::Status, Status::STATUS::CamName) #This returns the camera SSID
	>KonradHERO4Black2
	```
	
	NOTE: This status returns an integer which can be later matched with a human description. That is:
	
	```ruby
	puts gpCamera.parse_value("mode",status(Status::Status, Status::STATUS::Mode))
	>Video
	puts gpCamera.parse_value("sub_mode",status(Status::Status, Status::STATUS::SubMode))
	>Looping
	puts gpCamera.parse_value("video_res",status(Status::Settings, Video::RESOLUTION))
	>1080p
	puts gpCamera.parse_value("video_fr",status(Status::Settings, Video::FRAME_RATE))
	>60
	puts gpCamera.parse_value("video_left",status(Status::Status, Status::STATUS::RemVideoTime))
	>01:14:23
	puts gpCamera.parse_value("battery",status(Status::Status, Status::STATUS::BatteryLevel))
	>Full
	puts gpCamera.parse_value("recording",status(Status::Status, Status::STATUS::IsRecording))
	>Recording
	```
	
	If you want to get the raw status dump: ```gpCamera.status_raw()```
	
	
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
	gpCamera.shutter(Shutter::OFF) #stops a video or timelapse
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
