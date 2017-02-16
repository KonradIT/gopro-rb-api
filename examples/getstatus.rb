require '../lib/goprocam'
require '../lib/constants'

gpCamera = Camera.new
puts gpCamera.status_raw()
puts gpCamera.status(Status::Status, Status::STATUS::Mode)
puts gpCamera.status(Status::Status, Status::STATUS::IsRecording)
puts gpCamera.status(Status::Settings, Video::FRAME_RATE)
puts gpCamera.status(Status::Settings, Photo::RESOLUTION)
puts gpCamera.info_camera(Camera::Name)