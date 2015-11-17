# -*- coding: utf8 -*- 

# from mpl_toolkits.mplot3d import Axes3D
from matplotlib.ticker import LogLocator
from matplotlib.ticker import MultipleLocator
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import copy
import math
import re
import os




def draw(x,y,path, title):

    plt.figure()

    # xticks
    xticks = copy.deepcopy(x)
    xticks = map(lambda x: "{0:.3f}".format(x) if x > 0.001 else "{0:.1e}".format(x), xticks)

    plt.xticks(np.arange(len(xticks)), xticks, rotation=60)
    # plt.yticks(np.arange(len(y)), y)

    plt.title(title)
    plt.xlabel('Cost')
    plt.ylabel('Accuracy')
    plt.grid(True)

    plt.plot(np.arange(len(x)),y)
    plt.show()



def split_info(lines):
    """ splits info read from file """
    cost = []
    gamma = []
    acc = []

    lines = filter(lambda x: x.strip() != "", lines)


    for line in lines:
        cost.append(float(re.findall("(?<=cost=)\d+.\d+", line)[0]))
        acc.append(float(re.findall("(?<=acc=)\d+.\d+", line)[0]))


    cost = sorted(list(set(cost)))

    return cost, acc



if __name__=="__main__":
    # cross validation file
    path = r"C:\Users\marcos\Desktop\work_path\models\RGB_1st_approach\rgb_definitivos\linear"
    name = r"inria_linear_rgb_model_R2"
    cv_file = os.path.join(path, name+".cv")
    
    # path where the plot will be saved
    save_path = cv_file.replace(".cv",".png")
    if save_path == cv_file:
        print "WARNING cv file was about to be over-written"
        raw_input("...")
        exit()

    # title of the plot
    title = cv_file.split("\\")[-1].replace("_"," ").replace(".cv","")

    # reading file
    f = open(cv_file, "r")
    lines = f.readlines()
    f.close()

    # getting info in list form
    cost, acc = split_info(lines)

    # drawing the cross validation grid
    draw(cost, acc, save_path, title)