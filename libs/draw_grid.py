# -*- coding: utf8 -*- 

from mpl_toolkits.mplot3d import Axes3D
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import math
import re


def draw_grid(X,Y,success_perc,path,title):
    """ Draw a grid with the corresponding value for X and Y """
    scores = np.array(success_perc).reshape(len(Y), len(X))
    
    plt.figure()
    plt.imshow(scores, interpolation='nearest', cmap=plt.cm.jet)
    plt.xlabel('X = Cost')
    plt.ylabel('Y = Gamma')
    plt.title(title)
    plt.colorbar()
    plt.xticks(np.arange(len(X)), X, rotation=45)
    plt.yticks(np.arange(len(Y)), Y)
    plt.show()
    # plt.savefig(path)


def split_info(lines):
    """ splits info read from file """
    cost = []
    gamma = []
    acc = []

    lines = filter(lambda x: x.strip() != "", lines)


    for line in lines:
        cost.append(float(re.findall("(?<=cost=)\d+.\d+", line)[0]))
        gamma.append(float(re.findall("(?<=gamma=)\d+.\d+", line)[0]))
        acc.append(float(re.findall("(?<=acc=)\d+.\d+", line)[0]))


    cost = sorted(list(set(cost)))[::-1]
    gamma = sorted(list(set(gamma)))

    return cost, gamma, acc



if __name__=="__main__":
    # cross validation file
    cv_file = r"C:\Users\jose\Desktop\work_path\models\rgb_definitivos\rbf\inria_rbf_rgb_preModel.cv"
    
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
    cost, gamma, acc = split_info(lines)

    # drawing the cross validation grid
    draw_grid(gamma,cost, acc, save_path, title)