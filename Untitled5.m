clear
%%数据清洗
% DataClean_heart_scale;

%%load dataset
dataset=DataSet('heart_scale');

%%程序运行

classify=SVM('SVM');
eval=PrecisionRecallEvaluation('precision');
eval2=AUCEvaluation('auc');
% exper=HoldoutValidateModel('HoldoutValidateModel');
exper=CrossValidateModel('CrossValidateModel');
% exper.UnlabelDataTag=0;


% exper.lamada=0.3;
evalall={eval,eval2};
evalall=exper.Run(dataset,classify,evalall,1);

result={dataset,classify,exper,evalall};
% exper.WriteMode='a';
exper.SaveResult(result);