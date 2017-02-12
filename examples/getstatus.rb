require '../GoPro/GoPro'
require '../GoPro/constants'

status_raw()
puts status(Status::Status, Status::STATUS::Mode)
puts status(Status::Status, Status::STATUS::IsRecording)
puts status(Status::Settings, Video::FRAME_RATE)
puts status(Status::Settings, Photo::RESOLUTION)
