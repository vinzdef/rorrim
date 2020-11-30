import freenect
import cv2
import frame_convert2
import numpy as np

cv2.namedWindow('Depth')

keep_running = True

def display_depth(dev, data, timestamp):
    global keep_running
    fact = 0.08744504152418173  # 179 / 2047

    hue = np.copy(data)
    hue = hue * fact
    hue = hue.astype("uint16")

    sat = np.copy(data)
    sat.fill(127)

    val = np.copy(data)
    val.fill(127)

    hsv = cv2.merge([hue, sat, val])

    cv2.imshow('Depth', cv2.cvtColor(hsv.astype("float32"), cv2.COLOR_HSV2BGR))

    if cv2.waitKey(10) == 27:
        keep_running = False

def body(*args):
    if not keep_running:
        raise freenect.Kill


print('Press ESC in window to stop')
freenect.runloop(depth=display_depth,
                 body=body)
