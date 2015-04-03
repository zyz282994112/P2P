clear
import ClassifierPackage.*;
import EvaluationPackage.*;
import ValidatePackage.*;
import DataCleanPackage.*;

% DataClean_dblp;%%将数据转为向量（or关联矩阵）存入DataLabel和DataMatrix中，同时去除所有孤立点

dataset=DataSet('dblp',2);
num=4;

classify=GNetMine('GNetMine');
classify.lamada=ones(num,num)*0.2;
classify.afa=ones(num,1)*0.1;
eval=PrecisionRecallEvaluation('precision');
eval2=AUCEvaluation('auc');
exper=HoldoutValidateModel('HoldoutValidateModel');
exper.lamada=[0.005,0.005,0,0];
% exper=CrossValidateModel('CrossValidateModel');

evalall={eval,eval2};
exper.Run(dataset,classify,evalall);

result={dataset,classify,exper,evalall};
% exper.WriteMode='a';
exper.SaveResult(result);




