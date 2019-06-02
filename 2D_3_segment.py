import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import math

"""
Approach:
Given angle of first point from target

"""

fig, ax = plt.subplots()
ax.axis([-20, 20, -20, 20])


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


def cosine_law_angle(a, b, c):
    #print(a, b, c)
    try:
        num = (a**2+b**2-c**2)/(2*a*b)
    except:
        return 0
    #print("num", num)

    return np.arccos(num)


def length(x1, z1, x2, z2):
    return math.sqrt((x1-x2)**2+(z1-z2)**2)

x_val = [-1, -1, -1, -1] #starting from target point to origin
z_val = [-1, -1, -1, -1]

x = 1
z = 1
theta_y = math.pi/4
plt.scatter(x, z, c='orange')

x_val[0] = x
z_val[0] = z

x_val[3] = 0
z_val[3] = 0

arm_lengths = [5, 6, -1, 7, -1] #starting from target, -1 means to be defined
angles = [-1, -1, -1, -1, -1, -1, -1] 
#7th: angle rotation of point 3

x_val[1] = abs(x)-math.cos(theta_y)*arm_lengths[0]
z_val[1] = z+math.sin(theta_y)*arm_lengths[0] #could be negative but theta_y is given

if x < 0:
    x_val[1] *= -1

arm_lengths[2] = length(x_val[0], z_val[0], x_val[3], z_val[3]) #Wrong, need to be fixed

angles[0] = cosine_law_angle(arm_lengths[0], arm_lengths[2], arm_lengths[1])
angles[1] = cosine_law_angle(arm_lengths[0], arm_lengths[1], arm_lengths[2])
angles[2] = cosine_law_angle(arm_lengths[1], arm_lengths[2], arm_lengths[0])

#Temps the x and y components of the 2 points from the target
temp_z = z+math.sin(theta_y)*arm_lengths[0] #TO DO: could be + or - sin(theta_y), it should be given though
temp_x = abs(x)-math.cos(theta_y)*arm_lengths[0]
arm_lengths[4] = math.sqrt(temp_z**2+temp_x**2)

angles[3] = cosine_law_angle(arm_lengths[1], arm_lengths[4], arm_lengths[3])
angles[4] = cosine_law_angle(arm_lengths[1], arm_lengths[3], arm_lengths[4])
angles[5] = cosine_law_angle(arm_lengths[4], arm_lengths[3], arm_lengths[1])

angles[6] = np.arctan(temp_z/temp_x)+angles[5]

if x <= 0:
    angles[6] = math.pi-angles[6]

x_val[2] = math.cos(angles[6])*arm_lengths[3]
z_val[2] = math.sin(angles[6])*arm_lengths[3]

print(x_val)
print(z_val)
plt.plot(x_val, z_val)

for i in range(3):
    print(math.sqrt((x_val[i]-x_val[i+1])**2+(z_val[i]-z_val[i+1])**2))

plt.show()

"""
Bugs (4, 11)

"""

"""
TO DO:

"""