%%clean heart_scale dataset
clear 

obj.DataLabel=cell(1,1);
obj.DataFeature=cell(1,1);
obj.DataMatrix=cell(1,1);

[obj.DataLabel{1}, obj.DataFeature{1}] = libsvmread('heart_scale');

save('heart_scale');