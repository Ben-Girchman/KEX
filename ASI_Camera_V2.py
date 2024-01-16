import zwoasi as asi

asi.init('/home/rock/Desktop/ASI/lib/armv8/libASICamera2.so')

num_cameras = asi.get_num_cameras()
if num_cameras == 0:
    raise ValueError("No cameras found")

camera_id = 0
camera_found = asi.list_cameras()
#print(cameras_found)

camera = camera.Camera(camera_id)
camera_info = camera.get_camera_property()
#print(camera_info)
controls = camera.get_controls()

camera.set_control_value(asi.ASI_GAIN,400)
camera.set_control_value(asi.ASI_EXPOSURE,1600)

try:
    camera.stop_video_capture()
    camera.stop_exposure()
except (KeyboardInterrupt, SystemExit):
    raise

filename = "zwo_new_pic.tiff"
camera.set_image_type(asi.ASI_IMG_RAW16)
camera.capture(filename = filename)
print("Saved to %s" %filename)
