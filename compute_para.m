%%计算各种参数

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
confusion_matrix=[huaihuai-sum(ylo==1) sum(ylo_all_bad)-huaihuai;huaihao sum(ylo_all_normall)-huaihao-sum(ylo==-1)];


%%计算准确率，召回率
% precision_bad=huaihuai/(huaihuai+huaihao);
precision_bad=(huaihuai-sum(ylo==1))/(huaihuai+huaihao-sum(ylo==1));%%去除原本就有标记的部分，因为这部分100%正确！
recall_bad=(huaihuai-sum(ylo==1))/(sum(ylo_all_bad)-sum(ylo==1));%%去除原本就有标记的部分，因为这部分100%正确！
precision_normall=(sum(ylo_all_normall)-huaihao-sum(ylo==-1))/(sum(ylo_all_bad)+sum(ylo_all_normall)-sum(clo)-sum(ylo==-1));
recall_normall=(sum(ylo_all_normall)-huaihao-sum(ylo==-1))/(sum(ylo_all_normall)-sum(ylo==-1));
tmp=sprintf('坏账准确率：%g;坏账召回率：%g。',precision_bad,recall_bad);
disp(tmp);
tmp=sprintf('正常准确率：%g;正常召回率：%g。',precision_normall,recall_normall);
disp(tmp);


%计算AUC
ylo_all_bad_tmp=ylo_all_bad;
ylo_all_normall_tmp=ylo_all_normall;
ylo_all_bad_tmp(~ylo==0,:)=[];%%去除原本就有标记的部分，因为这部分100%正确！
ylo_all_normall_tmp(~ylo==0,:)=[];%%去除原本就有标记的部分，因为这部分100%正确！
clo(~ylo==0,:)=[];%%去除原本就有标记的部分，因为这部分100%正确！

[result M N]=AUC_train_only(ylo_all_bad_tmp,clo,ylo_all_bad_tmp+ylo_all_normall_tmp,confusion_matrix);
tmp=sprintf('坏账AUC：%g。',result);
disp(tmp);