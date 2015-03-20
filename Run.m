%需要先用matlab导入数据
load('导入网络文件.mat');

maxuser=1314468;
maxloan=401762;
minquan=0.00001;  %设置laplace权重，使得计算的对角阵非奇异矩阵
minsample=0.2; %网络节点抽样比例



%%计算Sij
[Slobo Slole] = Compute_Sij(R_loan_borrower,R_loan_lender,maxloan,maxuser,minquan);

compute_code_bad;
compute_code_normall;


%%计算混淆矩阵[真坏预坏 真坏预正;真正预坏 真正预正]
huaihuai=0;
huaihao=0;
clo=zeros(size(flo_bad,1),1);
for i=1:size(flo_bad,1)
    if (flo_bad(i)>flo_normall(i) || flo_bad(i)==Inf)
        if ylo_all_bad(i)==1
            huaihuai=huaihuai+1;
        else
            huaihao=huaihao+1;
        end
        clo(i)=1;
    end
end
confusion_matrix=[huaihuai sum(ylo_all_bad)-huaihuai;huaihao sum(ylo_all_normall)-huaihao];


%%计算准确率，召回率
precision_bad=huaihuai/(huaihuai+huaihao);
recall_bad=huaihuai/sum(ylo_all_bad);
precision_normall=(sum(ylo_all_normall)-huaihao)/(sum(ylo_all_bad)+sum(ylo_all_normall)-sum(clo));
recall_normall=(sum(ylo_all_normall)-huaihao)/sum(ylo_all_normall);
tmp=sprintf('坏账准确率：%g;坏账召回率：%g。',precision_bad,recall_bad);
disp(tmp);
tmp=sprintf('正常准确率：%g;正常召回率：%g。',precision_normall,recall_normall);
disp(tmp);


%计算AUC
[result M N]=AUC_train_only(ylo_all_bad,clo,ylo_all_bad+ylo_all_normall,confusion_matrix);
tmp=sprintf('坏账AUC：%g。',result);
disp(tmp);