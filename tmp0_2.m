clear

%%������ϴ
[heart_scale_label, heart_scale_inst] = libsvmread('heart_scale');
DataLabel=cell(3,1);
DataFeature=cell(3,1);
DataMatrix=cell(3,3);


DataLabel{1}=heart_scale_label;
DataFeature{1}=heart_scale_inst;


%%��������

AAA=SVM(DataLabel,DataFeature,DataMatrix);
exper=SetExperiment(DataLabel,DataFeature,DataMatrix);
% exper.crossValidateModel(AAA,4);
exper.HoldoutValidation(AAA,1,0.1);
