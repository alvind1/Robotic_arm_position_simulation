import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import math

fig = plt.figure()
ax = plt.axes(projection='3d')

""""
#Givens
#point(x, y, z) theta_x, theta_y
x-axis ----------
z-axis ||||||||||
y-axis 

#z0 is the height of the xy plane
#z1 is the height of the point from the xy plane

"""

def triangle_inequality(a, b, c):
    if(a == max(a, b, c)):
        if a > b+c:
            return -1
        else:
            return 1
    elif(b == max(a, b, c)):
        if b > a+c:
            return -1
        else:
            return 1
    elif(c == max(a, b, c)):
        if c > a+b:
            return -1
        else:
            return 1


def sine_law(theta_b, a, b):
    #b is opposite of theta_b
    #a is opposite of theta_a
    #c is opposite of theta_c

    theta_a1 = np.arcsin(a*math.sin(theta_b)/b)
    theta_c1 = math.pi-theta_a1-theta_b
    c1 = math.sin(theta_c1)*a/math.sin(theta_a1)

    return theta_a1, theta_c1, c1

    """theta_a2 = math.pi-np.arcsin(a*math.sin(b)/b) #TO DO since SSA does not define an unique triangle
    theta_c2 = math.pi-theta_a2-theta_b
    c2 = math.sin(theta_c2)*a/math.sin(a)

    if triangle_inequality(a, b, c2) == 1 and :"""


def cosine_law_angle(a, b, c):
    #print(a, b, c)
    try:
        num = (a**2+b**2-c**2)/(2*a*b)
    except:
        return 0
    #print("num", num)

    return np.arccos(num)


def length(x1, y1, z1, x2, y2, z2):
    return math.sqrt((x1-x2)**2+(y1-y2)**2+(z1-z2)**2)


x = 5
y = 2
z = 4
theta_x = math.pi/4
theta_y = math.pi/6

arm_lengths = [5, 5, -1, 5, -1] #starting from target, -1 means to be defined
angles = [-1, -1, -1, -1, -1, -1, -1] 
#7th: angle rotation of point 2 (0 indexed)

if length(x, y, z, 0, 0, 0) > arm_lengths[0]+arm_lengths[1]+arm_lengths[3]:
    print("NOT POSSIBLE")
    quit()

x_val = [-1, -1, -1, -1] #starting from target point to origin
y_val = [-1, -1, -1, -1]
z_val = [-1, -1, -1, -1]

x_val[0] = x
y_val[0] = y
z_val[0] = z

z_val[1] = math.sin(theta_y)*arm_lengths[1]
y_val[1] = math.cos(theta_x)*arm_lengths[1]
x_val[1] = x-math.sqrt(arm_lengths[1]**2-y_val[1]**2-z_val[1]**2)
z_val[1] += z
y_val[1] += y

x_val[-1] = 0
y_val[-1] = 0
z_val[-1] = 0

#Everything is true up to this point
for i in range(1, len(x_val)-1):
    print(x_val[i], y_val[i], z_val[i])
    ax.scatter(x_val[i], y_val[i], z_val[i], c='blue')
ax.scatter(x_val[0], y_val[0], z_val[0], c='red')
ax.scatter(x_val[-1], y_val[-1], z_val[-1], c='red')

print("LENGTH", length(x_val[1], y_val[1], z_val[1], 0, 0, 0))

arm_lengths[4] = length(0, 0, 0, x_val[1], y_val[1], z_val[1])

print("ANGLE", np.arctan(z_val[1]/y_val[1]), math.pi/6)

ax.plot(x_val, y_val, z_val)

plt.show()


"""
TO DO:
Works kind of
Lengths of arm segments are off from given

"""