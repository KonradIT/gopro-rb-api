
class Mode
	VideoMode = "0"
	PhotoMode = "1"
	MultiShotMode = "3"
	class SubMode
		class Video
			Video = "0"
			TimeLapseVideo = "1"
			VideoPhoto = "2"
			Looping = "3"
		end
		class Photo
			Single = "0"
			Continuous = "1"
			Night = "2"
		end
		class MultiShot
			Burst = "0"
			TimeLapse = "1"
			NightLapse = "2"
		end
	end
end

class Shutter
	ON = "1"
	OFF = "0"
end

class Delete
	ALL = "all"
	LAST = "last"
class Locate
	Start = "1"
	Stop = "0"
class Video
	RESOLUTION="2"
	class Resolution
		R4k="1"
		R4kSV="2"
		R2k="4"
		R2kSV="5"
		R2k4by3="6"
		R1440p="7"
		R1080pSV="8"
		R1080p="9"
		R960p="10"
		R720pSV="11"
		R720p="12"
		R480p="13"
	end
	FRAME_RATE="3"
	class FrameRate
			FR240="0"
			FR120="1"
			FR100="2"
			FR60="5"
			FR50="6"
			FR48="7"
			FR30="8"
			FR25="9"
			FR24="10"
	end
	FOV="4"
	class Fov
		Wide="0"
		Medium="1"
		Narrow="2"
		Linear="4"
	end
	LOW_LIGHT="5"
	class LowLight
		ON="1"
		OFF="0"
	end
	SPOT_METER="9"
	class SpotMeter
		ON="1"
		OFF="0"
	end
end
	
			
		