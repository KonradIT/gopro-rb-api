require '../lib/GoPro'
require '../lib/constants'
gpCamera = Camera.new
sleep 5
gpCamera.take_photo()