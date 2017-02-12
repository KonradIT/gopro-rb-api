require '../GoPro/GoPro'
gpCamera = Camera.new
puts("powering on...")
gpCamera.power_on()
sleep 10
puts("powering off...")
gpCamera.power_off()