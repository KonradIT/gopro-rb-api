require '../GoPro/GoPro'
require '../GoPro/constants'
camera_mode(Mode::VideoMode, Mode::SubMode::Video::Video)
gpControlCommand(Video::RESOLUTION, Video::Resolution::R1440p)
shutter(Shutter::ON)