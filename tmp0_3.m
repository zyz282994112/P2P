clear
load('DBLP.mat');

num=4;
DataLabel=cell(num,1);%%�洢�ڵ�label
DataFeature=cell(num,1);%%�洢�ڵ�feature��dblp���ݼ���feature
DataMatrix=cell(num,num);%%ÿ��Ԫ��DataMatrix{i,j}�洢����Ϊi�Ľڵ�������Ϊj�Ľڵ��0-1���Ӿ���
MaxDataNum=[654269,472635,4096,13571];

DataCleanScriptdblp;%%������תΪ������or�������󣩴���DataLabel��DataMatrix�У�ͬʱȥ�����й�����      


classlabel=[1 2 3 4];%%��ʾ����label  %%1:paper 2:author 3:conf 4:term 0:δ֪
lamada=ones(num,num)*0.2;
afa=ones(num,1)*0.1;
AAA=GNetMine(DataLabel,DataFeature,DataMatrix,classlabel,lamada,afa);
exper=SetExperiment(DataLabel,DataFeature,DataMatrix);
chouyangbili=[0.005,0.005,0,0];
exper.HoldoutValidation(AAA,2,chouyangbili);%��author���з���