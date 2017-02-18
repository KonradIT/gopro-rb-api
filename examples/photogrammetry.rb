require '../lib/goprocam'
require '../lib/constants'

###################################
# Photogrammetry with GoPro camera#
# Proof of concept, not for real  #
# world usage.                    #
# TIMELAPSE                       #
###################################

gpCamera = Camera.new
INTERVAL =  5 #Interval in seconds
gpCamera.camera_mode(Mode::PhotoMode)
count=0
while sleep INTERVAL
	gpCamera.shutter(Shutter::ON)
	count=count+1
	while gpCamera.status(Status::Status,Status::STATUS::IsBusy) == 1
			puts Time.now.to_f*1000
	end
end