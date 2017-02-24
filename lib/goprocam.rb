require 'open-uri'
require 'socket'
require 'json'
require_relative 'constants'
GPIP = "10.5.5.9"
GOPROCONTROL = "http://10.5.5.9/gp/gpControl/"
GOPROMEDIA = "http://10.5.5.9/gp/gpMediaList/"
class Camera
	def initialize()
		#check if camera is ON:
		#power_on()
		#check if camera status is connected
		while status(Status::Status, Status::STATUS::IsConnected) == 0
			status(Status::Status, Status::STATUS::IsConnected)
		end
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
	def parse_value(param,value)
		puts case param
			when "mode"
				puts case value
					when 0
						return "Video"
					when 1
						return "Photo"
					when 2
						return "Multi-Shot"
				end
			when "sub_mode"
				puts case status(Status::Status, Status::STATUS::Mode)
					when 0
						puts case value
							when 0
								return "Video"
							when 1
								return "TimeLapse Video"
							when 2
								return "Video+Photo"
							when 3
								return "Looping"
						end
					when 1
						puts case value
								when 0
									return "Single Pic"
								when 1
									return "Burst"
								when 2
									return "NightPhoto"
						end
					when 2
						puts case value
								when 0
									return "Burst"
								when 1
									return "TimeLapse"
								when 2
									return "Night lapse"
						end
				end
			when "recording"
				puts case value
					when 0
						return "Not recording - standby"
					when 1
						return "RECORDING!"
				end
			when "battery"
				puts case value
					when 0
						return "Nearly Empty"
					when 1
						return "LOW"
					when 2
						return "Halfway"
					when 3
						return "Full"
					when 4
						return "Charging"
				end
			when "video_left"
				return Time.at(value).utc.strftime("%H:%M:%S")
			when "rem_space"
				return (value.to_f/1000000).round(2).to_s
			when "video_res"
				puts case value
					when 1
							return "4k"
					when 2
							return "4kSV"
					when 4
							return "2k"
					when 5
							return "2kSV"
					when 6
							return "2k4by3"
					when 7
							return "1440p"
					when 8
							return "1080pSV"
					when 9
							return "1080p"
					when 10
							return "960p"
					when 11
							return "720pSV"
					when 12
							return "720p"
					when 13
							return "480p"
				end
			when "video_fr"
				puts case value
					when 0
							return "240"
					when 1
							return "120"
					when 2
							return "100"
					when 5
							return "60"
					when 6
							return "50"
					when 7
							return "48"
					when 8
							return "30"
					when 9
							return "25"
					when 10
							return "24"
				end
		 end
	end
	def overview()
		puts "camera overview"
		puts "current mode: ", "    " + parse_value("mode",status(Status::Status, Status::STATUS::Mode))
		puts "current submode: ", "    " + parse_value("sub_mode",status(Status::Status, Status::STATUS::SubMode))
		puts "current video resolution: ", "    " + parse_value("video_res",status(Status::Settings, Video::RESOLUTION))
		puts "current video framerate: ", "    " + parse_value("video_fr",status(Status::Settings, Video::FRAME_RATE))
		puts "pictures taken: ", "    " + status(Status::Status, Status::STATUS::PhotosTaken).to_s
		puts "videos taken: ",  "    " + status(Status::Status, Status::STATUS::VideosTaken).to_s
		puts "videos left: ", "    " + parse_value("video_left",status(Status::Status, Status::STATUS::RemVideoTime))
		puts "pictures left: ", "    " + status(Status::Status, Status::STATUS::RemPhotos).to_s
		puts "battery left: ", "    " + parse_value("battery",status(Status::Status, Status::STATUS::BatteryLevel))
		puts "space left in sd (GBs): ", "    " + parse_value("rem_space",status(Status::Status, Status::STATUS::RemainingSpace))
		puts "camera SSID: ", "    " + status(Status::Status, Status::STATUS::CamName).to_s
		puts "Is Recording:", "    " + parse_value("recording",status(Status::Status, Status::STATUS::IsRecording))
		puts "Clients connected: ", "    " + status(Status::Status, Status::STATUS::IsConnected).to_s
		puts "camera model: ", "    " + info_camera(Camera::Name)
		puts "camera ssid name: ", "    " + info_camera(Camera::SSID)
		puts "firmware version: ", "    " + info_camera(Camera::Firmware)
		puts "serial number: ", "    " + info_camera(Camera::SerialNumber)
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

	def ap_setting(ssid,pass)
		response = open(GOPROCONTROL + 'command/wireless/ap/ssid?ssid=' + ssid + "&pw=" + passwd).read
		puts response
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
	def get_media_info(option)
		folder=""
		file=""
		size=""
		response = open(GOPROMEDIA).read
		parsed_resp = JSON.parse(response)
		parsed_resp['media'].each do |child|
    	folder = child['d'] 
		end
		parsed_resp['media'].each do |child|
    	child['fs'].each do |child|
    	file = child['n'] 
			size = child['s']
			end
		end
		puts case option
			when "folder"
				return folder
			when "file"
				return file
			when "size"
				return size
		end
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
end