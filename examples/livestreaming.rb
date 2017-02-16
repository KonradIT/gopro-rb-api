require '../lib/GoPro'
require '../lib/constants'

gpCamera = Camera.new

gpCamera.livestream(Livestream::START)