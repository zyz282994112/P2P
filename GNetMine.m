classdef  GNetMine < Classifier
    properties  %%���������
        classlabel;
        lamada;
        afa;
    end
    
    methods   %�����෽��
        function obj = GNetMine(DataLabel,DataFeature,DataMatrix,classlabel,lamada,afa)
            obj=obj@Classifier(DataLabel,DataFeature,DataMatrix);
            obj.classlabel=classlabel;
            obj.lamada=lamada;
            obj.afa=afa;
        end
        
        function Run(obj,traintag,testtag,m)
            %%m��ʾҪ�Ե�m��ڵ�������ΪĿ��ڵ���з���
            num=length(traintag);
            S=cell(num,num);
            for i=1:num
                for j=1:num
                    S{i,j}=ComputeSij(obj.DataMatrix{i,j});
                    %%��ʽ����Ҫ��Sij����0ֵ
                    if isempty(S{i,j})
                        S{i,j}=sparse(zeros(length(obj.DataLabel{i}),1))*sparse(zeros(length(obj.DataLabel{j}),1))';
                    end
                end
            end
            inputLabel=cell(num,1);
            y=cell(num,1);
            for i=1:num
                inputLabel{i}=zeros(size(obj.DataLabel{i}));
                inputLabel{i}(traintag{i}==1)=obj.DataLabel{i}(traintag{i}==1);
                y{i}=zeros(length(inputLabel{i}),length(obj.classlabel));
                for j=1:length(obj.classlabel)
                    y{i}(inputLabel{i}==obj.classlabel(j),j)=1;
                end
            end
            f=ClosedSolution(S,y,obj.lamada,obj.afa);
%             f=IterationSolution(S,y,obj.lamada,obj.afa);%%�����ʽ����ͬ
            [~,PredictionLabel]=max(f{m}'); %#ok<UDIM>
            PredictionLabel(all(f{m}'==0))=0;
            obj.PredictionLabel=PredictionLabel(testtag{m}==1)';        
        end
        
    end
    
end