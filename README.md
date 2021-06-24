# CNN_Oleander
This repository is intended for use in conjunction with Mogamat Nur Ally's (ALLMOG018) EEE4022F final year project.
This repository contains the files necessary to train and validate a CNN model using pytorch. This repository also forms part of the pipeline intended to be used in conjunction with a virtual machine. The machine used for this project was acquired from vast.ai.

## VM setup
1. ssh into the VM
ensure that the VM or server is running Ubuntu 20.04 and has CUDA 11.1 installed

2. run all commands found in the setup.txt file

## Create a Mask-R-CNN model
```bash
$ python3 MaskRCNN_maker.py
```

## Train the created model
This script saves model progress every 2 epochs. Train the model until the loss values converge or overfit
```bash
$ python3 MaskRCNN_trainer.py
```
## Use the model
This script will take in an image from the dataset and produce a predicted mask for the image called outputMask.jpg and also save the input image as inputImage.jpg.
This script will also output average accuracy characteristic values.
```bash
$ python3 MaskRCNN_predictor.py
```
## Keys
vast-ai-ssh-key.pub contains the public ssh key used to access the repository as well as scp to the VM/server.
vast-ai-ssh-key contains the private ssh key used to access the repository as well as scp to the VM/server.
Use these keys to establish SCP communication with the VM/server to retrieve the model save file "my_maskrcnn_model.pth.tar".
Sometimes these keys need to be verified on github under the Deploy keys tab in Settings.

## Dependencies
coco_eval.py , coco_utils.py , engine.py , transforms.py , and utils.py are all dependencies required by the scripts. 
