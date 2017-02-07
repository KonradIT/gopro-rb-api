require '../GoPro/GoPro'
require '../GoPro/constants'
sleep 5
camera_mode(Mode::PhotoMode, Mode::SubMode::Photo::Single)
shutter(Shutter::ON)
