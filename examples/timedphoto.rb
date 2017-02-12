require '../GoPro/GoPro'
require '../GoPro/constants'
gpCamera = Camera.new
sleep 5
gpCamera.camera_mode(Mode::PhotoMode, Mode::SubMode::Photo::Single)
gpCamera.shutter(Shutter::ON)
