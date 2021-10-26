# HOG-Pedestrian-Detector


![CRAN](https://img.shields.io/cran/l/devtools.svg)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fjmrf%2FHOG-Pedestrian-Detector.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fjmrf%2FHOG-Pedestrian-Detector?ref=badge_shield)
![stars](https://img.shields.io/github/stars/jmrf/HOG-Pedestrian-Detector?style=social)
![forks](https://img.shields.io/github/forks/jmrf/HOG-Pedestrian-Detector?style=social)


This repository contains the code for a MATLAB implementation of a basic HOG + SVM pedestrian detector form my Computer Science Master [thesis](https://upcommons.upc.edu/bitstream/handle/2099.1/21343/95066.pdf?sequence=1&isAllowed=y)

## Disclaimer

If you are going to use this code, please read the `LICENCE` and keep in mind that I `PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY
OF ANY KIND`.

I partially adapted this code-base to newer versions of MATLAB but is very likely you find discrepancies in how some MATLAB functions work. 
I am in general happy to help understanding the project if you ask nicely but since the implementation of the project is now several years old and MATLAB has evolved, some functions might behave differently and I won't be updating the project continuously nor answering about how to update the code to newer MATLAB versions.

## Requirements

* MATLAB >= R2017b
* [libsvm](https://github.com/cjlin1/libsvm/tree/v322) >= 3.22

## Installation

Please refer to MATLAB and libsvm documentation to install.



## Data



## Run

The project was developed on a Windows machine and now being resurrected on a Linux one, so you should be good in any platform as long as you can run MATLAB.

### Setting the environment

1. Add the `libs` directory and **all** sub-directories to MATLABs path.
Either through the [command window](https://www.mathworks.com/help/matlab/ref/addpath.html) or through the GUI.

2. Make sure `libsvm` is visible to MATLAB. If you are not sure if your installation of `libsvm` went alright, you can check with:
```matlab
which -all svmtrain
```
Which should show something like:
```
~/HOG-Pedestrian-Detector/libs/libsvm-3.22/matlab/svmtrain.mexa64
/usr/local/MATLAB/R2017b/toolbox/stats/stats/svmtrain.m                 % Shadowed
```

There are several entry points to the project, but here the two main ones are shown:

### Train

Assuming there's a `models` directory where trained models will be saved and that the positive and negative images can be found in `dataset/Test/pos` and `dataset/Test/neg` respectively.
Train an SVM model named `test`
```matlab
model = train_svm("test", ["./models", "dataset/Train/pos" "dataset/Train/neg"]);
```

### Eval

To evaluate the just trained model:
```matlab
test_svm(model.test, ["dataset/Test/pos" "dataset/Test/neg"]);
```

Note `test_svm` expects `model.<model-given-name-to-train-function>`...

### PCA versions of train / test

```matlab
[model, Ureduce] = train_svm_PCA("test_pca", ["./models", "dataset/Train/pos" "dataset/Train/neg"]);
test_svm_PCA(model.test_pca, Ureduce, ["dataset/Test/pos", "dataset/Test/neg"]);
```



## Known issues & contributions

Old MATLAB version used to concatenate strings by enclosing them between squared brackets but doesn't look like valid any longer. In that case you should use the `strcat` function. For example when constructing paths, so:

```matlab
path = ['folder', 'filename', '.extension']  % this is wrong!
path = strcat('folder', 'filename', '.extension')  % this is right!
```



If you enjoyed this repository and find things that are not working any longer, you are very welcome to open a PR with fixes and I'll happily introduce them.





## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fjmrf%2FHOG-Pedestrian-Detector.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fjmrf%2FHOG-Pedestrian-Detector?ref=badge_large)
