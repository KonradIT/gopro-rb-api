require '../lib/GoPro'
require '../lib/constants'

gpCamera = Camera.new
puts "Media List"
puts gpCamera.list_media()
puts "Last media taken:"
puts gpCamera.get_media()
puts "Downloading last media"
gpCamera.dl_media()