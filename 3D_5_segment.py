#Works
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import math

fig = plt.figure()
ax = plt.axes(projection='3d')
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
ax.set_xlim([0, 10])
ax.set_ylim([-5, 5])
ax.set_zlim([0, 10])

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


def length(pointA, pointB):
    return math.sqrt((pointA[0]-pointB[0])**2+(pointA[1]-pointB[1])**2+(pointA[2]-pointB[2])**2)

def heron(a, b, c):
    s = (a+b+c)/2
    area = math.sqrt(s*(s-a)*(s-b)*(s-c))
    return area

def graph(point):
    ax.scatter(point[0], point[1], point[2], c='red')

def print_length():
    print(length(points['R'], points['C']), length(points['C'], points['B']), length(points['B'], points['A']))

def check_possibility():
    if length(points['A'], points['R']) > arm_lengths['RC']+arm_lengths['CB']+arm_lengths['BA']:
        return -1
    else:
        return 1

x = 9 #Given
y = 2
z = 10
theta_x = math.pi/4
theta_y = math.pi/6
z0 = z-math.tan(theta_x)*y
z1 = z-z0

#TO DO: Find relative angles

arm_lengths = {}
arm_lengths['OZ'] = z0
arm_lengths['ZR'] = 3 #Given
arm_lengths['RC'] = 4 #Given
arm_lengths['CB'] = 4 #Given
arm_lengths['BA'] = 4 #Given

points = {}
points['O'] = np.array([0, 0, 0]) #(x, y, z)
points['Z'] = np.array([0, 0, z0])
points['R'] = np.array([arm_lengths['ZR'], 0, z0])
points['C'] = None
points['B'] = np.array([x-math.cos(theta_y)*arm_lengths['BA'], y+math.sin(theta_y)*arm_lengths['BA']*math.cos(theta_x), z+math.sin(theta_y)*arm_lengths['BA']*math.sin(theta_x)]) #TO DO: Find using thetas
points['A'] = np.array([x, y, z])

arm_lengths['RB'] = length(points['R'], points['B'])

vectors = {}
vectors['OZ'] = points['Z']-points['O']
vectors['ZR'] = points['R']-points['Z']
vectors['RA'] = points['A']-points['R']
vectors['RB'] = points['B']-points['R']

#TO DO: Check if solve is possible through length and triangle inequality
if check_possibility() == -1:
    print("Length NOT POSSIBLE")
    quit()

if triangle_inequality(arm_lengths['RC'], arm_lengths['CB'], length(points['B'], points['R'])) == -1:
    print("Triangle NOT POSSIBLE")
    quit()

cross_X = np.cross(vectors['RA'], vectors['RB'])
cross_Y = np.cross(cross_X, vectors['RB'])

h = 2*heron(arm_lengths['RC'], arm_lengths['RB'], arm_lengths['CB'])/arm_lengths['RB']
vectors['DC'] = h*cross_Y/np.linalg.norm(cross_Y)

arm_lengths['RD'] = math.sqrt(arm_lengths['RC']**2-h**2)
vectors['RD'] = arm_lengths['RD']*vectors['RB']/np.linalg.norm(vectors['RB'])
point_D = points['R']+vectors['RD']
arm_lengths['DB'] = length(point_D, points['B'])

vectors['RC'] = vectors['RD']+vectors['DC']
points['C'] = vectors['RC']+points['R']

angles = {}
angles['R'] = None
angles['C'] = cosine_law_angle(arm_lengths['RC'], arm_lengths['CB'], arm_lengths['RB'])
angles['B'] = cosine_law_angle(arm_lengths['CB'], arm_lengths['BA'], length(points['A'], points['C']))
angles['A'] = None

x_val = []
y_val = []
z_val = []

for key, val in points.items():
    x_val.append(val[0])
    y_val.append(val[1])
    z_val.append(val[2])
    graph(points[key])

    ax.text(x_val[-1]+0.1, y_val[-1]+0.1, z_val[-1]+0.1, key) #Print point

    if key != 'O': #Print Length
        ax.text((x_val[-1]+x_val[-2])/2, (y_val[-1]+y_val[-2])/2, (z_val[-1]+z_val[-2])/2, round(length(points[key], points[prev_key]), 3))

    prev_key = key

print_length()
ax.plot(x_val, y_val, z_val)
ax.scatter(x, y, z, c='violet')

plt.show()