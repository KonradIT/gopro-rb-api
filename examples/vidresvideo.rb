require '../GoPro/GoPro'
require '../GoPro/constants'
gpCamera = Camera.new
gpCamera.camera_mode(Mode::VideoMode, Mode::SubMode::Video::Video)
gpCamera.gpControlCommand(Video::RESOLUTION, Video::Resolution::R1440p)
gpCamera.shutter(Shutter::ON)