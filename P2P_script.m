clear
import ClassifierPackage.*;
import EvaluationPackage.*;
import ValidatePackage.*;
import DataCleanPackage.*;

% DataClean_P2P;%%将数据转为向量（or关联矩阵）存入DataLabel和DataMatrix中，同时去除所有孤立点
% DataClean_P2P_all;

% dataset=DataSet('P2P');
dataset=DataSet('P2P_all');
num=4;
classify=GNetMine('GNetMine');
classify.lamada=ones(num,num)*0.2;
classify.afa=ones(num,1)*0.1;
eval=PrecisionRecallEvaluation('precision');
eval2=AUCEvaluation('auc');
evalall={eval,eval2};

exper=CrossValidateModel('CrossValidateModel');
% exper=HoldoutValidateModel('HoldoutValidateModel');
exper.WriteMode='a';
tmp=1:3:30;
for i=1:length(tmp)
    tmp(i)
    classify.Unbalanceweight={-1,tmp(i);1,1};
    exper.Run(dataset,classify,evalall);
    result={dataset,classify,exper,evalall};
    exper.SaveResult(result,'P2P_all');
end

clear eval eval2 i 

