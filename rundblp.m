%需要先用matlab导入数据
num=4;%%表示有几种类型的节点
classlabel=[1 2 3 4];%%表示分类label  %%1:paper 2:author 3:conf 4:term 0:未知
load('DBLP.mat');

DataLabel=cell(num,1);%%存储节点label
DataFeature=cell(num,1);%%存储节点feature。dblp数据集无feature
DataMatrix=cell(num,num);%%每个元素DataMatrix{i,j}存储类型为i的节点与类型为j的节点的0-1链接矩阵
MaxDataNum=[654269,472635,4096,13571];

DataCleanScriptdblp;%%将数据转为向量（or关联矩阵）存入DataLabel和DataMatrix中，同时去除所有孤立点

S=cell(num,num);
for i=1:num
    for j=1:num
        S{i,j}=ComputeSij(DataMatrix{i,j});
    end
end

inputLabel=cell(num,1);
traintag=cell(num,1);   
testtag=cell(num,1);
y=cell(num,1);
chouyangbili=[0.005,0.005,0,0];%%不同类型节点的抽样比例
for i=1:num
    inputLabel{i}=zeros(size(DataLabel{i}));
    switch chouyangbili(i)
        case 1
            traintag{i}=ones(size(DataLabel{i}));
            testtag{i}=zeros(size(DataLabel{i}));
        case 0
            testtag{i}=ones(size(DataLabel{i}));
            traintag{i}=zeros(size(DataLabel{i}));
        otherwise
            [traintag{i},testtag{i}] = crossvalind('HoldOut',DataLabel{i},1-chouyangbili(i));
    end
    inputLabel{i}(traintag{i}==1)=DataLabel{i}(traintag{i}==1);
    y{i}=zeros(length(inputLabel{i}),length(classlabel));
    for j=1:length(classlabel)
        y{i}(inputLabel{i}==classlabel(j),j)=1;
    end
end

lamada=ones(num,num)*0.2;
afa=ones(num,1)*0.1;

% f=Iteration_dblp(S,y,lamada,afa);%%答案与闭式解相同
 
%%以下方法为闭式解
%%闭式解需要给Sij赋予0值
for i=1:num
    for j=1:num
        if isempty(S{i,j})
            S{i,j}=sparse(zeros(length(DataLabel{i}),1))*sparse(zeros(length(DataLabel{j}),1))';
        end
    end
end
f=ClosedSolution(S,y,lamada,afa);

target=2;%%表示要分类的节点
[a,PredictionLabel]=max(f{target}'); %#ok<UDIM>
PredictionLabel(all(f{target}'==0))=0;
PredictionLabel=PredictionLabel';

%%‘还原’label(k个不同label的n维0-1向量转换回n维向量)
tmp1=DataLabel{target}(testtag{target}==1);
tmp2=PredictionLabel(testtag{target}==1);
tmp2(tmp1==0)=[];
tmp1(tmp1==0)=[];

%%计算准确率
cp = classperf(cellstr(num2str(tmp1)));
classperf(cp,cellstr(num2str(tmp2)));
cp.CorrectRate
% for i=1:length(cp.ClassLabels)
%     [x, y, t, auc]=perfcurve(DataLabel{target}(testtag{target}==1),PredictionLabel(testtag{target}==1),cp.ClassLabels{i});
%     auc
% end