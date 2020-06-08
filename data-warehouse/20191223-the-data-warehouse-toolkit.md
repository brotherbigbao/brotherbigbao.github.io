# 数据仓库工具箱
> 读书笔记

## 第1章

### 度量 p8

可加： 常见
半可加：例如账户节余
不可加：单位价格

### 事实与维度 p9

如果给定产品没有销售活动，则不要在表中插入任何行。

仅将发生的活动放入事实表中，事实表将变得非常稀梳。尽管存在稀梳特性，事实表仍然占据维度模型消耗空间的90%甚至更多。

事实表的粒度可划分为三类：事务、周期性快照、累积快照。事务粒度级别的事实表最常见。

事实表的主键常称为组合键，具有组合键的表称为事实表。

维度表通常有多列，或者说包含多个属性。有50~100个属性的维度表并不稀奇。

维度属性可作为查询约束、分组、报表标识的主要来源。维度表属性在DW/BI系统中起着至关重要的作用。因为维度表的属性是所有查询约束和报表标识的来源。

维度属性对构建DW/BI系统的可用性和可理解性也起着非常重要的作用。属性应该包含真实使用的词汇而不是令人感到迷惑的缩写。
应该尽量减少在维度表中使用代码，应该将代码替换为详细的文本属性。您可能已经训练业务用户，让他们记住操作型的代码，但为了提高效率，应尽量减少他们对
代码转换注释的依赖。应该对那些操作型代码进行解码，以用于维度属性中，这样可以为查询、报表和BI应用提供具备一致性的标识。

有时操作码中包含一些智能含义，例如，操作码头两位数字表示业务类别，3~4位表示全球区域。与其强制用户查询或过滤操作码，不如将隐含的意思拆分，以不同的维度属性
展现给用户，这样用户就能方便地开展过滤、分组和制作报表等工作。

多数情况下，数据仓库的好坏直接取决于维度属性的设置；DW/BI环境的分析能力直接取决于维度属性的质量和深度。

### Kimball的DW/BI架构 展现区 p16

关于展现区，我们第二个主要的建议是必须包含详细的原子数据。
为满足用户无法预期的、随意的查询，必须使用原子数据。尽管在展现区，为提高性能也会存储聚集数据，
但若仅仅有这些汇总数据而没有形成这些汇总数据的细粒度数据，则这样的展现区是不够
完整的。换句话说，在维度模型中仅有汇总数据而查询原子数据时必须访问规范化模型是
完全不能被接受的。期望用户通过下钻维度数据到最细粒度的数据级别是不现实的，并且
采用这样的方式将失去使用维度展现的意义。虽然DW/BI用户和应用对某个订单的单个条
目的查询频度较低，但他们可能对上周产品订单的某种类型(或口味、包装类、供应商)感
兴趣，期望找到那些在半年内首次进行购买活动(或具有某一指定状态或具有一定的信用)
的用户。展现区中一定要包含最细粒度的数据，以便用户能够获得最准确的查询结果。由
于用户需求是不可预知的、不断变化的，因此需要提供各种细节数据，方便用户上卷以解
决实际问题。


必须使用公共的、一致性的维度建立维度结构。

利用总线结构建立分布式DW/BI系统是成功的法定。

处于DW/BI系统的可查询展现区中的数据必须是维度化的、原子（辅以增加性能的聚集）的、以业务过程为中心的。坚持使用总线结构的企业数据仓库，数据不应该按照个别部门需要
的数据来构建。


### 维度建模神话 p22

神话1：维度模型仅包含汇总数据

神话1通常是设计有问题维度模型的根源。由于不可能预测业务用户提出的所有问题，因此必须向业务用户提供对细节数据的查询访问，这样业务用户才能基于其业务问题开展上卷操作。

神话2：维度模型是部门级而不是企业级的

神话3：维度模型是不可扩展的

神话4：维度模型仅用于预测

不应将维度模型设计为仅仅关注预定义的报表或分析。设计应该以度量过程为中心。

神话5：维度模型不能被集成

### 考虑使用维度模型的更多理由

如果没有类似企业数据仓库总线矩阵这样的框架，一些DW/BI开发小组将陷入凭空使用敏捷技术建立分析或报表方案的陷阱中。多数情况下，小组与少量用户合作获取有限数据源，
交将其用于解决其特写的问题。输出往往成为独立的烟筒式数据系统，其他人不能复用。


# 第2章 Kimball维度建模技术概述

### 基本概念 p27

维度模型不应该由那些不懂业务以及业务需求的人来设计，协作是成功的关键。

### 4步骤维度设计过程 p28 ！！

维度模型设计期间主要涉及4个主要的决策：

（1）选择业务过程
（2）声明粒度
（3）确认维度
（4）确认事实

### 粒度 p28

粒度用于确定某一事实表中的行表示什么。

在从给你写的业务过程获取数据时，原子粒度是最低级别的粒度。我们强烈建议从关注原子级别粒度数据开始设计，因为原子粒度数据能够承受无法预期的用户查询。
上卷汇总粒度对性能调整来说非常重要，但这样的粒度往往要猜测业务公共问题。针对不同的事实表粒度，要建立不同的物理表，在同一事实表中不要滥用多种不同的粒度。

### 描述环境的维度 p28

维度表有时被称为数据仓库的“灵魂”，因为维度表包含确保DW/BI系统能够被用作业务分析的入口和描述性标识。

### 用于度量的事实 p29

事实涉及来自业务过程事件的度量，基本上都是以数量值表示。

### 事实表中的空值 p30

事实表中可以存在空值度量。然而，在事实表的外键中不能存在空值，否则会导致违反参照完整性的情况发生。

### 一致性事实 p30 !!

如果某些度量出现在不同的事实表中，需要注意，如果需要比较或计算不同事实表中的事实，应保证针对事实的技术定义是相同的。
如果不同的事实表定义是一致的，则这些一致性事实应该具有相同的命名，如果它们不兼容，则应该有不同的命名用于告诫业务用户和BI应用。

### 事务事实表、周期快照事实表、累积快照事实表 p30

### 聚集事实表或OLAP多维数据库 p31

聚集事实表是对原子粒度事实表数据进行简单的数字化上卷操作，目的是为了提高查询性能。

### 维度表结构 p31

维度表通常比较宽，是扁平型非规范表，包含大量的低粒度的文本属性。操作代码与指示器可作为属性对待，最强有力的维度属性采用冗长的描述填充。


### 维度表中的空值属性 p33

推荐彩描述性字符串替代空值。例如，使用Unknown或Not Applicable替换空值。

### 日历日期维度 p33

主键可以用一个整数表示：YYYYMMDD

### 雪花维度 p34

尽管雪花模式可精确表示层次化的数据，但还是应该避免使用雪花模式，因为对商业用户来说，理解雪花模式并在其中查询是非常困难的。
雪花模式还会影响查询性能。扁平化的、非规范的维度表完全能够获得与雪花模式相同的信息。

### 一致性维度 p34

当不同的维度表的属性具有相同列名和领域内容时，称维度表具有一致性。复用一致性维度属性与每个事实表关联，可将来自不同事实表的信息合并到同一报表中。

### 属性或事实的数字值

设计者有时会遇到一些数字值，难以确定将这些数字值分类到维度表或是事实表的情况。典型的实体是产品的标准价格。如果该数字值主要用于计算目的，
则可能属于事实表。如果该数字值主要用于确定分组或过滤，则应将其定义为维度属性，离散数字值用值范围属性进行补充（例如，$0~50）。某些情况下，
将数字值既建模为维度又建模为属性是非常有益的，例如，定量准时交货度量以及定性文本描述符。


# 第3章 零售业务

### 声明粒度

一旦选择了级别较高的粒度，就限制了建立更细节的维度的可能性。粒度较高的模型无法实现用户下钻细节的需求。
如果用户不能访问原子数据，则不可避免会面临分析障碍。尽管聚集数据对性能调整有很好的效果，但这种效果的获得仍然不能替代允许用户访问最低粒度的细节。
用户可以方便地通过细节数据获得汇总数据，但不能从汇总数据得到细节数据。遗憾的是，一些行业专家对这一问题始终模糊不清。他们认为维度模型仅适合汇总数据，
因此批评维度建模的方法，认为这种方法需要预先考虑业务问题。

DW/BI系统几乎总是要求数据尽可能最细粒度来表示，不是因为需要查询单独的某行，而是因为查询需要以非常精确的方式对细节进行切分。

### 计算获得的事实 p51

总利润额，是通过计算所得，但对所有维度来说，总利润额也是完全可加的。
维度建模者有时感到疑惑，是否应该将计算获得的事实放入数据库中。我们通常推荐将它们物理存储在数据库中。

### 不可加事实 p51

百分比和比率（例如，利润率）是不可加的。应当将其分子分母分别存储在事实表中。

### 日期维度 p53

与多数其他维度不同，可以提前建立日期维度表。
维度模型总是需要详尽的日期维度表。

由于维度表属性用于报表和下拉式查询过滤列表中的值，所以该标识应该用有意义的值，例如，假日或非假如，而不是神秘的Y/N、1/0或真/假表示。

### 产品维度  扁平化多对一层次 p56

对每个SKU,商品层次的所有级别都被定义好。一些属性，例如，SKU描述，具有唯
一性。 在本例中， 在SKU描述列中大约有300 000个不同的值。 从另-一个极端来看，在部
门属性列中仅包含大约50种不同的值。因此，平均来看，部门属性中大约有6000个重复
值。这种情况是完全可以接受的。不需要将这些重复值分解到另--个规范化的表中以节省
空间。记住与针对事实表空间的需求比较来说，维度表空间需求要简单得多。

将重复的低粒度值保存在主维度表中是一种基本的维度建模技术。规范化这些值将其放入不同的表将难以实现简单化与高性能的主要目标。

有时，数字值可同时用于计算以及过滤/分组功能。在此情况下，应当在事实表和维度表中同时存储该值。

上卷 下钻

### 空外键、空属性和空事实 p62

不要在事实表中使用空值键。正确的设计应在对应维度表中包括一行以表明该维度不可用于度量。

包含空值的键是给用户带来困惑的主要原因，因为他们无法实现与空值的连接操作。

当某一给定的维度行未被完全填充时，或者有些属性未被应用到所有维度行时，就会导致出现空值。无论是哪种情况，我们建议用描述性字符串替换那些空值，例如，用Unknown(未知)或Not Applicable（不适用）等。

### 无事实的事实表 p65

前面介绍的零售模式无法解决的一个重要问题是：处理促销状态但尚未销售的产品包括哪些？销售事实表所记录的仅仅是实际卖出的SKU。
事实表行中不包括由于没有销售行为而SKU为零值的行，因为如果将包含零值的SKU都加到事实中，则事实表将变得无比巨大。

### 维度表代理键 p66 ！！

数据仓库中维度表与事实表的每个连接应该基于无实际含义的整数代理键。应该避免使用自然键作为维度表的主键。

1.为数据仓库缓冲操作型系统的变化。
2.集成多个源系统。
3.改进性能。
4.处理空值或未知条件。
5.支持维度属性变化跟踪。

### 事实表的代理键 p69 

尽管我们坚决主张在维度表中使用代理键，但并未要求在事实中一定使用代理键。

事实表中的代理键通常只是对后端ETL处理有帮助。

### 抵制规范化的冲动 p70 ！！

带有重复文本的扁平非规范化维度表使来自操作型世界的数据建模者非常不舒服。

规范化的维度表被称为雪花模式。

雪花模式是维度建模的合法分支，然而，我们建议您抵制采用雪花模式的冲动主要出于设计动机：易用性和性能。

### 包含大量维度的蜈蚣事实表 这样设计是有问题的 p72 ！！

大量的维度通常表明某些维度不是完全独立的，应该合并为一个维度。

将同一层次的元素表示为事实表中不同维度是维度建模常见的错误。

无论处于哪一行业，我们都鼓励在处理维度模型设计时采用4步过程方法。

### 事实表类型：事务、周期快照、累积快照 p81
