#Works
import matplotlib
import matplotlib.pyplot as plt
import numpy
import math
import random
import numpy as np
import matplotlib.animation as anm

fig, ax = plt.subplots()
ax.axis([-10, 10, -10, 10])

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

def length(x1, y1, x2, y2):
    return math.sqrt((x1-x2)**2+(y1-y2)**2)

arms_lengths = []
arms_lengths.append(4)
arms_lengths.append(7)

x, y = map(int, input().split(" "))
plt.scatter(x, y, s=10, c='red')
target_length = math.sqrt(x**2+y**2)

if (triangle_inequality(target_length, arms_lengths[0], arms_lengths[1]) == -1):
    print("Not possible")
    #print(x, y, i)
    quit()

angle = []  # in radians
# first angle in triangle - works
angle.append(cosine_law_angle(
    target_length, arms_lengths[0], arms_lengths[1]))
# second angle in triangle - works
angle.append(cosine_law_angle(
    arms_lengths[0], arms_lengths[1], target_length))

try:
    angle.append(np.arctan(y/x)) # large angle (tangent)
except:
    angle.append(-math.pi/2)

angle.append(segment_1_rotation(x, y, angle[0], angle[-1]))  # rotated angle

points = [[]]
points[0] = ([0, 0])
points.append([arms_lengths[0]*math.cos(angle[-1]),
                arms_lengths[0]*math.sin(angle[-1])])
points.append([x, y])

x_val = ([0, arms_lengths[0]*math.cos(angle[-1]), x])
y_val = ([0, arms_lengths[0]*math.sin(angle[-1]), y])
print("THEORY", target_length, arms_lengths)
print("ACTUAL L", (length(0, 0, x_val[1], y_val[1]), angle[1]), end=' ')
print(length(x_val[2], y_val[2], x_val[1], y_val[1]))
print(angle)

plt.plot(x_val, y_val)

plt.show()


""" Problems:
1Q (test)
(4, 5)
Target length: 6.403
Arm length: 5, 5
First angle: 0.8759
Second angle: 1.38977
Tangent: 0.896055
Rotated angle: 0.020155

2Q
(-4, 5)
Target length: 6.403
Arm length: 5, 5
First angle: 0.8759
Second angle: 1.38977
Tangent: -0.896055
Rotated angle: 3.12143

3Q
(-4, -5)
Target length: 6.403
Arm length: 5, 5
First angle: 0.8759
Second angle: 1.38977
Tangent: 0.896055
Rotated angle: 3.1617

4Q
Target length: 6.403
Arm length: 5, 5
First angle: 0.8759
Second angle: 1.38977
Tangent: -0.896055
Rotated angle: 6.263

"""