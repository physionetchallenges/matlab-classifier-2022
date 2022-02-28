# MATLAB example classifier code for the George B. Moody PhysioNet Challenge 2022

## What's in this repository?

This repository contains a simple example to illustrate how to format a MATLAB entry for the George B. Moody PhysioNet Challenge 2022. You can try it by running the following commands on the Challenge training sets. These commands should take a few minutes or less to run from start to finish on a recent personal computer.

For this example, we implemented a random forest classifier with several features. You can use a different classifier, features, and libraries for your entry. This simpple example is designed **not** not to perform well, so you should **not** use it as a baseline for your model's performance.

This code uses four main scripts, described below, to train and run a model for the 2022 Challenge.

## How do I run these scripts?

You can train your model starting MATLAB and running

    train_model(training_data, model)

where

- `training_data` (input; required) is a folder with the training data files and
- `model` (output; required) is a folder for saving your model.

You can run your trained model by running

    run_model(model, test_data, test_outputs)

where

- `model` (input; required) is a folder for loading your model, and
- `test_data` (input; required) is a folder with the validation or test data files (you can use the training data for debugging and cross-validation), and
- `test_outputs` (output; required) is a folder for saving your model outputs.

You can evaluate your model by pulling or downloading the [evaluation code](https://github.com/physionetchallenges/evaluation-2022), installing Python, and running

    evaluate_model(labels, outputs, scores.csv, class_scores.csv)

where

- `labels` (input; required) is a folder with labels for the data, such as the [training data](https://physionetchallenges.org/2022/#data) on the PhysioNet webpage;
- `outputs` (input; required) is a folder containing files with your model's outputs for the data;
- `scores.csv` (output; optional) is a collection of scores for your model; and
- `class_scores.csv` (output; optional) is a collection of per-class scores for your model.

## Which scripts I can edit?

We will run the `train_model` and `run_model` scripts to train and run your model, so please check these scripts and the functions that they call.

Please edit the following script to add your training and testing code:

- `team_training_code.m` is a script with functions for training your model.
- `team_testing_code.m` is a script with functions for running your model.

Please do **not** edit the following scripts. We will use the unedited versions of these scripts when running your code:

- `train_model.m` is a script for training your model.
- `run_model.m` is a script for running your trained model.

These scripts must remain in the root path of your repository, but you can put other scripts and other files elsewhere in your repository.

## How do I train, save, load, and run my model?

To train and save your models, please edit the `team_training_code` function in the `team_training_code.m` script. Please do not edit the input or output arguments of the `team_training_code` function.

To load and run your trained model, please edit the `load_model` function in the `load_model.m` script and the `team_testing_code` function in the `team_testing_code.m` script. Please do not edit the input or output arguments of the functions of the `load_model` and `team_testing_code` functions.

## How do I learn more?

Please see the [Challenge website](https://physionetchallenges.org/2022/) for more details. Please post questions and concerns on the [Challenge discussion forum](https://groups.google.com/forum/#!forum/physionet-challenges).

## Useful links

- [Challenge website](https://physionetchallenges.org/2022/)
- [Python example classifier code](https://github.com/physionetchallenges/python-classifier-2022)
- [Scoring code](https://github.com/physionetchallenges/evaluation-2022)
- [Frequently asked questions (FAQ) for this year's Challenge](https://physionetchallenges.org/2022/faq/)
- [Frequently asked questions (FAQ) about the Challenges in general](https://physionetchallenges.org/faq/)
