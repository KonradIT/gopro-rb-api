require '../GoPro/GoPro'
require '../GoPro/constants'

camera_mode(Mode::MultiShotMode, Mode::SubMode::MultiShot::Burst)
gpControlCommand(Multishot::BURST_RATE, Multishot::BurstRate::B5_1)
shutter(Shutter::ON)