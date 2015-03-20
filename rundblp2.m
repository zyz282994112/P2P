%需要先用matlab导入数据
num=4;%%表示有几种类型的节点
load('DBLP.mat');

DataLabel=cell(4,1);
DataFeature=cell(4,1);
DataMatrix=cell(4,4);
MaxDataNum=[654269,472635,4096,13571];

%%1:paper 2:author 3:conf 4:term
v1=double(VectorTransform(paperauthor(:,1),MaxDataNum(1))|VectorTransform(paperconf(:,1),MaxDataNum(1))|VectorTransform(paperterm(:,1),MaxDataNum(1)));%%此处考虑简化
DataLabel{1}=zeros(length(v1),1);
DataLabel{1}(paperlabel(:,1))=paperlabel(:,2)+1;
DataLabel{1}(v1==0)=[];
v2=VectorTransform(paperauthor(:,2),MaxDataNum(2));
DataLabel{2}=zeros(length(v2),1);
DataLabel{2}(authorlabel(:,1))=authorlabel(:,2)+1;
DataLabel{2}(v2==0)=[];
v3=VectorTransform(paperconf(:,2),MaxDataNum(3));
DataLabel{3}=zeros(length(v3),1);
DataLabel{3}(conflabel(:,1))=conflabel(:,2)+1;
DataLabel{3}(v3==0)=[];
v4=VectorTransform(paperterm(:,2),MaxDataNum(4));%%term没有标签
DataLabel{4}=zeros(length(v4),1);
DataLabel{4}(v4==0)=[];

DataMatrix{1,2}=Data_Clean(MatrixTransform(paperauthor,v1,v2),v1,v2);
DataMatrix{1,3}=Data_Clean(MatrixTransform(paperconf,v1,v3),v1,v3);
DataMatrix{1,4}=Data_Clean(MatrixTransform(paperterm,v1,v4),v1,v4);

S=cell(4,4);
for i=1:num
    for j=1:num
        S{i,j}=ComputeSij(DataMatrix{i,j});
    end
end

inputLabel=cell(4,1);
traintag=cell(4,1);
testtag=cell(4,1);
y=cell(4,1);
key=cell(4,1);
chouyangbili=[0.5,0.5,0.5,0.5];
for i=1:4
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
    y{i}=zeros(length(inputLabel{i}),4);
    for j=1:4
        y{i}(inputLabel{i}==j,j)=1;
    end
end

lamada=ones(4,4)*0.2;
afa=ones(4,1)*0.1;

% f=Iteration_dblp(S,y,lamada,afa);%%答案与闭式解相同

%%以下方法为闭式解
%%闭式解才需要给Sij赋予0值
for i=1:num
    for j=1:num
        if isempty(S{i,j})
            S{i,j}=sparse(zeros(length(DataLabel{i}),1))*sparse(zeros(length(DataLabel{j}),1))';
        end
    end
end
% f=ClosedSolution(S,y,lamada,afa);

I1=sparse(diag(ones(length(DataLabel{1}),1)));
I2=sparse(diag(ones(length(DataLabel{2}),1)));
I3=sparse(diag(ones(length(DataLabel{3}),1)));
I4=sparse(diag(ones(length(DataLabel{4}),1)));
A=[-(sum(lamada(1,:))-lamada(1,1)+afa(1))*I1,lamada(1,2)*S{1,2},lamada(1,3)*S{1,3},lamada(1,4)*S{1,4};
    lamada(2,1)*S{2,1},-(sum(lamada(2,:))-lamada(2,2)+afa(2))*I2,lamada(2,3)*S{2,3},lamada(2,4)*S{2,4};
    lamada(3,1)*S{3,1},lamada(3,2)*S{3,2},-(sum(lamada(3,:))-lamada(3,3)+afa(3))*I3,lamada(3,4)*S{3,4};
    lamada(4,1)*S{4,1},lamada(4,2)*S{4,2},lamada(4,3)*S{4,3},-(sum(lamada(4,:))-lamada(4,4)+afa(4))*I4];
B=[-afa(1)*y{1};-afa(2)*y{2};-afa(3)*y{3};-afa(4)*y{4}];
ff=A\B;
f=y;
count=0;
for i=1:4
    f{i}=ff((count+1):(count+length(y{i})),:);
    count=count+length(y{i});
end



target=2;%%表示目标节点

[a,PredictionLabel]=max(f{target}'); %#ok<UDIM>
PredictionLabel(all(f{target}'==0))=0;
PredictionLabel=PredictionLabel';

% cp = classperf(cellstr(num2str(DataLabel{target}(testtag{target}==1))));
% classperf(cp,cellstr(num2str(PredictionLabel(testtag{target}==1))));

tmp1=DataLabel{target}(testtag{target}==1);
tmp2=PredictionLabel(testtag{target}==1);
tmp2(tmp1==0)=[];
tmp1(tmp1==0)=[];

cp = classperf(cellstr(num2str(tmp1)));
classperf(cp,cellstr(num2str(tmp2)));


% for i=1:length(cp.ClassLabels)
%     [x, y, t, auc]=perfcurve(DataLabel{target}(testtag{target}==1),PredictionLabel(testtag{target}==1),cp.ClassLabels{i});
%     auc
% end
cp.CorrectRate






