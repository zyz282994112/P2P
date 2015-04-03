clear
%%1��ʾ����������-1��ʾ���ˣ�0��ʾδ֪
%%�������С������е�����δ��ǽڵ�

load('P2PRowData_all.mat');%%��֪����ôд

DataLabel=cell(3,1);
DataFeature=cell(3,1);
DataMatrix=cell(3,3);

maxuser=1454955;
maxloan=439233;

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

DataMatrix{1,2}=Data_Clean(MatrixTransform(cell2mat(creditinfo(:,1:2)),v1,v2),v1,v2);
DataMatrix{2,1}=DataMatrix{1,2}';
DataMatrix{1,3}=Data_Clean(MatrixTransform(investor,v1,v3),v1,v3);
DataMatrix{3,1}=DataMatrix{1,3}';

UnlabelTag=0;

% %%��ƽ�����ݸ��費ͬȨ��ʱ�����÷���������hash��
% cell2mat(Unbalanceweight(cell2mat(Unbalanceweight(:,1))==-1,2))
Unbalanceweight={-1,20;1,1};

clear v1 v2 v3 maxloan maxuser creditinfo investor creditlabel

save 'P2P_all.mat'