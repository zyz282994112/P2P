clear
%需要先用matlab导入数据
load('导入网络文件.mat');

DataCleanScript;

exper=Experiment_Design(DataLabel,DataFeature,DataMatrix);
inputLabel=exper.crossValidateModel(10);

Slole_tmp=ComputeSij(DataMatrix{1,2});
Slobo_tmp=ComputeSij(DataMatrix{1,3});

auc_result=0;
precision_n=0;
precision_b=0;
recall_b=0;
recall_n=0;
for i=1:10
    disp('开始迭代坏账！');
    [flo_bad fle_bad fbo_bad]=Iteration_f(Slobo_tmp,Slole_tmp,DataLabel{1},DataLabel{2},DataLabel{3});
    disp('开始迭代正常结束贷款！');
    [flo_normall fle_normall fbo_normall]=Iteration_f(Slobo_tmp,Slole_tmp,-DataLabel{1},-DataLabel{2},-DataLabel{3});
    compute_para;
    auc_result=auc_result+result;
    precision_n=precision_n+precision_normall;
    precision_b=precision_b+precision_bad;
    recall_b=recall_b+recall_bad;
    recall_n=recall_n+recall_normall;
end

disp('十折交叉结果：');
tmp=sprintf('坏账准确率：%g;坏账召回率：%g。',precision_b/10,recall_b/10);
disp(tmp);
tmp=sprintf('正常准确率：%g;正常召回率：%g。',precision_n/10,recall_n/10);
disp(tmp);
tmp=sprintf('坏账AUC：%g。',auc_result/10);
disp(tmp);

