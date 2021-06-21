import torch
import torch.onnx as onnx
import torchvision.models as models



print ("start")
dataset = NNDataset('/root/CNN_Oleander/dataset/', get_transform(train=True))
dataset_test = NNDataset('/root/CNN_Oleander/dataset/', get_transform(train=False))

# split the dataset in train and test set
torch.manual_seed(1)
indices = torch.randperm(len(dataset)).tolist()
print(len(dataset))
# NB: change the portion of train and test set according to the size of the whole dataset
dataset = torch.utils.data.Subset(dataset, indices[:-6])
dataset_test = torch.utils.data.Subset(dataset_test, indices[-6:])
print(len(dataset))

# define training and validation data loaders
data_loader = torch.utils.data.DataLoader(
    dataset, batch_size=2, shuffle=True, num_workers=2,
    collate_fn=utils.collate_fn)

data_loader_test = torch.utils.data.DataLoader(
    dataset_test, batch_size=1, shuffle=False, num_workers=2,
    collate_fn=utils.collate_fn)


device = torch.device('cuda') #if torch.cuda.is_available() else torch.device('cpu')
#device = torch.device('cpu')
# our dataset has two classes only - background and label
num_classes = 2


# get the model using our helper function
checkpoint = torch.load("my_model.pth.tar")

model = torchvision.models.detection.maskrcnn_resnet50_fpn() # we do not specify pretrained=True, i.e. do not load default weights
model.load_state_dict(torch.load(checkpoint['state_dict'])
model.to(device)

# construct an optimizer
params = [p for p in model.parameters() if p.requires_grad]
optimizer = torch.optim.SGD()
lr_scheduler = torch.optim.lr_scheduler.StepLR(optimizer,
                                               step_size=3,
                                               gamma=0.1)
# and a learning rate scheduler which decreases the learning rate by
# 10x every 3 epochs


# CNN training
# train for epochs
# NB: change number of epochs according to the size of dataset
# few epochs for small dataset to avoid overfitting
optimizer.load_state_dict(torch.load(checkpoint['optimizer'])

num_epochs = 10

for epoch in range(num_epochs):
    # train for one epoch, printing every 5 iteration
    train_one_epoch(model, optimizer, data_loader, device, epoch, print_freq=5)
    # update the learning rate
    lr_scheduler.step()
    # evaluate on the test dataset
    evaluate(model, data_loader_test, device=device)
    
# save
checkpoint = {'state_dict' : model.state_dict(), 'optimizer': optimizer.state_dict()}
torch.save(checkpoint, "my_model.pth.tar")