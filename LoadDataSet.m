classdef LoadDataSet
    %%载入实验用的数据集，以矩阵形式存储。
    %%包括：分类节点的基本feature、分类节点间的链接及分类节点与其他类型节点的链接、其他类型节点的feature三种类型。（三种并非都存在，不同分类算法需求不同）
    %%后期考虑增加向特定文件里增删改某个数据集，添加数据集，删除数据集等基本操作
    %%后期考虑增加允许载入csv,数据库，txt等不同类型的数据集。
    properties  %%定义类变量
       
    end
    
    
    properties(Constant)%定义类常量
        
    end
    
    
    methods   %定义类方法
       function obj=LoadDataSet(filename)
           %%载入以filename命名的数据文件（该文件包含我们需要的所有数据集,存储在matlab命名空间中）
           load(filename);
       end
       
       
       
       
    end
    
    
    
    
end
    