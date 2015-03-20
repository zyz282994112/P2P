%��Ҫ����matlab��������
num=4;%%��ʾ�м������͵Ľڵ�
classlabel=[1 2 3 4];%%��ʾ����label  %%1:paper 2:author 3:conf 4:term 0:δ֪
load('DBLP.mat');

DataLabel=cell(num,1);%%�洢�ڵ�label
DataFeature=cell(num,1);%%�洢�ڵ�feature��dblp���ݼ���feature
DataMatrix=cell(num,num);%%ÿ��Ԫ��DataMatrix{i,j}�洢����Ϊi�Ľڵ�������Ϊj�Ľڵ��0-1���Ӿ���
MaxDataNum=[654269,472635,4096,13571];

DataCleanScriptdblp;%%������תΪ������or�������󣩴���DataLabel��DataMatrix�У�ͬʱȥ�����й�����

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
chouyangbili=[0.005,0.005,0,0];%%��ͬ���ͽڵ�ĳ�������
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

% f=Iteration_dblp(S,y,lamada,afa);%%�����ʽ����ͬ
 
%%���·���Ϊ��ʽ��
%%��ʽ����Ҫ��Sij����0ֵ
for i=1:num
    for j=1:num
        if isempty(S{i,j})
            S{i,j}=sparse(zeros(length(DataLabel{i}),1))*sparse(zeros(length(DataLabel{j}),1))';
        end
    end
end
f=ClosedSolution(S,y,lamada,afa);

target=2;%%��ʾҪ����Ľڵ�
[a,PredictionLabel]=max(f{target}'); %#ok<UDIM>
PredictionLabel(all(f{target}'==0))=0;
PredictionLabel=PredictionLabel';

%%����ԭ��label(k����ͬlabel��nά0-1����ת����nά����)
tmp1=DataLabel{target}(testtag{target}==1);
tmp2=PredictionLabel(testtag{target}==1);
tmp2(tmp1==0)=[];
tmp1(tmp1==0)=[];

%%����׼ȷ��
cp = classperf(cellstr(num2str(tmp1)));
classperf(cp,cellstr(num2str(tmp2)));
cp.CorrectRate
% for i=1:length(cp.ClassLabels)
%     [x, y, t, auc]=perfcurve(DataLabel{target}(testtag{target}==1),PredictionLabel(testtag{target}==1),cp.ClassLabels{i});
%     auc
% end