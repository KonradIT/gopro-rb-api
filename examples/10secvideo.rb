require '../GoPro/GoPro'
require '../GoPro/constants'
camera_mode(Mode::VideoMode, Mode::SubMode::Video::Video)
shutter_on()
sleep 10
shutter_off()