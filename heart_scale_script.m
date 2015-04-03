clear
import ClassifierPackage.*;
import EvaluationPackage.*;
import ValidatePackage.*;
%%������ϴ
% DataClean_heart_scale;

%%load dataset
dataset=DataSet('heart_scale',1);

%%��������

classify=SVM('SVM');
eval=PrecisionRecallEvaluation('prediction');
eval2=AUCEvaluation('auc');
exper=HoldoutValidateModel('HoldoutValidateModel');
% exper=CrossValidateModel('CrossValidateModel');
% exper.UnlabelDataTag=0;


% exper.lamada=0.3;
evalall={eval,eval2};
evalall=exper.Run(dataset,classify,evalall);

result={dataset,classify,exper,evalall};
% exper.WriteMode='a';
exper.SaveResult(result);