require '../lib/goprocam'
require '../lib/constants'

gpCamera = Camera.new
puts "Media List"
puts gpCamera.list_media()
puts "Last media taken:"
puts gpCamera.get_media()
puts "Last Media info:"
puts "    filename: " + gpCamera.get_media_info("file")
puts "    folder: " + gpCamera.get_media_info("folder")
puts "    size: " + (gpCamera.get_media_info("size").to_f/1000000).round(2).to_s + " MB"
puts "Downloading last media"
gpCamera.dl_media()