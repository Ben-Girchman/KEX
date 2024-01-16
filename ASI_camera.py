from pathlib import Path
import camera_zwo_asi
#import datetime as dt
import gpsd

# Connecting to the camera
# at index 0
camera = camera_zwo_asi.Camera(0)

# Connection GPS to computer
gpsd.connect()

# printing information in the
# terminal
#print(camera)

# changing some controllables
# (supported arguments: the one that are
# indicated as 'writable' in the information
# printed above)
camera.set_control("Gain",300)
camera.set_control("Exposure","auto")

# changing the ROI (region of interest)
roi = camera.get_roi()
#roi.type = camera_zwo_asi.ImageType.rgb24
roi.start_x = 0
roi.start_y = 0
roi.bins = 1
roi.width = 1936
roi.height = 1216
camera.set_roi(roi)

index = 0
while True:
    index +=1

    # Gets position and time from the GPS device
    packet = gpsd.get_current()
    time = packet.time
    latitude = packet.lat
    longitude = packet.lon
    if packet.mode >= 3:
        altitude = packet.alt
    else:
        altitude = None

    position = (latitude, longitude, altitude)


    # saving this updated configuration to a file
    conf_path = Path("home/rock/Desktop/Photos") / "asi.toml"
    camera.to_toml(conf_path)

    # taking the picture
    filepath = Path("/home/rock/Desktop/Photos") / (str(time) + "_-_" + str(position) + ".bmp")
    show = False
    # filepath and show are optional, if you do not
    # want to save the image or display it
    image = camera.capture(filepath=filepath,show=show)
    print("Picture taken: " + str(index))
