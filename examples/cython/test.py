import compute_wrapper
import numpy as np

x0, y0, x1, y1 = 1, 2, 3, 4
rect_obj = compute_wrapper.PyRectangle(x0, y0, x1, y1)
print(rect_obj.get_area())


arr = np.array([1.0, 2.0, 3.0, 4.0], dtype='float')
print(compute_wrapper.cal(arr))

arr2 = np.array([1.0, 2.0, 3.0, 4.0], dtype='f4')
print(compute_wrapper.calf(arr2))
