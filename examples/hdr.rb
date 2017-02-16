require '../lib/GoPro'
require '../lib/constants'

gpCamera = Camera.new
count=0
brackets=["0","4","8"]
while count < brackets.size
	gpCamera.gpControlCommand(Photo::EVCOMP, brackets[count])
	count += 1
	puts "Photo: " + count.to_s
	sleep 1
	gpCamera.shutter(Shutter::ON)
	sleep 1
end