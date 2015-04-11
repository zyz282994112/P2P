%%clean heart_scale dataset
clear 

DataLabel=cell(1,1);
DataFeature=cell(1,1);
DataMatrix=cell(1,1);

[DataLabel{1}, DataFeature{1}] = libsvmread('P2P_feature.libsvm');

save('P2P_feature.mat');