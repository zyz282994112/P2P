classdef  GNetMine < ClassifierPackage.Classifier
    properties
        lamada;
        afa;
        solution=2;
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
        
        function PredictionLabel=Run(obj,dataobj,TrainTag,TestTag)
            m=dataobj.TargetDataSet;
            %%m表示要对第m类节点类型作为目标节点进行分类
            num=length(TrainTag);
            S=cell(num,num);
            % labellength=cellfun('length',DataLabel);
            for i=1:num
                for j=1:num
                    S{i,j}=obj.ComputeSij(dataobj.DataMatrix{i,j});
                    %%闭式解需要给Sij赋予0值
                    if isempty(S{i,j})
                        S{i,j}=sparse(zeros(length(dataobj.DataLabel{i}),1))*sparse(zeros(length(dataobj.DataLabel{j}),1))';
                    end
                end
            end
            inputLabel=cell(num,1);
            y=cell(num,1);
            classlabel=unique(dataobj.DataLabel{m}(dataobj.DataLabel{m}~=dataobj.UnlabelTag));
            for i=1:num
                inputLabel{i}=zeros(size(dataobj.DataLabel{i}));
                inputLabel{i}(TrainTag{i}==1)=dataobj.DataLabel{i}(TrainTag{i}==1);
                y{i}=zeros(length(inputLabel{i}),length(classlabel));
                for j=1:length(classlabel)
                    if isempty(dataobj.Unbalanceweight)
                        y{i}(inputLabel{i}==classlabel(j),j)=1;
                    else
                        y{i}(inputLabel{i}==classlabel(j),j)=cell2mat(dataobj.Unbalanceweight(cell2mat(dataobj.Unbalanceweight(:,1))==classlabel(j),2));
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
                f=obj.IterationSolution(S,y,obj.lamada,obj.afa);%%答案与闭式解结果相同
            end
            PredictionLabel=zeros(length(dataobj.DataLabel{m}),1);
            for i=1:length(PredictionLabel)
                if all(f{m}(i,:)'==0)
                    PredictionLabel(i)=dataobj.UnlabelTag;
                else
                    [~,tag]=max(f{m}(i,:));
                    PredictionLabel(i)=classlabel(tag);
                end
            end
            PredictionLabel=PredictionLabel(TestTag{m}==1);
        end
        
    end
    
end