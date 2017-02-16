require '../lib/goprocam'
require '../lib/constants'

gpCamera = Camera.new
gpCamera.camera_mode(Mode::MultiShotMode, Mode::SubMode::MultiShot::Burst)
gpCamera.gpControlCommand(Multishot::BURST_RATE, Multishot::BurstRate::B5_1)
gpCamera.shutter(Shutter::ON)