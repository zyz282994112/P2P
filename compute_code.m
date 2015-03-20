%负样本对网络进行抽样
%%为何要对borrower和lender抽样？？道理是什么？？知识传播模型里成立是因为要对每种类型的节点都分类，但本数据集中只在乎loan类型啊！
%%而且因为完全随机，很容易发生某笔坏账在loan的抽样中没出现，但在borrower的抽样中出现，从而算法据此很容易判定出loan坏账。尽管增加了正常贷款被误判的可能性。
%%知识传播模型中成立，是因为其有多种类型，不同类型间节点链接较多，但本文中实际只有两个网络，感觉效果不会很好。
ybo=Network_Sample(ybo_all_bad,minsample);
yle=Network_Sample(yle_all_bad,minsample);           
ylo=Network_Sample(ylo_all_bad,minsample);


%正常贷款对网络进行抽样
ybo_n=Network_Sample(ybo_all_normall,minsample);
yle_n=Network_Sample(yle_all_normall,minsample);
ylo_n=Network_Sample(ylo_all_normall,minsample);

ybo=ybo-ybo_n;
yle=yle-yle_n;
ylo=ylo-ylo_n;

disp('开始迭代坏账！');
[flo_bad fle_bad fbo_bad]=Iteration_f(Slobo,Slole,ylo,yle,ybo);


disp('开始迭代正常结束贷款！');
[flo_normall fle_normall fbo_normall]=Iteration_f(Slobo,Slole,-ylo,-yle,-ybo);



