import matplotlib
import matplotlib.pyplot as plt
import numpy
import math
import random
import numpy as np
import matplotlib.animation as anm
import os

fig = plt.figure()
ax = plt.axes(xlim=(-10, 10), ylim=(-10, 10))
line = ax.plot([], [], lw=2)[0]


def cosine_law_angle(a, b, c):
    #print(a, b, c)
    try:
        num = (a**2+b**2-c**2)/(2*a*b)
    except:
        return 0
    #print("num", num)

    return np.arccos(num)

def segment_1_rotation(x, y, first_angle, tan_angle): 
    #finding angle rotated by the first segment
    #assuming that thte first segment is the closer one to the x-axis

    if (x >= 0 and y >= 0):
        return tan_angle-first_angle
    elif x < 0 and y>=0:
        return math.pi+tan_angle+first_angle #tan_angle is negative
    elif x < 0 and y < 0:
        return math.pi+tan_angle-first_angle
    else:
        return 2*math.pi+tan_angle+first_angle


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


arms_lengths = []
arms_lengths.append(6)
arms_lengths.append(4)

#equation: x^2+y^2 = 7^2
r = 7


def find_target_point(i):

    #For a circle
    """alpha = i*2*math.pi/180
    x = r*math.cos(alpha)
    y = r*math.sin(alpha)"""

    #For sinusoidal wave
    if i % (4*r) >= 2*r:
        x = r-(i%(2*r))
        print("F1", x)
    else:
        x = -1*r+(i%(2*r))
        print("F2", x)
    y = math.sin(x)

    #print("FIND", x, y)
    return x, y


#x, y = map(int, input().split(" "))

#Drawing shape outline
"""circle1 = plt.Circle((0, 0), radius=r, fill = False) #circle
ax.add_artist(circle1)"""

x_sin = [i for i in range(-r, r+1)] #Sinusoidal wave
y_sin = [math.sin(i) for i in range(-r, r+1)]
plt.plot(x_sin, y_sin)


def animate(i):

    x, y = find_target_point(i)
    target_length = math.sqrt(x**2+y**2)
    print(x, y, i, target_length)

    if (triangle_inequality(target_length, arms_lengths[0], arms_lengths[1]) == -1):
        print("Not possible")
        #print(x, y, i)
        quit()

    angle = []  # in radians
    # first angle in triangle
    angle.append(cosine_law_angle(
        target_length, arms_lengths[0], arms_lengths[1]))
    # second angle in triangle
    angle.append(cosine_law_angle(
        arms_lengths[0], arms_lengths[1], target_length))
    try:
        angle.append(np.arctan(y/x))  # large angle
    except:
        angle.append(-math.pi/2)

    angle.append(segment_1_rotation(x, y, angle[0], angle[-1]))  # segment 1 rotated angle

    points = [[]]
    points[0] = ([0, 0])
    points.append([arms_lengths[0]*math.cos(angle[-1]),
                   arms_lengths[0]*math.sin(angle[-1])])
    points.append([x, y])

    x_val = ([0, arms_lengths[0]*math.cos(angle[-1]), x])
    y_val = ([0, arms_lengths[0]*math.sin(angle[-1]), y])

    for j in range(len(x_val)-1):
        try:
            length = (x_val[j]-x_val[j+1])**2+(y_val[j]-y_val[j+1])**2
            print("J", j, length)
            if length >= 25:
                print("*****")
                print(x_val, y_val, "Angle", angle, "length", length)
                #os.system("pause")
        except:
            print((x_val[j]-x_val[j+1])**2+(y_val[j]-y_val[j+1]**2))

    line.set_data(x_val, y_val)
    return line, 


anim = anm.FuncAnimation(fig, animate, frames = 1000, interval = 120, blit = True)
plt.show()
