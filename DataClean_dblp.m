%%������תΪ������or�������󣩴���DataLabel��DataMatrix�У�ͬʱȥ�����й�����
clear
load('DBLProw.mat');

num=4;
DataLabel=cell(num,1);%%�洢�ڵ�label
DataFeature=cell(num,1);%%�洢�ڵ�feature��dblp���ݼ���feature
DataMatrix=cell(num,num);%%ÿ��Ԫ��DataMatrix{i,j}�洢����Ϊi�Ľڵ�������Ϊj�Ľڵ��0-1���Ӿ���
MaxDataNum=[654269,472635,4096,13571];

v1=double(VectorTransform(paperauthor(:,1),MaxDataNum(1))|VectorTransform(paperconf(:,1),MaxDataNum(1))|VectorTransform(paperterm(:,1),MaxDataNum(1)));
DataLabel{1}=zeros(length(v1),1);
DataLabel{1}(paperlabel(:,1))=paperlabel(:,2)+1;
DataLabel{1}(v1==0)=[];
v2=VectorTransform(paperauthor(:,2),MaxDataNum(2));
DataLabel{2}=zeros(length(v2),1);
DataLabel{2}(authorlabel(:,1))=authorlabel(:,2)+1;
DataLabel{2}(v2==0)=[];
% DataLabel{2}(DataLabel{2}==0)= round(rand(sum(DataLabel{2}==0),1)*3+1);%%��δ��ǵ������Ϊ1~4��ĳ�����
v3=VectorTransform(paperconf(:,2),MaxDataNum(3));
DataLabel{3}=zeros(length(v3),1);
DataLabel{3}(conflabel(:,1))=conflabel(:,2)+1;
DataLabel{3}(v3==0)=[];
v4=VectorTransform(paperterm(:,2),MaxDataNum(4));%%termû�б�ǩ
DataLabel{4}=zeros(length(v4),1);
DataLabel{4}(v4==0)=[];

DataMatrix{1,2}=Data_Clean(MatrixTransform(paperauthor,v1,v2),v1,v2);
DataMatrix{1,3}=Data_Clean(MatrixTransform(paperconf,v1,v3),v1,v3);
DataMatrix{1,4}=Data_Clean(MatrixTransform(paperterm,v1,v4),v1,v4);
DataMatrix{2,1}=DataMatrix{1,2}';
DataMatrix{3,1}=DataMatrix{1,3}';
DataMatrix{4,1}=DataMatrix{1,4}';
UnlabelTag=0;

clear v1 v2 v3 v4 paperauthor paperconf paperterm authorlabel paperlabel conflabel term num MaxDataNum

save 'dblp'
