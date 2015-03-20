maxuser=1314468;
maxloan=401762;
minquan=0.00001;  %设置laplace权重，使得计算的对角阵非奇异矩阵
minsample=0.9; %网络节点抽样比例


V_lo=VectorTransform(R_loan_borrower(:,1),maxloan)|VectorTransform(R_loan_lender(:,1),maxloan);
V_bo=VectorTransform(R_loan_borrower(:,2),maxuser);
V_le=VectorTransform(R_loan_lender(:,2),maxuser);

ybo_all_bad=VectorTransform(inputborrower_bad,maxuser);
ybo_all_bad=Data_Clean(ybo_all_bad,V_bo);
yle_all_bad=VectorTransform(inputlender_bad,maxuser);
yle_all_bad=Data_Clean(yle_all_bad,V_le);
ylo_all_bad=VectorTransform(inputloan_bad,maxloan);
ylo_all_bad=Data_Clean(ylo_all_bad,V_lo);
ybo_all_normall=VectorTransform(inputborrower_normall,maxuser);
ybo_all_normall=Data_Clean(ybo_all_normall,V_bo)*2;
yle_all_normall=VectorTransform(inputlender_normall,maxuser);
yle_all_normall=Data_Clean(yle_all_normall,V_le)*2;
ylo_all_normall=VectorTransform(inputloan_normall,maxloan);
ylo_all_normall=Data_Clean(ylo_all_normall,V_lo)*2;

Rlobo=Data_Clean(MatrixTransform(R_loan_borrower,V_lo,V_bo),V_lo,V_bo);
Rlole=Data_Clean(MatrixTransform(R_loan_lender,V_lo,V_le),V_lo,V_le);


DataLabel=cell(3,1);
DataFeature=cell(3,1);
DataMatrix=cell(3,3);
DataLabel{1}=ylo_all_bad+ylo_all_normall;
DataLabel{2}=zeros(size(yle_all_bad));
DataLabel{3}=zeros(size(ybo_all_bad));
% DataLabel{2}=yle_all_bad+yle_all_normall;
% DataLabel{3}=ybo_all_bad+ybo_all_normall;
DataMatrix{1,2}=Rlole;
DataMatrix{1,3}=Rlobo;

