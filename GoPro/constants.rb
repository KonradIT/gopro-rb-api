class Status
	Status="status"
	Settings="setting"
	def getStringStatus(status)
		strings=Array["Video","Photo","MultiShot"]
		return strings[status.to_i]
	end
	def getStatus(status, value)
		puts case status
			when "1"
				puts case value
					when "0"
						return "no battery"
					when "1"
						return "has battery"
				end
		end
	end
	
	class STATUS
		Battery="1"
		BatteryLevel="2"
		Mode="43"
		SubMode="44"
		RecordElapsed="13"
		CamName="30"
		RemVideoTime="35"
		RemPhotos="34"
		BatchPhotosTaken="36"
		VideosTaken="39"
		PhotosTaken="38"
		IsRecording="8"
		SdCardInserted="33"
	end
	
end
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
end
class Locate
	Start = "1"
	Stop = "0"
end
class Reset
	VideoPT="video"
	PhotoPT="photo"
	MultiShotPT="multishot"
	CamReset="camera"
end
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
	VIDEO_LOOP_TIME="6"
	class VideoLoopTime
		LoopMax="0"
		Loop5Min="1"
		Loop20Min="2"
		Loop60Min="3"
		Loop120Min="4"
	end
	VIDEO_PHOTO_INTERVAL="7"
	class VideoPhotoInterval
		Interval5Min="1"
		Interval10Min="2"
		Interval30Min="3"
		Interval60Min="4"
	end
	PROTUNE_VIDEO="10"
	class ProTune
		ON="1"
		OFF="0"
	end
	WHITE_BALANCE="11"
	class WhiteBalance
		WBAuto="0"
		WB3000k="1"
		WB4000k="5"
		WB4800k="6"
		WB5500k="2"
		WB6000k="7"
		WB6500k="3"
		WBNative="4"
	end
	COLOR="12"
	class Color
		GOPRO="0"
		Flat="1"
	end
	ISO_LIMIT="13"
	class IsoLimit
		ISO6400= "0"
		ISO1600= "1"
		ISO400= "2"
		ISO3200= "3"
		ISO800= "4"
		ISO200= "7"
		ISO100= "8"
	end
	ISO_MODE="74"
	class IsoMode
		Max="0"
		Lock="1"
	end
	SHARPNESS="14"
	class Sharpness
		High="0"
		Med="1"
		Low="2"
	end
	EVCOMP="15"
	class EvComp
		P2= "0"
		P1_5="1"
		P1= "2"
		P0_5="3"
		Zero = "4"
		M0_5="5"
		M1= "6"
		M1_5="7"
		M2= "8"
	end

end
class Photo
	RESOLUTION="17"
	class Resolution
		R12W="0"
		R7W="1"
		R7M="2"
		R5W="3"
		#HERO5 black only
		R12L="10"
		R12M="8"
		R12N="9"
	end
	SPOT_METER="20"
	class SpotMeter
		ON="1"
		OFF="0"
	end
	NIGHT_PHOTO_EXP="19"
	class NightPhotoExp
		ExpAuto="0"
		Exp2Min="1"
		Exp5Min="2"
		Exp10Min="3"
		Exp15Min="4"
		Exp20Min="5"
		Exp30Min="6"
	end
	CONTINUOUS_PHOTO_RATE="18"
	class ContinuousPhotoRate
		P3="0"
		P5="1"
		P10="2"
	end
	PROTUNE_PHOTO="21"
        class ProTune
                ON="1"
                OFF="0"
        end
        WHITE_BALANCE="22"
        class WhiteBalance                                                                                       WBAuto="0"
                WB3000k="1"                                                                                      WB4000k="5"
                WB4800k="6"
                WB5500k="2"                                                                                      WB6000k="7"
                WB6500k="3"
                WBNative="4"
        end
        COLOR="23"
        class Color
                GOPRO="0"
                Flat="1"
        end
	ISO_LIMIT="24"
	class IsoLimit
		ISO800="0"
		ISO400="1"
		ISO200="2"
		ISO100="3"
	end
	ISO_MIN="75"
	class IsoMin
		ISO800="0"
    		ISO400="1"
    		ISO200="2"                                                
    		ISO100="3"
	end
        SHARPNESS="14"
        class Sharpness
                High="0"
                Med="1"
                Low="2"
        end
	EVCOMP="26"
	class EvComp
                P2= "0"
                P1_5="1"                                                                                         P1= "2"
                P0_5="3"                                                                                         Zero = "4"
                M0_5="5"
                M1= "6"
                M1_5="7"
                M2= "8"
        end
end

class Multishot
	RESOLUTION="28"
	class Resolution
		R12W="0"
		R7W="1"
                R7M="2"
		R5W="3"
		#HERO5 black only
		R12L="10"
		R12M="8"
		R12N="9"
	end

        SPOT_METER="33"
	class SpotMeter
		ON="1"
		OFF="0"
	end

	NIGHT_LAPSE_EXP="31"
	class NightLapseExp
		ExpAuto="0"
		Exp2Min="1"
		Exp5Min="2"
		Exp10Min="3"
		Exp15Min="4"
		Exp20Min="5"
		Exp30Min="6"
	end
	NIGHT_LAPSE_INTERVAL="32"
	class NightLapseInterval
		IContinuous="0"
		I4s="4"
		I5s="5"
		I10s="10"
		I15s="15"
		I20s="20"
		I30s="30"
		I1m="60"
		I2m="120"
		I5m="300"
		I30m="1800"
		I60m="3600"
	end
	TIMELAPSE_INTERVAL="30"
	class TimeLapseInterval
		IHalf1="0"
		I1="1"
		I2="2"
		I5="5"
		I10="10"
		I30="30"
		I60="60"
	end
	BURST_RATE="29"
	class BurstRate
		B3_1="0"
		B5_1="1"
		B10_1="2"
		B10_2="3"
		B10_3="4"
		B30_1="5"
		B30_2="6"
		B30_3="7"
		B30_6="8"
	end
end


