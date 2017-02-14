require '../GoPro/GoPro'
require '../GoPro/constants'

gpCamera = Camera.new

gpCamera.livestream(Livestream::START)