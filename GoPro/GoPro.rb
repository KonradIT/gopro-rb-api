require 'open-uri'
require 'socket'
GPIP = "10.5.5.9"

def gpControlCommand(param,value)
	response = open('http://10.5.5.9/gp/gpControl/setting/' + param + '/' + value).read
	puts response
end

def status_raw()
	response = open('http://10.5.5.9/gp/gpControl/status').read
	puts response
end

def status(object,value)
	response = open('http://10.5.5.9/gp/gpControl/status').read
	#todo: get value off the JSON using setting/status:XX
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
UDPSock = UDPSocket.new
def power_on()
	begin
	addr = ['<broadcast>', 9]
	
	UDPSock.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
	data = "\xFF\xFF\xFF\xFF\xFF\xFF"
	arr = "F6:DD:9E:08:B9:DC"
	16.times do |i|
	 data<< arr[0].hex.chr+arr[1].hex.chr+arr[2].hex.chr+arr[3].hex.chr+arr[4].hex.chr+arr[5].hex.chr
	end
	UDPSock.send(data, 0, addr[0], addr[1])
end

def sync_time()
	datestr_year=Time.new.year.to_s.reverse[0...2].reverse.to_i.to_s(16)
	datestr_month=Time.new.month.to_s(16)
	datestr_day=Time.new.day.to_s(16)
	datestr_hour=Time.new.hour.to_s(16)
	datestr_min=Time.new.min.to_s(16)
	datestr_sec=Time.new.sec.to_s(16)
	datestr="%"+datestr_year+"%"+datestr_month+"%"+datestr_day+"%"+datestr_hour+"%"+datestr_min+"%"+datestr_sec
	response = open('http://10.5.5.9/gp/gpControl/command/setup/date_time?p=' + datestr).read
	puts response
end
def ap_setting(ssid,pass)
	response = open('http://10.5.5.9gp/gpControl/command/wireless/ap/ssid?ssid=' + ssid + "&pw=" + passwd).read
	puts response
	end
end