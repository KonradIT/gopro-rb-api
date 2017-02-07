require 'open-uri'
require 'dotenv'
require 'wake_on_lan'

GPIP = "10.5.5.9"

def gpControlCommand(param,value)
	response = open('http://10.5.5.9/gp/gpControl/setting/' + param + '/' + value).read
	puts response
end

def status_raw()
	response = open('http://10.5.5.9/gp/gpControl/status').read
	puts response
end

def shutter(value)
	response = open('http://10.5.5.9/gp/gpControl/command/shutter?p=' + value).read
	puts response
end

def camera_mode(mode, submode)
	response = open('http://10.5.5.9/gp/gpControl/command/sub_mode?mode=' + mode + '&sub_mode=' + submode).read
	puts response
end

def delete(option)
	response = open('http://10.5.5.9/gp/gpControl/command/storage/delete/' + option).read
	puts response
end

def locate(param)
	response = open('http://10.5.5.9/gp/gpControl/command/system/locate?p=' + param).read
	puts response
end

def hilight()
	response = open('http://10.5.5.9/gp/gpControl/command/storage/tag_moment').read
	puts response
end

def power_off()
	response = open('http://10.5.5.9/gp/gpControl/command/system/sleep').read
	puts response
end

def power_on()
	Dotenv.load
	WakeOnLan.wake ENV['GOPRO_MAC'], '10.5.5.9', 9
end