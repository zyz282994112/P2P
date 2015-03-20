[heart_scale_label, heart_scale_inst] = libsvmread('heart_scale');
% load fisheriris
indices = crossvalind('Kfold',heart_scale_label,10);
cp = classperf(cellstr(num2str(heart_scale_label)));
% cp=classperf(heart_scale_label);
prediction=zeros(size(heart_scale_label));


for i = 1:10
    test = (indices == i); train = ~test;
    AAA=SVM({},{},{});
    AAA.Run(heart_scale_label(train,:),heart_scale_inst(train,:),heart_scale_label(test,:), heart_scale_inst(test,:));
    %     model = svmtrain(heart_scale_label(train,:), heart_scale_inst(train,:), '-c 1 -g 0.07');
    %     predict_label = svmpredict(heart_scale_label(test,:), heart_scale_inst(test,:), model);
    classperf(cp,cellstr(num2str(AAA.PredictionLabel)),test);
%     classperf(cp,AAA.PredictionLabel,test);
    prediction(indices==i,:)=AAA.PredictionLabel;
end
cp.ErrorRate
[x y t auc]=perfcurve(heart_scale_label,prediction,cp.ClassLabels{1});
auc