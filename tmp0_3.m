clear
load('DBLP.mat');

num=4;
DataLabel=cell(num,1);%%存储节点label
DataFeature=cell(num,1);%%存储节点feature。dblp数据集无feature
DataMatrix=cell(num,num);%%每个元素DataMatrix{i,j}存储类型为i的节点与类型为j的节点的0-1链接矩阵
MaxDataNum=[654269,472635,4096,13571];

DataCleanScriptdblp;%%将数据转为向量（or关联矩阵）存入DataLabel和DataMatrix中，同时去除所有孤立点      


classlabel=[1 2 3 4];%%表示分类label  %%1:paper 2:author 3:conf 4:term 0:未知
lamada=ones(num,num)*0.2;
afa=ones(num,1)*0.1;
AAA=GNetMine(DataLabel,DataFeature,DataMatrix,classlabel,lamada,afa);
exper=SetExperiment(DataLabel,DataFeature,DataMatrix);
chouyangbili=[0.005,0.005,0,0];
exper.HoldoutValidation(AAA,2,chouyangbili);%对author进行分类