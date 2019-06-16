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


def length(pointA, pointB):
    return math.sqrt((pointA[0]-pointB[0])**2+(pointA[1]-pointB[1])**2+(pointA[2]-pointB[2])**2)

def heron(a, b, c):
    s = (a+b+c)/2
    area = math.sqrt(s*(s-a)*(s-b)*(s-c))
    return area

def graph(point):
    ax.scatter(point[0], point[1], point[2], c='red')

points = {}
points['O'] = np.array([0, 0, 0])
points['A'] = np.array([4, 5, 4])
points['B'] = np.array([2, 3, 7])

vectors = {}
vectors['OA'] = points['A']-points['O']
vectors['OB'] = points['B']-points['O']

arm_lengths = {}
arm_lengths['OC'] = 4
arm_lengths['CB'] = 4
arm_lengths['OB'] = length(points['O'], points['B'])

cross_X = np.cross(vectors['OA'], vectors['OB'])
cross_Y = np.cross(cross_X, vectors['OB'])

h = 2*heron(arm_lengths['OC'], arm_lengths['OB'], arm_lengths['CB'])/arm_lengths['OB']
vectors['DC'] = h*cross_Y/np.linalg.norm(cross_Y)

arm_lengths['OD'] = math.sqrt(arm_lengths['OC']**2-h**2)
vectors['OD'] = arm_lengths['OD']*vectors['OB']/np.linalg.norm(vectors['OB'])
points['D'] = points['O']+vectors['OD']
arm_lengths['DB'] = length(points['D'], points['B'])

vectors['OC'] = vectors['OD']+vectors['DC']
points['C'] = vectors['OC']+points['O']

graph(points['O'])
graph(points['C'])
graph(points['B'])
graph(points['A'])

plt.show()

