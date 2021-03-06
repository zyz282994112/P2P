clear
%%1表示正常结束，-1表示坏账，0表示未知
%%含申请中、还款中等其它未标记节点

load('P2PRowData_all.mat');%%不知道怎么写
num=4;

DataLabel=cell(num,1);
DataFeature=cell(num,1);
DataMatrix=cell(num,num);

maxuser=1454955;
maxloan=439233;
maxborrowertype=10;

v1=VectorTransform(cell2mat(creditinfo(:,1)),maxloan)|VectorTransform(investor(:,1),maxloan);
DataLabel{1}=zeros(length(v1),1);
DataLabel{1}(creditlabel(:,1))=creditlabel(:,2);
DataLabel{1}(v1==0)=[];

v2=VectorTransform(cell2mat(creditinfo(:,2)),maxuser);
DataLabel{2}=zeros(length(v2),1);
DataLabel{2}(v2==0)=[];

v3=VectorTransform(investor(:,2),maxuser);
DataLabel{3}=zeros(length(v3),1);
DataLabel{3}(v3==0)=[];

v4=VectorTransform(loan_borrowertype(:,2),maxborrowertype);
DataLabel{4}=zeros(length(v4),1);
DataLabel{4}(v4==0)=[];

DataMatrix{1,2}=Data_Clean(MatrixTransform(cell2mat(creditinfo(:,1:2)),v1,v2),v1,v2);
DataMatrix{2,1}=DataMatrix{1,2}';
DataMatrix{1,3}=Data_Clean(MatrixTransform(investor,v1,v3),v1,v3);
DataMatrix{3,1}=DataMatrix{1,3}';
DataMatrix{1,4}=Data_Clean(MatrixTransform(loan_borrowertype,v1,v4),v1,v4);
DataMatrix{4,1}=DataMatrix{1,4}';


UnlabelTag=0;
ComputeLabel='-1';

% %%非平衡数据赋予不同权重时的引用方法（仿照hash）
% cell2mat(Unbalanceweight(cell2mat(Unbalanceweight(:,1))==-1,2))

clear v1 v2 v3 v4 maxloan maxuser creditinfo investor creditlabel num loan_borrowertype maxborrowertype

save 'P2P_all.mat'