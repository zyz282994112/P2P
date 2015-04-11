classdef  GNetMine < ClassifierPackage.Classifier
    properties
        lamada;
        afa;
        solution=2;   
        Unbalanceweight;
    end
    
    methods(Static,Access=private)
        [Sij] = ComputeSij(Rij);
        f=ClosedSolution(S,y,lamada,afa);
        f=IterationSolution(S,y,lamada,afa);
    end
    
    methods
        function obj = GNetMine(ClassifyName)
            obj=obj@ClassifierPackage.Classifier(ClassifyName);
        end
        
        function [PredictionLabel,score]=Run(obj,dataobj,TrainTag,TestTag)
            m=dataobj.TargetDataSet;
            %%m��ʾҪ�Ե�m��ڵ�������ΪĿ��ڵ���з���
            num=length(TrainTag);
            S=cell(num,num);
            % labellength=cellfun('length',DataLabel);
            for i=1:num
                for j=1:num
                    S{i,j}=obj.ComputeSij(dataobj.DataMatrix{i,j});
                    %%��ʽ����Ҫ��Sij����0ֵ
                    if isempty(S{i,j})
                        S{i,j}=sparse(zeros(length(dataobj.DataLabel{i}),1))*sparse(zeros(length(dataobj.DataLabel{j}),1))';
                    end
                end
            end
            inputLabel=cell(num,1);%%ȥ�������һ����ʱ��
            y=cell(num,1);
            classlabel=unique(dataobj.DataLabel{m}(dataobj.DataLabel{m}~=dataobj.UnlabelTag));
            for i=1:num
                inputLabel{i}=zeros(size(dataobj.DataLabel{i}));
                inputLabel{i}(TrainTag{i}==1)=dataobj.DataLabel{i}(TrainTag{i}==1);
                y{i}=zeros(length(inputLabel{i}),length(classlabel));
                for j=1:length(classlabel)
                    if isempty(obj.Unbalanceweight)
                        y{i}(inputLabel{i}==classlabel(j),j)=1;
                    else
                        y{i}(inputLabel{i}==classlabel(j),j)=cell2mat(obj.Unbalanceweight(cell2mat(obj.Unbalanceweight(:,1))==classlabel(j),2));
                    end
                end
            end
            if isempty(obj.lamada)
                obj.lamada=0.1*ones(length(dataobj.DataLabel));
            end
            if isempty(obj.afa)
                obj.afa=0.1*ones(length(dataobj.DataLabel),1);
            end
            if obj.solution==1
                f=obj.ClosedSolution(S,y,obj.lamada,obj.afa);
            else
                f=obj.IterationSolution(S,y,obj.lamada,obj.afa);%%�����ʽ������ͬ
            end
            
            [~,PredictionLabel]=max(f{m}');
            PredictionLabel=classlabel(PredictionLabel');
            PredictionLabel(all(f{m}'==0)')=dataobj.UnlabelTag;
            PredictionLabel=PredictionLabel(TestTag{m}==1);
            
            if strcmp(num2str(classlabel(1)),dataobj.ComputeLabel)
%                 score=f{m}(TestTag{m}==1,1);
                score=f{m}(TestTag{m}==1,1)-f{m}(TestTag{m}==1,2);%%ʹ�ò���ȼ���
            else
%                 score=f{m}(TestTag{m}==1,2);
                score=f{m}(TestTag{m}==1,2)-f{m}(TestTag{m}==1,1);%%ʹ�ò���ȼ���
            end
        end
        
    end
    
end