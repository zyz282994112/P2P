clear

%��Ҫ����matlab��������
load('���������ļ�.mat');%%��֪����ôд

DataCleanScript;

fenleiqi=Propogation_Graph(DataLabel,DataFeature,DataMatrix);
fenleiqi.lamada=ones(3,3)*0.5;
fenleiqi.afa=ones(3,1)*0.5;
exper=Experiment_Design(DataLabel,DataFeature,DataMatrix);
[truelabel,predictionlabel]=exper.crossValidateModel(fenleiqi,10);
eval=Evaluation(truelabel,predictionlabel);
eval.ComputeConfusionMatrix();
eval.precision_recall();




disp('ʮ�۽�������');
tmp=sprintf('����׼ȷ�ʣ�%g;�����ٻ��ʣ�%g��',eval.precision(1),eval.recall(1));
disp(tmp);
[X Y T AUC]=perfcurve(truelabel,predictionlabel,1);
tmp=sprintf('����AUC��%g��',AUC);
disp(tmp);

