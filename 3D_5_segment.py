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
ax.set_xlim([0, 12])
ax.set_ylim([-5, 5])
ax.set_zlim([0, 12])

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
    print(length(points['C'], points['D']), length(points['D'], points['E']), length(points['E'], points['F']))

def check_possibility():
    if length(points['C'], points['F']) > arm_lengths['CD']+arm_lengths['DE']+arm_lengths['EF']:
        return -1
    else:
        return 1

x = 11 #Given
y = 0.995
z = 5.0998
theta_x = math.pi/4
theta_y = 0.1
z0 = z-math.tan(theta_x)*abs(y)
z1 = z-z0

#TO DO: Find relative angles

arm_lengths = {}
arm_lengths['AB'] = z0
arm_lengths['BC'] = 3 #Given
arm_lengths['CD'] = 4 #Given
arm_lengths['DE'] = 5 #Given
arm_lengths['EF'] = 6 #Given

points = {}
points['A'] = np.array([0, 0, 0]) #(x, y, z)
points['B'] = np.array([0, 0, z0])
points['C'] = np.array([arm_lengths['BC'], 0, z0])
points['D'] = None
points['E'] = np.array([x-math.cos(theta_y)*arm_lengths['EF'], y+math.sin(theta_y)*arm_lengths['EF']*math.cos(theta_x), z+math.sin(theta_y)*arm_lengths['EF']*math.sin(theta_x)]) #TO DO: Find using thetas
points['F'] = np.array([x, y, z])

arm_lengths['CE'] = length(points['C'], points['E'])

vectors = {}
vectors['CF'] = points['F']-points['C']
vectors['CE'] = points['E']-points['C']

#TO DO: Check if solve is possible through length and triangle inequality
if check_possibility() == -1:
    print("Length NOT POSSIBLE")
    quit()

if triangle_inequality(arm_lengths['CD'], arm_lengths['DE'], arm_lengths['CE']) == -1:
    print("Triangle NOT POSSIBLE")
    quit()

#print('V', vectors['RA'], vectors['RB'])
cross_X = np.cross(vectors['CF'], vectors['CE']) #TODO: Check sign
cross_Y = np.cross(cross_X, vectors['CE'])
print("CROSS", cross_X, cross_Y) 

h = 2*heron(arm_lengths['CE'], arm_lengths['CD'], arm_lengths['DE'])/arm_lengths['CE']
vectors['GD'] = h*cross_Y/np.linalg.norm(cross_Y)

arm_lengths['CG'] = math.sqrt(arm_lengths['CD']**2-h**2)
vectors['CG'] = arm_lengths['CG']*vectors['CE']/np.linalg.norm(vectors['CE'])

if math.sqrt(arm_lengths['DE']**2-h**2) >= arm_lengths['CE']:
    vectors['CG'] *= -1

vectors['CD'] = vectors['CG']+vectors['GD'] #Check add or subtract depending on triangle type
points['D'] = vectors['CD']+points['C']

angles = {}
angles['C'] = cosine_law_angle(arm_lengths['BC'], arm_lengths['CD'], length(points['B'], points['D']))
angles['D'] = cosine_law_angle(arm_lengths['CD'], arm_lengths['DE'], arm_lengths['CE'])
angles['E'] = cosine_law_angle(arm_lengths['DE'], arm_lengths['EF'], length(points['D'], points['F']))
angles['F'] = None

x_val = []
y_val = []
z_val = []

for key, val in points.items():
    x_val.append(val[0])
    y_val.append(val[1])
    z_val.append(val[2])
    graph(points[key])

    print(round(x_val[-1], 3), round(y_val[-1], 3), round(z_val[-1], 3))

    ax.text(x_val[-1]+0.1, y_val[-1]+0.1, z_val[-1]+0.1, key) #Print point

    if key != 'A': #Print Length
        ax.text((x_val[-1]+x_val[-2])/2, (y_val[-1]+y_val[-2])/2, (z_val[-1]+z_val[-2])/2, round(length(points[key], points[prev_key]), 3))
    prev_key = key

    if key != 'A' and key != 'B' and key!='F':
        ax.text(x_val[-1]-0.5, y_val[-1]-0.5, z_val[-1]-0.5, round(angles[key], 3), color='blue')

print_length()
ax.plot(x_val, y_val, z_val)
ax.scatter(x, y, z, c='violet')

plt.show()
print("A")