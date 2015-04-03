clear
import ClassifierPackage.*;
import EvaluationPackage.*;
import ValidatePackage.*;
import DataCleanPackage.*;

% DataClean_P2P_all;%%������תΪ������or�������󣩴���DataLabel��DataMatrix�У�ͬʱȥ�����й�����


dataset=DataSet('P2P_all');
dataset.Unbalanceweight={-1,20;1,1};
num=3;

classify=GNetMine('GNetMine');
classify.lamada=ones(num,num)*0.2;
classify.afa=ones(num,1)*0.1;
eval=PrecisionRecallEvaluation('precision');
eval2=AUCEvaluation('auc');
evalall={eval,eval2};

% exper=CrossValidateModel('CrossValidateModel');
exper=HoldoutValidateModel('HoldoutValidateModel');
exper.WriteMode='a';
tmp=[0.01;0.1;0.5;0.7];
for i=1:length(tmp)
    exper.lamada=[tmp(i),0,0];
    exper.Run(dataset,classify,evalall);
    result={dataset,classify,exper,evalall};
    exper.SaveResult(result,'P2P_all_��Ȩ��');
end

clear eval eval2 i 

