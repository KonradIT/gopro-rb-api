require '../lib/goprocam'
require '../lib/constants'
gpCamera = Camera.new
gpCamera.camera_mode(Mode::VideoMode, Mode::SubMode::Video::Video)
gpCamera.gpControlCommand(Video::RESOLUTION, Video::Resolution::R1440p)
gpCamera.shutter(Shutter::ON)