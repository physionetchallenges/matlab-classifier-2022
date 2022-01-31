# MATLAB example code for the George B. Moody PhysioNet/Computing in Cardiology Challenge 2022

## What's in this repository?

This repository contains a simple example to illustrate how to format a MATLAB entry for the 2022 Challenge. You can try it by running the following commands on the Challenge training sets. These commands should take a few minutes or less to run from start to finish on a recent personal computer.

For this example, we implemented a random forest classifier with several features. You can use a different classifier, features, and libraries for your entry. This simpple example is designed **not** not to perform well, so you should **not** use it as a baseline for your model's performance.

This code uses four main scripts, described below, to train and run a model for the 2022 Challenge.

## How do I run these scripts?

You can train and run your model by starting MATLAB and running

    train_model(training_data, model)
    run_model(model, test_data, test_outputs)

where `training_data` is a folder with the training data files, `model` is a folder for saving your model, `test_data` is a folder with the test data files (you can use the training data for debugging and cross-validation), and `test_outputs` is a folder for saving your model outputs. The [2022 Challenge website](https://physionetchallenges.org/2022/) provides a training database with a description of the contents and structure of the data files.

You can evaluate your model by running

    evaluate_model(labels, outputs, scores.csv, class_scores.csv)

where `labels` is a folder containing files with one or more labels for each ECG recording, such as the training database on the Challenge website; `outputs` is a folder containing files with outputs produced by your models for those recordings; `scores.csv` (optional) is a collection of scores for your models; and `class_scores.csv` (optional) is a collection of per-class scores for your models.

## Which scripts I can edit?

We will run the `train_model` and `run_model` scripts to train and run your model, so please check these scripts and the functions that they call.

Please edit the following script to add your training and testing code:

* `team_training_code.m` is a script with functions for training your model.
* `team_testing_code.m` is a script with functions for running your model.

Please do **not** edit the following scripts. We will use the unedited versions of these scripts when running your code:

* `train_model.m` is a script for training your model.
* `run_model.m` is a script for running your trained model.
* `evaluate_model.m` is a script with evaluating your model.

These scripts must remain in the root path of your repository, but you can put other scripts and other files elsewhere in your repository.

## How do I train, save, load, and run my model?

To train and save your models, please edit the `team_training_code` function in the `team_training_code.m` script. Please do not edit the input or output arguments of the `team_training_code` function.

To load and run your trained model, please edit the `load_model` function in the `load_model.m` script and the `team_testing_code` function in the `team_testing_code.m` script. Please do not edit the input or output arguments of the functions of the `load_model` and `team_testing_code` functions.

## How do I learn more?

Please see the [2022 Challenge website](https://physionetchallenges.org/2022/) for more details. Please post questions and concerns on the [Challenge discussion forum](https://groups.google.com/forum/#!forum/physionet-challenges).

## Useful links

* [2022 Challenge website](https://physionetchallenges.org/2022/)
* [Python example code](https://github.com/physionetchallenges/python-classifier-2022)
* [Frequently asked questions (FAQ) for this year's Challenge](https://physionetchallenges.org/2022/faq/) 
* [Frequently asked questions (FAQ) about the Challenges in general](https://physionetchallenges.org/faq/) 
