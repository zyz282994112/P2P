clear

%需要先用matlab导入数据
load('导入网络文件.mat');%%不知道怎么写

DataCleanScript;

fenleiqi=Propogation_Graph(DataLabel,DataFeature,DataMatrix);
fenleiqi.lamada=ones(3,3)*0.5;
fenleiqi.afa=ones(3,1)*0.5;
exper=Experiment_Design(DataLabel,DataFeature,DataMatrix);
[truelabel,predictionlabel]=exper.crossValidateModel(fenleiqi,10);
eval=Evaluation(truelabel,predictionlabel);
eval.ComputeConfusionMatrix();
eval.precision_recall();




disp('十折交叉结果：');
tmp=sprintf('坏账准确率：%g;坏账召回率：%g。',eval.precision(1),eval.recall(1));
disp(tmp);
[X Y T AUC]=perfcurve(truelabel,predictionlabel,1);
tmp=sprintf('坏账AUC：%g。',AUC);
disp(tmp);

