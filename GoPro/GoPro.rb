require 'open-uri'

GPIP = "10.5.5.9"

def gpControlCommand(param,value)
	response = open('http://10.5.5.9/gp/gpControl/setting' + param + "/" + value).read
	puts response
end

def status_raw()
	response = open('http://10.5.5.9/gp/gpControl/status').read
	puts response
end

def shutter_on
	response = open('http://10.5.5.9/gp/gpControl/command/shutter?p=1').read
	puts response
end

def shutter_off
	response = open('http://10.5.5.9/gp/gpControl/command/shutter?p=0').read
	puts response
end

def camera_mode(mode, submode)
	response = open('http://10.5.5.9/gp/gpControl/command/sub_mode?mode=' + mode + '&sub_mode=' + submode).read
	puts response
end
