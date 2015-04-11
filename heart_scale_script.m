clear
import ClassifierPackage.*;
import EvaluationPackage.*;
import ValidatePackage.*;
%%数据清洗
% DataClean_heart_scale;

%%load dataset
dataset=DataSet('P2P_feature',1);

%%程序运行

classify=SVM('LogisticRegression');
eval=PrecisionRecallEvaluation('prediction');
eval.IsAve=0;
eval2=AUCEvaluation('auc');
exper=HoldoutValidateModel('HoldoutValidateModel');
% exper=CrossValidateModel('CrossValidateModel');


% exper.lamada=0.3;
evalall={eval,eval2};
evalall=exper.Run(dataset,classify,evalall);

result={dataset,classify,exper,evalall};
% exper.WriteMode='a';
exper.SaveResult(result);