#from pathlib import Path
import os.path
import camera_zwo_asi
import datetime as dt
import gpsd
import time as t
# Connecting to the camera
# at index 0
index = 0
camera = camera_zwo_asi.Camera(0)
print("Checking exposure . . . ")
for i in range(100):
	camera.set_control("Gain",int(10))
	camera.set_control("Exposure",int(160))
	camera.set_control("AutoExpMaxExpMS", int(0))
	camera.set_control("AutoExpTargetBrightness", int(0))
	camera.set_control("BandWidth", int(40))
	camera.set_control("HighSpeedMode",int(0))
	camera.set_control("Offset",int(1))
# changing the ROI (region of interest)
	roi = camera.get_roi()
	roi.type = camera_zwo_asi.ImageType.raw8
	roi.start_x = 0
	roi.start_y = 0
	roi.bins = 1
	roi.width = 1280
	roi.height = 720
	camera.set_roi(roi)
	image = camera.capture()
	print(str(i) + "%")
print(str(100) + "%")
print("Exposure ready!")


camera.set_control("Gain",int(150))
camera.set_control("Exposure",int(2000000))
camera.set_control("AutoExpMaxExpMS", int(1600))
camera.set_control("AutoExpTargetBrightness", int(50))
camera.set_control("BandWidth", int(40))
camera.set_control("HighSpeedMode",int(0))
camera.set_control("Offset",int(1))
# changing the ROI (region of interest)
roi = camera.get_roi()
roi.type = camera_zwo_asi.ImageType.raw16
roi.start_x = 0
roi.start_y = 0
roi.bins = 1
roi.width = 1928
roi.height = 1216
camera.set_roi(roi)


# Gets position and time from the GPS device
gpsd.connect()
while True:
	packet = gpsd.get_current()
	time = [packet.get_time().year, packet.get_time().month, packet.get_time().day, packet.get_time().hour, packet.get_time().minute, packet.get_time().second, packet.get_time().microsecond]
	latitude = packet.lat
	longitude = packet.lon
	altitude = None
	if packet.mode >= 3:
		altitude = packet.alt
	position = (latitude, longitude, altitude)
	conf_path = os.path.join("/home/rock/Desktop/BROR_PHOTO/Photo4","asi.toml")
	camera.to_toml(conf_path)
	# taking the picture
	filepath = os.path.join("/home/rock/Desktop/BROR_PHOTO/Photo4","pic_" + str(index) + "_-_" + str(time[0]) + "_" + str(time[1]) + "_" + str(time[2]) + "_" + str(time[3]) + "_" + str(time[4])+ "_" + str(time[5]) + "_" + str(time[6]) + "_-_" +  "{" + str(position[0]) + "_" + str(position[1]) + "_" + str(position[2]) + "}"  + ".tiff")
	show = False
	# filepath and show are optional, if you do not
	# want to save the image or display it
	image = camera.capture()
	image.save(filepath)
	print("Picture taken: " + str(index))
