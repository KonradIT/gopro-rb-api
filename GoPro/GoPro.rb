require 'open-uri'
require 'socket'
require 'json'
GPIP = "10.5.5.9"
GOPROCONTROL = "http://10.5.5.9/gp/gpControl/"
GOPROMEDIA = "http://10.5.5.9/gp/gpMediaList/"
class Camera
	def initialize()
  end
	def gpControlCommand(param,value)
		response = open(GOPROCONTROL + 'setting/' + param + '/' + value).read
		puts response
	end

	def status_raw()
		response = open(GOPROCONTROL + 'status').read
		puts response
	end 

	def status(value, param)
		response = open(GOPROCONTROL + 'status').read
		parsed_resp = JSON.parse(response)
		return parsed_resp[value][param]
	end 
	def info_camera(option)
		response = open(GOPROCONTROL + 'info').read
		parsed_resp = JSON.parse(response)
		return parsed_resp["info"][option]
	end
	def overview()
		puts "camera overview"
		puts "current mode: ", status(Status::Status, Status::STATUS::Mode)
		puts "current submode: ", status(Status::Status, Status::STATUS::SubMode)
		puts "pictures taken: ", status(Status::Status, Status::STATUS::PhotosTaken)
		puts "videos taken: ",  status(Status::Status, Status::STATUS::VideosTaken)
		puts "videos left: ", status(Status::Status, Status::STATUS::RemVideoTime)
		puts "pictures left: ", status(Status::Status, Status::STATUS::RemPhotos)
		puts "camera SSID: ", status(Status::Status, Status::STATUS::CamName)
		puts "Is Recording:", status(Status::Status, Status::STATUS::IsRecording)
		puts "camera model: ", info_camera(Camera::Name)
		puts "firmware version: ", info_camera(Camera::Firmware)
	end
	def shutter(value)
		response = open(GOPROCONTROL + 'command/shutter?p=' + value).read
		puts response
	end
	def take_photo()
		if status(Status::Status, Status::STATUS::IsRecording) == "1"
			shutter(Shutter::OFF)
		end
		camera_mode(Mode::PhotoMode)
		shutter(Shutter::ON)
	end
	def camera_mode(mode, submode="0")
		response = open(GOPROCONTROL + 'command/sub_mode?mode=' + mode + '&sub_mode=' + submode).read
		puts response
	end

	def delete(option)
		response = open(GOPROCONTROL + 'command/storage/delete/' + option).read
		puts response
	end

	def delete_file(folder,file)
		response = open(GOPROCONTROL + 'command/storage/delete?p=' + folder + "/" + file).read
		puts response
	end

	def locate(param)
		response = open(GOPROCONTROL + 'command/system/locate?p=' + param).read
		puts response
	end

	def hilight()
		response = open(GOPROCONTROL + 'command/storage/tag_moment').read
		puts response
	end

	def power_off()
		response = open(GOPROCONTROL + 'command/system/sleep').read
		puts response
	end
	UDPSock = UDPSocket.new
	def power_on()
		begin
		addr = ['<broadcast>', 9]

		UDPSock.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
		data = "\xFF\xFF\xFF\xFF\xFF\xFF"
		arr = "AA:BB:CC:DD:EE:FF" #actually works, replace if needed.
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
		response = open(GOPROCONTROL + 'command/setup/date_time?p=' + datestr).read
		puts response
	end
	def ap_setting(ssid,pass)
		response = open(GOPROCONTROL + 'command/wireless/ap/ssid?ssid=' + ssid + "&pw=" + passwd).read
		puts response
		end
	end

	def reset(option)
		#videoPT, photoPT, msPT, camera, etc...
		puts case option
			when Reset::VideoPT
				#reset video PT
				response = open(GOPROCONTROL + 'command/video/protune/reset').read
				puts response
			when Reset::PhotoPT
				#reset photo PT
				response = open(GOPROCONTROL + 'command/photo/protune/reset').read
				puts response
			when Reset::MultiShotPT
				#reset Ms PT
				response = open(GOPROCONTROL + 'command/multi_shot/protune/reset').read
				puts response
			when Reset::CamReset
				response = open(GOPROCONTROL + 'command/system/factory/reset').read
				puts response
		end
	end
	def list_media()
		response = open(GOPROMEDIA).read
		return JSON.pretty_generate JSON.parse(response)
	end
	def get_media()
		folder=""
		file=""
		response = open(GOPROMEDIA).read
		parsed_resp = JSON.parse(response)
		parsed_resp['media'].each do |child|
    	folder = child['d'] 
		end
		parsed_resp['media'].each do |child|
    	child['fs'].each do |child|
    	file = child['n'] 
			end
		end
		return "http://10.5.5.9:8080/videos/DCIM/" + folder + "/" + file
	end
	def dl_media()
		folder=""
		file=""
		response = open(GOPROMEDIA).read
		parsed_resp = JSON.parse(response)
		parsed_resp['media'].each do |child|
    	folder = child['d'] 
		end
		parsed_resp['media'].each do |child|
    	child['fs'].each do |child|
    	file = child['n'] 
			end
		end
		url = get_media()
		open(url) {|f|
			File.open(folder+"-"+file,"wb") do |file|
				file.puts f.read
		end
		}

	end

	def livestream(option)
		puts case option
			when "start"
				response = open(GOPROCONTROL + 'execute?p1=gpStream&a1=proto_v2&c1=start').read
				puts response
			when "stop"
				response = open(GOPROCONTROL + 'execute?p1=gpStream&a1=proto_v2&c1=stop').read
				puts response
			when "restart"
				response = open(GOPROCONTROL + 'execute?p1=gpStream&a1=proto_v2&c1=restart').read
				puts response
		end
	end
end