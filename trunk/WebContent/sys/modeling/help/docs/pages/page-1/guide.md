## 第一步	业务梳理、模型搭建
低代码平台是灵活易用的应用搭建模块，包含自定义流程表单或自定义无流程表单、自定义移动首页和图表、自定义消息提醒等等。无需代码，可快速、灵活地构建业务管理系统，满足企业个性化低代码平台管理需求。</br>
在低代码平台中，我们可以创建多个应用来管理不同类型的项目。但在创建应用之前，我们首先需要确定好应用本身的业务需求，通过业务需求来搭建应用模型。</br>
我们需要明确要做什么，谁用，想怎么用；考虑应用的关系展示内容；梳理清楚应用需要的各个元素。同时，对于搭建应用，我们需要明确需要搭建的表单；清楚表单需要的字段和表单之间的业务关系；</br>
>例如，我们想要搭建一个企业会议管理应用，且搭建该应用的目的是记录会议内容，统计参会人员情况。那我们至少应该搭建会议记录表单和企业人员表单，并且明确会议记录表单中应该至少包括会议名称、时间、地点、参加人员、会议内容等字段，并且清楚两个表单通过参加人员相互关联，在填写会议记录时可以从企业人员表单中选择参会人员。</br>

## 第二步	创建应用
通过“首页-低代码平台”，进入应用管理页面。你可以直接导入应用使用，或者自行创建一个新应用。点击【创建新应用】，进入新建应用页面。填写应用名称（必填）、应用描述，选择应用分类和应用图标后即可创建应用。</br>

![](../../img/page1/guide/guide-1.png)
![](../../img/page1/guide/guide-2.png)



## 第三步	配置表单
表单按使用类型的不同分为流程表单和无流程表单。</br>
流程表单，是审批流程加上表单，它既具备表单填写、修改数据的功能，也具备审批流程。数据在流程流转的过程中填写、修改，在流程结束后数据定型、归档。</br>
无流程表单，它仅用于存储各种管理数据，只具备表单填写、修改数据的功能。</br>
表单创建方式也有两种，一种是直接导入表单使用；一种是创建空白表单，根据需求自定义添加字段；</br>
将鼠标滑动到某一具体应用上，点击【编辑】，进入该应用的业务表单页面。</br>

![](../../img/page1/guide/guide-3.png)
点击【创建无流程表单】或者【创建流程表单】开始新建表单页面</br>
根据业务需求，在表单设计页面，往表格中添加相应控件，完成表单设计。表单字段主要在PC端配置，表单移动端可进行字段删除，移动端表单配置完成可预览。</br>

![](../../img/page1/guide/guide-4.png)


## 第四步	流程设计 
当表单需要多方参与、按一定顺序提交数据时，就要用到“流程”。那么在表单配置时就选择“流程表单”来创建。</br>
管理员提前设置好流程的节点，审批人和数据流转的路径。一旦数据提交后，就会进入流程，按照流程的设定进行流转</br>

![](../../img/page1/guide/guide-5.png)

## 第五步	视图设计 
当我们配置好表单以后，如何将信息展现给前台使用的用户，就需要进行视图设计。

### 1 查看视图设计
首先是查看视图设计，即点击某一具体信息时向用户展示的详情页面。采用所见即所得的方式，业务需求字段快速配置完成，可高效预留列表展示效果。</br>
查看视图设计页面分为预览区和配置区。</br>
左侧预览区完全模拟线上前台展示页面，当在右侧配置区进行配置时，预览区相应配置区域亮起，提示用户当前在配置什么，并且展示内容随右侧配置区同步改变。同理，当选择左侧预览区某一块配置区域时，会实时定位到右侧配置区具体配置内容。</br>
左侧预览区仅作预览、提示、定位使用，不可直接更改配置内容，一切具体配置操作都在右侧配置区完成。</br>

![](../../img/page1/guide/guide-6.png)

### 2 列表视图设计
查看视图配置完成后，接着配置列表视图。列表视图，即前台页面列表展现样式配置，</br>
与查看视图配置相同，也采用所见即所得的方式，左侧为预览区，右侧为配置区。</br>
![](../../img/page1/guide/guide-7.png)

## 第六步	关系设置
当我们创建好表单，配置好流程和视图，做好准备工作以后，如何让表单之间形成联系，如何将表单用起来，就需要进行关系设置。
### 1 业务关系
点击【业务关系-关系设置】，进入关系设置页面。</br>
从右侧关联模板库中拖拽其他表单到左侧关联显示区，即可创建两者之间的业务关系连接，新增两个表单之间的联动关系，实现不同表单之间的数据读取。</br>

![](../../img/page1/guide/guide-8.png)

点击相应表单，进入该表单与主表单关系设置页面，可以新增被选择表单与主表单的业务联动。</br>

![](../../img/page1/guide/guide-9.png)

在新建业务联动时，需要填写基本信息、配置关系、数据源三个板块的信息。包括新建业务联动的名称、类型；两个表单之间的关联字段，返回值，传出参数；数据源数据信息的查询条件、筛选条件、显示列等信息。</br>

![](../../img/page1/guide/guide-10.png)

当我们配置完成后，在前台编辑当前表单时，就能通过业务关联选到另一张表单的信息了。</br>

![](../../img/page1/guide/guide-11.png)

>如上面几张图显示，我们想在填写会议记录时可以从企业人员表单中选择参会人员，就应该拖动企业人员表单至会议记录表单的关联展示区，与之形成关联，新建两个表单之间的业务联动。</br>
因此我们在新建业务联动时，选择关联字段为参会人员，选择返回值为姓名，传出参数对应关系为会议记录表单里的参会人员字段与企业人员表单里的姓名字段对应。</br>
在没有其他约束条件时，我们仅在下面数据源信息配置区域，配置显示列为姓名、出生年月、联系方式、微信号、地址。所以在线上前台选择企业参会人员时，显示该人员的姓名、出生年月、联系方式、微信号、地址信息。</br>

### 2 业务触发
业务触发，触发包括触发动作和触发场景。触发场景为多个触发动作的合集。</br>
业务触发用于设置不同表单之间的数据写入、流程新建和消息推送等。</br>
点击【业务关系-业务触发】，进入业务触发页面。</br>

![](../../img/page1/guide/guide-12.png)

新建触发动作：</br>
在触发动作页面，点击【新建】，进入新建触发动作页面。</br>
先填写基本信息，填写触发名称、选择动作类型和目标表单。再根据所选动作类型填写该类型所需的触发信息。下图为选择触发类型为消息时的场景。</br>

![](../../img/page1/guide/guide-13.png)

新建触发场景：</br>
在触发场景页面，点击【新建】，进入新建触发场景页面。根据用户所选触发类型配置触发场景后续所需信息。触发场景为触发动作的合集，新建触发场景时可在已有的触发动作中选择构成该触发场景的动作。</br>
下图为选择定时触发类型时的场景。</br>

![](../../img/page1/guide/guide-14.png)

### 3 业务操作
业务操作，即对业务的编辑、删除、新建、查看、保存等各种操作按钮进行配置。</br>
根据操作类型，可将业务操作分为内置操作和拓展操作两类，其中拓展操作又可分为有操作视图和无操作视图两类。内置操作即系统自带操作，拓展操作即用户根据业务需求自主配置的操作。</br>
通过【业务关系-业务操作】，进入业务操作页面。点击【新建】，开始新建业务操作。</br>

![](../../img/page1/guide/guide-15.png)

操作说明：</br>
【名称】所建业务操作的名称。</br>
【描述】对所建业务操作的说明，可包括该业务操作的使用场景、目的、功能等等。</br>
【操作位置】所建业务操作所出现的地点，可选择列表视图或者查看视图。</br>
【操作类型】所建业务操作所属类别，可选择拓展操作（有操作视图）或者拓展操作（无操作视图）。</br>
【业务触发】选择点击执行所建业务操作时执行的触发，可选择触发场景或者触发动作。</br>

## 第七步	图表设置
我们创建应用的目的是为了高效管理，那么我们收集上来的数据仅用列表展示，是否不太直观呢？</br>
因此我们可以通过图表设置，将收集上来的数进行统计图表分析，将数据更加高效直观地展示给使用者或其他人。</br>
点击【图表设置】，进入图表设置页面，可配置统计图表、统计列表、统计图标集三种类型。</br>

![](../../img/page1/guide/guide-16.png)

## 第八步	业务导航设置
前面我们已经配置好了表单、视图、关系，那如何让用户在前台线上页面看到我们配置的东西呢，就需要把我们想要展示的表单添加到业务导航下，展示出整个应用视图。</br>
先选择右侧想要添加的层级名称，再点击左侧想要添加的页面，选择完成后，点击加入右侧，即可把页面添加到想添加的层级下。同理点击加入左侧也可把已经添加到右侧层级下的页面撤回来。</br>

![](../../img/page1/guide/guide-17.png)

配置好的业务导航，在前端PC端左侧展现效果</br>

![](../../img/page1/guide/guide-18.png)

## 第九步	移动端设置

### 1 表单移动端设置

表单字段主要在PC端配置，表单移动端可进行字段删除，移动端表单配置完成可预览。</br>

![](../../img/page1/guide/guide-19.png)

### 2 视图移动端设置

移动端视图设计，可结合业务需要筛选移动端列表视图展现样式。</br>

![](../../img/page1/guide/guide-20.png)

### 3 移动端首页设置
选择模板，筛选需要展示的列表视图，配置完成后可进行移动端首页预览，直接查看效果。</br>

![](../../img/page1/guide/guide-21.png)

![](../../img/page1/guide/guide-22.png)

## 第十步	门户portlet设置
portlet视图设计，即系统门户配置，可快速高效选择门户展现样式，完成门户视图展示。</br>
完成门户portlet视图设计后，用户就可从门户首页快速选择到当前应用版块了。</br>
通过“视图设置-portlet视图”，点击【新建】，进入新建portlet视图页面。根据选择的展现方式的不同需要配置不同的信息。</br>

![](../../img/page1/guide/guide-23.png)

点击【展现方式】，进入展现方式选择页面，可选择简单列表展现方式、图文摘要展现方式、幻灯片展现方式、列表视图展现方式四种。如下图所示。</br>

![](../../img/page1/guide/guide-24.png)









