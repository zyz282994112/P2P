clear
import ClassifierPackage.*;
import EvaluationPackage.*;
import ValidatePackage.*;
import DataCleanPackage.*;

% DataClean_dblp;%%������תΪ������or�������󣩴���DataLabel��DataMatrix�У�ͬʱȥ�����й�����

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




