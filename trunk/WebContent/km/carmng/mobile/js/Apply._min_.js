require({cache:{"km/carmng/mobile/km_carmng_apply/js/header/IndexListNavMixin":function(){define(["dojo/_base/declare","dojo/store/Memory","mui/i18n/_i18n!km/carmng/mobile/js/Apply","mui/i18n/_i18n!km/carmng/mobile/js/Apply","mui/i18n/_i18n!km/carmng/mobile/js/Apply"],function(d,e,c,b,a){return d("km.Carmng.mobile.applyCarmng.indexListNavMixin",null,{store:new e({data:[{url:"/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=list&q.mydoc=create&orderby=docCreateTime&ordertype=down",text:c["kmCarmng.tree.my.submit"],isNavCount:true},{url:"/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=list&q.mydoc=approval&orderby=docCreateTime&ordertype=down",text:b["kmCarmng.tree.my.approval"],isNavCount:true},{url:"/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=list&q.mydoc=approved&orderby=docCreateTime&ordertype=down",text:a["kmCarmng.tree.my.approved"],isNavCount:true}]})})})},"km/carmng/mobile/js/list/item/CarApplyItemMixin":function(){define(["dojo/_base/declare","dojo/dom-construct","dojo/dom-class","dojo/dom-style","dojo/dom-attr","dojox/mobile/_ItemBase","mui/util","sys/mobile/js/mui/openProxyMixin","mui/i18n/_i18n!km/carmng/mobile/js/Apply"],function(b,a,h,e,g,i,d,c,f){var j=b("km.carmng.list.item.CarApplyItemMixin",[i,c],{tag:"li",baseClass:"muiProcessItem muiListItemCard",buildRendering:function(){this.inherited(arguments);this.contentNode=a.create(this.tag,{className:"carApplyItem  muiListItem"});this.buildInternalRender();a.place(this.contentNode,this.containerNode)},buildInternalRender:function(){var q=this.href?{}:{className:"lock"};this.contentNode=a.create("div",q);var p=a.create("div",{className:"muiListItemTop"},this.contentNode);var n=a.create("div",{className:"muiFontSizeM muiListItemTitle",innerHTML:'<div class="muiListItemTitleInner">'+this.label+"</div>"},p);var m=a.create("div",{className:"muiListItemPerImgBox"},p);a.create("span",{className:"muiListItemPerImg",style:{background:"url("+this.icon+") center center no-repeat",backgroundSize:"cover",display:"inline-block"}},m);if(this.creator){var l=a.create("div",{className:"muiListItemCreator muiFontSizeS muiFontColorMuted"},p);l.innerText=this.creator}if(this.status){var o=a.create("div",{className:"muiListItemStatus muiFontSizeS muiFontColorMuted"},p);o.innerHTML=this.status}var k=a.create("div",{className:"muiListItemBottom muiFontSizeS muiFontColorMuted"},this.contentNode);if(this.created){a.create("div",{className:"muiListItemExpTimeInfo",innerHTML:f["kmCarmngApplication.fdApplicationTime"]+':<span class="muiListItemExpTime"> '+this.created+"</span>"},k)}if(this.summary){a.create("div",{className:"muiListItemMinorInfo",innerHTML:'<span class="muiListItemMinorItem"> '+this.summary+"</span>"},k)}if(this.href){this.proxyClick(this.contentNode,this.href,"_blank")}},startup:function(){if(this._started){return}this.inherited(arguments)},_setLabelAttr:function(k){if(k){this._set("label",k)}},_onDispatcher:function(k){k.stopEvent()}});return j})},"km/carmng/mobile/js/list/item/CarApplyItemListMixin":function(){define(["dojo/_base/declare","mui/list/_TemplateItemListMixin","km/carmng/mobile/js/list/item/CarApplyItemMixin"],function(a,b,c){return a("km.carmng.list.CarApplyItemMixin",[b],{itemTemplateString:null,itemRenderer:c})})}}});require({cache:{"km/carmng/mobile/js/Apply_zh-cn._min_":function(){define("",{"kmCarmng.tree.my.submit":"我提交的","kmCarmng.tree.my.approval":"待我审的","kmCarmng.tree.my.approved":"我已审的","kmCarmngCategory.fdOrder":"排序号","kmCarmngDispatchersInfo.detail":"调度明细","kmCarmngMaintenanceInfo.docCreatorId":"创建者","ROLE_KMCARMNG_MOTORCADE_SETTING.description":"可对车队进行维护","kmCarmngInfringeInfo.fdInfringeSite":"违章地点","mui.kmCarmngInformation.docStauts3":"报废","ROLE_KMCARMNG_DATAMNG.description":"车辆管理_允许管理并维护车辆管理业务数据授权","mui.kmCarmngInformation.docStauts2":"送修","mui.kmCarmngInformation.docStauts1":"在役","kmCarmngInfomation.isNotify.tip":"是否在年检日期前通知","kmCarmngApplication.evaluationStatus":"评价状态","KmCarmngDispatchersInfo.fdNotifyType":"通知方式","kmCarmngCategory.docCreateTime":"创建时间","kmCarmngDispatchersLog.docCreator":"调度人","kmCarmngDispatchersInfo.delete.confirm":"调度信息删除后，对应的回车登记信息及费用信息也将被删除，请确认是否继续?","kmCarmngInsuranceInfo.fdInsurancePrice":"保险价值","mui.kmCarmngEvaluation.score4":"满意","mui.kmCarmngEvaluation.score3":"一般","mui.kmCarmngEvaluation.score2":"不满意","kmCarmngApplication.docCreatorId":"创建者","kmCarmngMotorcadeSet.fdNotify":"通知设置","mui.kmCarmngEvaluation.score1":"很不满意","kmCarmngApplication.portlet.myFlow.create.my":"我发起的车辆申请","kmCarmngInfomation.fdEngineNumber":"发动机号","kmCarmng.config.print":"默认打印选项","mui.kmCarmngEvaluation.score5":"非常满意","kmCarmngInsuranceInfo.fdIsNotify":"通知状态","kmCarmngInsuranceInfo.fdIsThirdInsurance":"第三者险","kmCarmngInsuranceInfo.fdIsLiability":"责任险","kmCarmngInfomation.driver.fdUseCount":"出车次数","kmCarmngCategory.fdId":"ID","kmCarmngDriversInfo.create.title":"新建驾驶员","kmCarmngDispatchersInfo.fdVehichesTypeId":"车辆类型","kmCarmngInsuranceInfo.fdInsuranceStartTime":"保险开始日期","kmCarmngApplication.fdDestinationCoordinate":"目的地经纬度","table.kmCarmngCategory":"类别设置","kmCarmngApplication.fdUserPersons.outer":"外部用车人","kmCarmngDriversInfo.fdName":"姓名","kmCarmngInsuranceInfo.docCreateTime":"创建时间","kmCarmngEvaluation.fdEvaluationTime":"评价时间","kmCarmngApplication.fdInnerPerson":"内部：","kmCarmngInfomation.vehichesType":"车型","kmCarmngDriversInfo.fdCredentialsTime":"初次领证时间","kmCarmngMotorcadeSet.delete.erroe":"违反数据约束错误，请检查数据是否被关联","kmCarmngApplication.fdRemark":"备注","kmCarmngCategory.authReaderFlag":"阅读标记","kmCarmngDispatchersLog.no.car":"不派车，原因：","kmCarmngApplication.fdDeparture.pleaseInput":"请输入出发地","kmCarmng.tree.car.information4":"保险信息","kmCarmng.tree.car.information5":"保养信息","kmCarmng.tree.car.information6":"按车队","kmCarmngInsuranceInfo.attachment":"附件","kmCarmng.tree.car.information1":"按类型","kmCarmngRegisterInfo.fdRealPath":"实际行驶路线","kmCarmngDriversInfo.fdRemark":"备注","kmCarmng.tree.car.information2":"按状态","kmCarmng.tree.car.information3":"违章信息","kmCarmng.button10":"评价","kmCarmng.history.record":"历史用车","kmCarmngInfomation.search":"车辆信息搜索","kmCarmngInfomation.fdAnnuaCheckFrequency":"年检频率","kmCarmngDispatchersLog.fdDispatchersId":"调度id","kmCarmngDriversInfo.fdCredentialsType":"证件类型","kmCarmngInfomation.fdInsurancePrice":"保险费用","kmCarmngApplication.workflow.null":"车队获取流程实例失败","kmCarmngCategory.fdParentId":"父类别","kmCarmngApplication.dispatcher.notify.11.subject":"您原负责将于%km-carmng:kmCarmngDispatcherInfo.fdUseTime%的出车（%km-carmng:kmCarmngDispatcherInfo.fdCarInfo%)现已更换驾驶员，请悉知!","kmCarmng.evaluate.title":"申请单评价","button.setPageBreak":"设置分页","kmCarmngCategory.authEditors":"可编辑者","kmCarmngApplication.portlet.myFlow.create.my.table":"我发起的车辆申请（表格）","mui.kmCarmngApplication.fdUseTime":"用车时间","kmCarmng.message.phone.notnull":"手机号码为空","kmCarmng.button1":"导出EXCEL","kmCarmngInfomation.motorcade.classify":"车队分类","kmCarmng.button3":"清除","kmCarmng.button2":"查询","kmCarmngRegisterInfo.fdMileageBeforeNumber":"出车里程表数","kmCarmng.button5":"回车登记","kmCarmng.button4":"统计","kmCarmng.button7":"更改调度","button.zoom.in":"放大文字","ROLE_KMCARMNG_SETTING.description":"可进行车辆管理的基础设置","kmCarmng.button6":"编辑登记","kmCarmng.button9":"查看历史调度单","kmCarmng.button8":"调度","kmCarmngDriversInfo.fdSysId":"编号","kmCarmng.message.title0":"至","kmCarmngApplication.fdApplicationPath":"行程安排","kmCarmngCount.season":"季度","kmCarmngInsuranceInfo.fdVehicles.fdCategoryName":"车辆类型","kmCarmngDispatchersInfo.fdFlag1":"出车","button.pageBreak":"分页","kmCarmngApplication.fdOtherPerson":"外部：","kmCarmng.excel.exportCarUseExcel.dept":"部门用车统计","kmCarmngDispatchersInfo.fdDriversName":"驾驶员姓名","mui.kmCarmngInsuranceInfo.fdRegisterTime":"登记日期","kmCarmngInfringeInfo.fdInfringeTime":"违章时间","KmCarmngDispatchersInfo.check.tip2":"请确认是否继续在该时间段进行调度！","table.kmCarmngInfringeInfo":"违章信息","KmCarmngDispatchersInfo.check.tip1":"在当前时间段存在以下已调度情况：","portlet.select":"请选择车队","kmCarmngDispatchersInfo.fdFlag2":"回车","kmCarmngDriversInfo.fdCredentialsNumber":"证件号码","table.kmCarmngDispatchersInfo":"调度信息","ROLE_KMCARMNG_MOTORCADE_ATTEMPER.description":"只可以对本车队的车辆进行调度","mui.kmCarmngRegisterInfo.fee.unit":"元","kmCarmngDispatchersInfo.docCreator":"调度人","kmCarmngMotorcadeSet.fdNotifyMinuterDispatchers":"通知调度员时间间隔","kmCarmngUserFeeInfo.fdTurnpikeFee":"路桥费用","ROLE_KMCARMNG_TRANSPORT_EXPORT.name":"车辆管理_导出文档","kmCarmngRegisterInfo.fdMileageStartNumber":"开始行驶里程","mui.kmCarmngInfringeInfo.fdInfringeTime":"违章时间","kmCarmng.tree.application":"用车申请","kmCarmngRegisterInfo.fdDispatchersId":"调度单","kmCarmng.tree.application.sys.workflow":"用车申请流程","kmCarmngDriversInfo.fdIsValidation":"验证","kmCarmngInsuranceInfo.notify.persons":"通知人","kmCarmng.config.note":"流程处理","table.kmCarmngDispatchersInfolist":"调度明细","kmCarmngApplication.dispatcher.notify.6.subject":"驾驶员%km-carmng:kmCarmngDriverInfo.fdName%的驾照快到年审时间，请关注！","mui.kmCarmngDispatchersInfo.apply":"申请","ROLE_KMCARMNG_PRINT.description":"允许打印用车申请的内容。","ROLE_KMCARMNG_EVALUATION.name":"车辆管理_满意度管理","kmCarmngInfomation.fdInsutanceComputer":"保险公司","kmCarmngInfomation.fdUseCount":"用车次数","kmCarmngInfomation.fdFuelStandard":"定额燃油标准","kmCarmngDispatchersLog.fdCarNames":"车牌号","ROLE_KMCARMNG_PRINT.name":"车辆管理_打印文档","button.printPreview":"打印预览","kmCarmngRegisterInfo.fee.unit":"元","kmCarmngInfomation.fdUnit":"年检单位","kmCarmngApplication.dispatcher.notify.sms":"如果所选车辆的驾驶员包含组织架构以外的驾驶员，可采用短信方式通知(本功能需要集成短信系统)","kmCarmngApplication.autoCreateNum":"(提交时系统自动生成编号)","ROLE_KMCARMNG_BACKSTAGE_MANAGER.description":"允许对当前模块后台进行管理配置","kmCarmngDispatchersInfo.fdDriverId":"驾驶员","kmCarmngApplication.portlet.myFlow.all.new":"所有车辆申请【新】","kmCarmngApplication.autoCreate":"(提交时系统自动生成)","table.kmCarmngUserFeeInfo":"部门用车费用表","kmCarmng.tree.refuse":"驳回","kmCarmngApplication.fdDestination":"目的地","kmCarmngMaintenanceInfo.fdPersonId":"送修人","kmCarmng.status.publish.hold":"已完成","kmCarmngMaintenanceInfo.docCreateTime":"创建时间","sysWfNode.processingNode.currentProcessor":"当前处理人","kmCarmngInformation.dispatchersLog":"调度记录","kmCarmng.excel.exportCarUseExcel":"车辆使用统计","mui.kmCarmngInfomation.fdInsutanceTime":"保险日期","kmCarmngApplication.fdApplicationDeptParent":"所属机构","kmCarmngDriversInfo.fdType":"类型","kmCarmngInfomation.docCreateTime":"创建时间","kmCarmngDriversInfo.fdAnnualAuditingTime":"年审时间","kmCarmngApplication.dispatcher.notify.3.subject":"出车情况已登记，请查看，主题：%km-carmnag:kmCarmngApplication.docSubject%","kmCarmngUserFeeInfo.fdStopFee":"停车费用","kmCarmngInfomation.driver":"司机","kmCarmng.tree.car.information":"车辆信息","kmCarmngInformation.docStauts1":"在役","module.km.carmng":"车辆管理","kmCarmngRegisterInfo.confirm.tip":"请确定用车申请和实际用车情况是否一致，如不一致则先编辑用车申请！确定后用车信息不能修改。","kmCarmngInformation.docStauts3":"报废","kmCarmngInformation.docStauts2":"送修","kmCarmngMain.job.sync":"车辆管理今日工作同步接口","kmCarmng.tree.car.information22":"送修","kmCarmngMotorcadeSet.fdNotifyType":"通知方式","kmCarmng.tree.car.information23":"报废","kmCarmng.message.year":"年","kmCarmngDispatchersInfo.view.info":"查看调度信息","kmCarmngMaintenanceInfo.fdId":"ID","kmCarmngApplication.portlet.myFlow.all":"所有车辆申请","kmCarmng.tree.car.information21":"在役","kmCarmngInfomation.fdInsutanceTime":"保险日期","kmCarmngDispatchersInfo.fdUserNumber":"人","kmCarmngInfringeInfo.fdRemark":"违章事由","table.kmCarmngMotorcadeSet":"车队设置","kmCarmngInfomation.borrow.cycle":"可借周期","kmCarmngApplication.dispatcher.notify.10.subject":"您负责驾驶的车牌号为%km-carmng:kmCarmngDispatcherInfo.fdCarInfo%的车辆将于%km-carmng:kmCarmngDispatcherInfo.fdUseTime%出车，请关注！","kmCarmngMaintenanceInfo.fdVehiclesInfoId":"车牌号码","kmCarmngApplication.docSubject":"用车目的","kmCarmng.tree.wait":"待审","table.kmCarmngInfomation":"车辆信息","kmCarmngApplication.fdUserNumber":"随车人数","ROLE_KMCARMNG_CREATE.description":"可创建用车申请","ROLE_KMCARMNG_ATTEMPER.description":"除了在车队设置中各个车队的调度员可调度本车队的用车申请外，拥有此角色的人员可以调度所有用车申请和删除调度信息","mui.kmCarmngInfringeInfo.fdInfringeSite":"违章地","kmCarmngEvaluation.fdEvaluator":"评价人","kmCarmngCount.common.query.interval":"统计区间","kmCarmngApplication.fdOtherUsersWarn":"请使用半角或英文的分号;分隔","ROLE_KMCARMNG_DEFAULT.description":"访问 ”车辆管理” 模块的基本权限，没有该权限则不能访问整个模块","kmCarmngDriversInfo.fdCredentialsNumber.message":"证件号码只能为字母和数字","table.kmCarmngEvaluation":"满意度评价","button.cancelPageBreak":"取消分页","kmCarmngApplication.fdApplicationReason":"用车事由","kmCarmngRegisterInfo.fdStopFee":"停车费用","table.kmCarmngMaintenanceInfo":"车辆保养","kmCarmng.fdUseTime":"用车时间","kmCarmngApplication.fdDepartureDetail":"出发地详情","kmCarmngRegisterInfo.fdId":"ID","kmCarmngInfo.notify.tip4.subject":"车牌号为%km-carmng:kmCarmngInfomation.fdNo%的年检日期快到，请关注！","kmCarmngApplication.dispatcher.notify.4.subject":"车辆申请已通过，请调度派车，主题：%km-carmnag:kmCarmngApplication.docSubject%","kmCarmngDriversInfo.fdNotifyPersons":"通知人","kmCarmngDispatchersInfo.docCreateTime":"调度时间","ROLE_KMCARMNG_REGISTER.name":"车辆管理_回车登记管理员","kmCarmngDispatchersInfo.fdRelationPhone":"驾驶员电话","kmCarmngCount.fdEveTime.to":"至","kmCarmngApplication.authAllEditors":"所有编辑者","kmCarmngDriversInfo.fdRelationPhone":"手机","kmCarmngApplication.dispatcher.notify.9.subject":"车牌号为%km-carmng:kmCarmngDispatcherInfo.fdCarInfo%的车辆将于%km-carmng:kmCarmngDispatcherInfo.fdUseTime%出车，请关注！","kmCarmngApplication.fdApplicationPersonPhone":"联系人电话","table.KmCarmngPath":"车辆用车路径","ROLE_KMCARMNG_DELETE.description":"可删除所有的用车申请","kmCarmngDriversInfo.fdValidTime":"证件有效期限","kmCarmngInsuranceInfo.fdRegisterTime":"初次登记日期","kmCarmngMotorcadeSet.authReader.inner":"（为空则所有内部人员可以使用）",docModifyTime:"修改时间","kmCarmngCategory.fdName":"类别名称","ROLE_KMCARMNG_REGISTER.description":"除了在车队设置中各个车队的回车登记员可登记本车队的用车外，拥有此角色的人员可以回归登记所有用车","ROLE_KMCARMNG_DELETE.name":"车辆管理_删除申请","kmCarmng.use.all":"所有用车","kmCarmngMotorcadeSet.tree.title":"车队信息","kmCarmngDriversInfo.docCreatorId":"创建者","kmCarmngRegisterInfo.fdUser":"用车人","ROLE_KMCARMNG_BACKSTAGE_MANAGER.name":"车辆管理_后台管理","ROLE_KMCARMNG_EDITOR.description":"可编辑所有审批通过后的用车申请","mui.kmCarmngInsuranceInfo.order":"保单号","kmCarmngInfomation.fdUseTime":"出车时长（分钟）","kmCarmngInfomation.fdMotorcadeId":"所属车队","kmCarmngEvaluation.fdAppNames":"用车目的","kmCarmngInsuranceInfo.isNotify.tip":"是否在保险结束前通知","kmCarmngInsuranceInfo.notify.tip4.subject":"车牌号为%km-carmng:kmCarmngInfomation.fdNo%的保险快到期，请关注！","kmCarmngDispatchers.type":"调度处理方式","kmCarmngDispatchersInfo.fdEndTime":"调度结束时间","portlet.selectKmCarmngMotorcade":"选择车队","kmCarmngMotorcadeSet.authReader.tip":"（为空则所有内部人员可以使用）","kmCarmngMotorcadeSet.fdId":"ID","kmCarmngRegisterInfo.fdRemark":"备注","kmCarmngDriversInfo.fdIdentificationNumber":"身份证号","kmCarmngInsuranceInfo.fdIsRobInsurance":"抢险","kmCarmngInfomation.fdDriverName":"驾驶员姓名","kmCarmngDriversInfo.fdDriverNumber":"驾驶证号","kmCarmngInfomation.error2":"年检频率 不能为空","kmCarmngInfomation.carNo":"车牌","kmCarmngInfomation.error3":"年检频率 必须为正整数类型","kmCarmng.mobile.header.dispatch":"待用车调度","kmCarmngMaintenanceInfo.fdRemark":"备注","kmCarmngInfomation.error1":"初次年检时间 不能为空","kmCarmngApplication.fdApplicationTime":"创建时间","kmCarmngDispatchersInfo.applicationInfo":"用车申请单","kmCarmngDispatchersInfo.driverInfoIntro":"驾驶员介绍","kmCarmngInfomation.fdNo":"车牌号码","kmCarmng.process.records":"流程记录","kmCarmngApplication.autoCreApplicationNum":"(提交时系统自动生成申请单编号)","mui.kmCarmngDispatchersInfo.fdFlag3":"不派车","table.kmCarmngApplication":"用车申请","ROLE_KMCARMNG_CARMANAGE.name":"车辆管理_车辆信息管理","mui.kmCarmngDispatchersInfo.fdFlag2":"回车","mui.kmCarmngDispatchersInfo.fdFlag1":"出车","kmCarmngDispatchersInfo.fdFlag":"标识 ","kmCarmngEvaluation.fdEvaluationContent":"评价内容","kmCarmngApplication.create.button.next":"下一步","kmCarmngDriversInfo.fdRelationInfo":"联系方式","kmCarmngInsuranceInfo.fdId":"ID","kmCarmngInsuranceInfo.fdIsAbatement":"不记免赔","kmCarmngDispatchersInfo.carInfo.notNull":"调度车辆不能为空！","kmCarmngInfomation.fdDriversType":"驾驶员类型","kmCarmngInsuranceInfo.fdVehiclesInfoId":"车牌号码","mui.process.records":"流程记录","kmCarmngDispatchersInfo.fdCarInfoName":"车牌","kmCarmngUserFeeInfo.fdVehiclesId":"车辆信息","kmCarmngApplication.fdEndTime":"结束时间","kmCarmng.tree.application.status":"按审批状态","button.print":"打印","kmCarmngDispatchersLog.content":"调度内容","kmCarmngDriversInfo.fdType2":"注册用户","mui.kmCarmngInsuranceInfo.fdInsuranceFee":"保险金额","kmCarmngDriversInfo.fdType1":"未注册用户","kmCarmng.quartz0.description":"根据待办参数配置，定时发送待办信息","ROLE_KMCARMNG_CALENDAR.name":"车辆管理_查看用车日历","kmCarmngMaintenanceInfo.fdMaintenanceFee":"保养费","button.printPreview.error":"由于IE的安全限制，目前无法调用打印预览.\\n请直接使用IE菜单中的打印预览选项（文件->打印->打印预览 或 文件->打印预览）","kmCarmngInsuranceInfo.fdIsGlassInsurance":"玻璃险","kmCarmngCount.common.query.time":"时间","kmCarmng.back":"返回","kmCarmngApplication.fdUsers.notNull":"用车人 不能为空","kmCarmngApplication.fdApplicationPersonAndPhone":"联系人及电话","kmCarmngDispatchersInfo.fdDriverName":"驾驶员姓名","kmCarmngInfomation.fdLastModifiedTime":"最后修改时间","kmCarmngInsuranceInfo.fdVehicles.fdName":"车辆名称","kmCarmng.config.info":"调度信息","kmCarmng.excel.count3":"违章统计导出EXCEL","kmCarmng.excel.count2":"保养统计导出EXCEL","kmCarmngInfringeInfo.fdInfringePerson":"违章人","kmCarmngApplication.authEditorFlag":"可编辑者标记","kmCarmng.excel.count1":"出车统计导出EXCEL","kmCarmngDispatchersLog.fdStartTime":"调度开始时间","kmCarmngRegisterInfo.fdRegisterId":"登记人","kmCarmngMaintenanceInfo.fdMaintenanceTime":"保养日期","kmCarmngUserFeeInfo.fdApplicationDept":"用车部门","kmCarmngApplication.portlet.myFlow.involved.table":"我审批的车辆申请（表格）","kmCarmngDispatchersLog.fdDispatchersTime":"调度时间","kmCarmngApplication.my":"我的申请","ROLE_KMCARMNG_SETTING.name":"车辆管理_基础设置","kmCarmngApplication.fdUserPersons.inner":"内部用车人","kmCarmngApplication.portlet.myFlow.all.table":"所有车辆申请（表格）","kmCarmngInformation.dispatchersInfo":"回车信息","kmCarmngRegisterInfo.fdTurnpikeFee":"路桥费用","kmCarmng.status.publish.holding":"出车中","button.zoom.out":"缩小文字","kmCarmngMotorcadeSet.fdRemark":"车队描述","kmCarmngInsuranceInfo.fdInsuranceNo":"保险单号","ROLE_KMCARMNG_MOTORCADE_ATTEMPER.name":"车辆管理_用车调度","kmCarmngInsuranceInfo.docModifyTime":"修改时间","kmCarmngApplication.fdUserPersons":"用车人","kmCarmngCount.month":"月度","kmCarmngApplication.fdApplicationDept":"申请部门","kmCarmngDispatchersInfo.fdMileage":"里程数","kmCarmng.excel.exportCarUseDetailExcel":"车辆使用统计-明细","mui.kmCarmngInsuranceInfo.fdInsurancePrice":"保险价值","kmCarmngInfringeInfo.fdId":"ID","kmCarmng.historyForm":"历史调度单","kmCarmngDispatchersInfo.fdNotifyPerson.2":"联系人","kmCarmngDriversInfo.fdAnnualExamFrequency":"年审频率","kmCarmngDispatchersInfo.fdNotifyPerson.3":"派车后通知用车人","kmCarmngDispatchersInfo.fdApplicationIds":"申请单","kmCarmngInfomation.constraint.error":"检测到车辆已被使用，数据关联约束，建议报废处理！","table.kmCarmngDriversInfo":"驾驶员信息","mui.kmCarmngInfringeInfo.fdInfringeFee":"违章费","kmCarmngDispatchersInfo.fdNotifyPerson.0":"驾驶员","KmCarmngPath.fdDestinationDetail":"目的地详情","kmCarmngDispatchersLog.fdCarIds":"车辆id","kmCarmngDispatchersInfo.fdNotifyPerson.1":"申请人","kmCarmngInfomation.fdMotorcade":"车队","kmCarmngMotorcadeSet.fdNo":"申请单编号","kmCarmngInsuranceInfo.docModifier":"修改者","kmCarmngApplication.search":"搜索","kmCarmng.quartz3.description":"【组织人员同步】根据参数，定时任务","kmCarmng.tree.title":"车辆管理","kmCarmngApplication.fdDestination.pleaseInput":"请输入目的地","kmCarmngDispatchersLog.fdIsCar":"调度类型","kmCarmngMotorcadeSet.authReader.outter":"（为空则所有{0}人员可以使用）","kmCarmngApplication.dispatcher.notify.8.subject":"车牌号为%km-carmng:kmCarmngInfomation.fdNo%快到年审时间，请关注！","kmCarmngRegisterInfo.unit":"单位","kmCarmngInsuranceInfo.notify.tip2":"通知人不能为空","kmCarmngInsuranceInfo.notify.tip3":"提前通知天数 必须为正整数类型","kmCarmngInsuranceInfo.notify.tip1":"提前通知天数不能为空","kmCarmngDispatchersInfo.fdApplication":"申请单信息","kmCarmngApplication.dispatcher.no.car.notify.update.subject":"您申请的用车已被调整为不安排派车，请链接查看详细原因，主题：%km-carmng:kmCarmngApplication.docSubject%","kmCarmngApplication.fdMotorcadeId":"车队名称","mui.kmCarmngInfomation.carNo":"车牌号","kmCarmngRegisterInfo.fdOtherFee":"其他费用","kmCarmngInfomation.fdAnnuaCheckTime":"初次年检日期","kmCarmngMotorcadeSet.authEditor.tip":"（可维护者可以编辑和删除当前资源；为空则只有管理人员可以编辑和删除）","kmCarmngMotorcadeSet.fdName":"车队名称","kmCarmng.tree.all":"所有","kmCarmng.excel.export2":"违章统计","kmCarmngEvaluation.score2":"不满意","kmCarmng.excel.export1":"出车统计","kmCarmngEvaluation.score3":"一般","kmCarmng.excel.export3":"保养统计","kmCarmngEvaluation.score1":"很不满意","kmCarmng.tree.draft":"草稿","kmCarmngDispatchersInfo.fdTravelPath":"行驶路线","kmCarmngRegisterInfo.input":"请输入","kmCarmng.tree.dispatcher2":"调度信息","kmCarmngUserFeeInfo.fdCarwashFee":"洗车费用","kmCarmng.tree.dispatcher1":"用车调度","kmCarmng.tree.dispatcher4":"用车资源日历","kmCarmngDriversInfo.docCreateTime":"创建时间","kmCarmngInfomation.fdPassageMoney":"车船费用","kmCarmng.tree.dispatcher3":"用车查询","description.refreshTemplate":"此操作将清空当前表单的所有输入，是否继续？","kmCarmng.error.message8":"查询日期不能为空！","kmCarmng.error.message7":"回车里程数不能小于出车里程数！","kmCarmngInfomation.fdSeatNumber":"座位数","kmCarmng.error.message9":"起始日期不能在当天日期之前！","ROLE_KMCARMNG_CARMANAGE.description":"可以对车辆信息进行维护","kmCarmng.quartz0":"【车辆管理】通知任务","kmCarmngEvaluation.score4":"满意","kmCarmngEvaluation.score5":"非常满意","kmCarmng.quartz2":"【车辆管理】更新驾驶员手机号码定时任务","mui.kmCarmngMaintenanceInfo.fdRepairFee":"维修费","kmCarmng.tree.base.set":"基础设置","kmCarmng.quartz1":"【车辆管理】保险、年审通知定时任务","table.kmCarmngRegisterInfo":"回车登记单","kmCarmng.quartz3":"【组织人员同步】更新组织人员定时任务","kmCarmngApplication.portlet.myFlow.involved":"我审批的车辆申请","kmCarmngInfomation.fdYearlongTicket":"年票","kmCarmngApplication.dispatcher.notify.5.subject":"您乘坐的车牌号为%km-carmng:kmCarmngDispatcherInfo.fdCarInfo%将于%km-carmng:kmCarmngDispatcherInfo.userTime%出车%km-carmng:kmCarmngDispatcherInfo.fdDestination%请您关注！","kmCarmngInsuranceInfo.docCreatorId":"创建者","kmCarmngInsuranceInfo.notify.day.unit":"天","kmCarmng.excel.exportCarUseExcel.person":"个人用车统计",docModifierId:"修改者","kmCarmng.error.message0":"开始时间不能小于结束时间！","kmCarmngDispatchersInfo.fdId":"ID","mui.kmCarmngMaintenanceInfo.fdMaintenanceTime":"保养日期","kmCarmng.error.message2":"用车前通知调度人 分钟","kmCarmng.error.message1":"用车前通知司机分钟","kmCarmng.error.message4":"开始日期不能大于结束日期,结束日期不能大于今日日期！","kmCarmngApplication.docStatus":"用车状态","kmCarmng.error.message3":"用车前通知用车人 分钟","kmCarmng.error.message6":"结束日期不能大于今日日期！","kmCarmng.error.message5":"开始日期不能大于等于今日日期！","kmCarmng.tree.discard":"废弃","kmCarmngCount.year":"年度","kmCarmngRegisterInfo.fdFuelFee":"燃油费用","kmCarmng.kmCarmngApplication.docStatus":"文档状态","kmCarmngMotorcadeSet.authReader.all":"（为空则所有人员可以使用）","kmCarmngDispatchersInfo.fdCarInfoSeatNumber":"座位数","kmCarmng.fdRelationPhone.message":"联系电话 只能为数字","ROLE_KMCARMNG_EVALUATION.description":"查看车辆的满意度评价","kmCarmngApplication.portlet.myFlow.create.my.new":"我发起的车辆申请【新】","kmCarmng.today":"今天","kmCarmngDispatchersInfo.fdDestination":"目的地","kmCarmngInfringeInfo.docCreateTime":"创建时间","kmCarmngInfomation.docCreatorId":"创建者","kmCarmngEvaluation.fdEvaluationScore":"满意度","kmCarmngApplication.authOtherEditors":"其他可编辑者","kmCarmngDispatchers.type.0":"调度派车","kmCarmngDispatchers.type.1":"不派车","kmCarmngInsuranceInfo.fdRemark":"备注","kmCarmngDriversInfo.fdOrder":"排序号","kmCarmngApplication.fdIsDispatcher":"调度状态","ROLE_KMCARMNG_MOTORCADE_SETTING.name":"车辆管理_车队设置","kmCarmngDispatchersInfo.tips":"请选择驾驶员后再查看介绍信息","kmCarmngInfomation.fdId":"ID","kmCarmngDriversInfo.warn1":"有效日期不能早于初次领证日期！","kmCarmng.tree.dispatcher":"调度管理","kmCarmngDispatchersInfo.carInfo.add":"添加车辆","kmCarmngApplicationIndex.oper.listByDispatchers":"用车调度查询","kmCarmng.day":"日","kmCarmng.tree.my.examine":"我审批的","kmCarmngDispatchersInfo.carInfoIntro":"车辆介绍","kmCarmngInsuranceInfo.fdNotifyPersons":"通知人","kmCarmngUserFeeInfo.fdMileageNumber":"行驶里程","kmCarmngInfomation.fdDriverId":"驾驶员","kmCarmng.week":"周","kmCarmng.application.view":"申请单查看","kmCarmngInsuranceInfo.fdProductBrand":"厂牌号码","kmCarmngApplication.dispatcher.no.car.notify.subject":"您申请的用车未能安排派车，请链接查看详细原因，主题：%km-carmng:kmCarmngApplication.docSubject%","kmCarmng.quartz1.description":"根据待办参数配置，定时通知调度人员对车辆进行保险、年审","kmCarmng.tree.use.status":"按用车状态","kmCarmngCategory.search":"搜索","kmCarmngInfomation.all":"所有车辆","ROLE_KMCARMNG_DATAMNG.name":"车辆管理_数据管理权限","kmCarmngInfringeInfo.docCreatorId":"创建者","kmCarmngMotorcadeSet.fdDispatchersId":"调度员","kmCarmngRegisterInfo.fdTotalFee":"总计","button.pageBreak.title":"点击“分页”按钮后请点击页面上要分页的地方。\n如果要取消请点击“分页”按钮后再点击页面上红色的分页线","kmCarmngApplication.fdOtherUsers":"外部用车人","ROLE_KMCARMNG_READER.description":"可阅读所有的用车申请","mui.kmCarmngDispatchersInfo.docCreateTime":"调度时间","kmCarmngApplication.fdDestinationDetail":"目的地详情","kmCarmngApplication.fdDeparture":"出发地","kmCarmng.excel.exportQueryDriverExcel":"驾驶员出车统计","kmCarmngDriversInfo.fdDriveYear":"驾龄","kmCarmngApplication.fdLastModifiedTime":"最后修改时间","kmCarmngInfomation.fdRemark":"备注","kmCarmngDispatchersInfo.fdRegisterId":"回车登记员","kmCarmngMotorcadeSet.isEffective":"是否有效","kmCarmngUserFeeInfo.fdUseEndTime":"用车结束时间","kmCarmngApplication.portlet.myFlow.involved.new":"我审批的车辆申请【新】","kmCarmng.float.message":"请输入数值！","kmCarmngCount.common.query.incline":"包含所有子部门","ROLE_KMCARMNG_EDITOR.name":"车辆管理_编辑申请","kmCarmngRegisterInfo.mileage.unit":"公里","kmCarmngDispatchersInfo.dispatchtips":"车辆或驾驶员已经被调度，请确认是否继续调度！","kmCarmngApplication.add":"新建","kmCarmngDispatchersInfo.fdStartTime":"调度开始时间","KmCarmngPath.fdDestinationCoordinate":"目的地经纬度","kmCarmng.profileCfg.description":"公用车辆（费用、车辆保养、维修）、驾驶员信息的统一管理。通过统一调度，合理安排，节约用车资源","kmCarmngInsuranceInfo.fdIsDamag":"车损","kmCarmngApplication.addPathItem":"添加目的地","kmCarmngCategory.hbmParent":"父类别","ROLE_KMCARMNG_CREATE.name":"车辆管理_创建用车申请","kmCarmng.calendar.nodata":"没有更多的数据可加载了.....","kmCarmngInfringeInfo.fdVehiclesInfoId":"车牌号码","kmCarmngApplication.dispatcher.notify.1.subject":"您申请的用车已经安排，司机为：%km-carmng:kmCarmngDriversInfo.fdName%，请查看，主题：%km-carmnag:kmCarmngApplication.docSubject%","kmCarmng.templet.set":"模板设置","kmCarmng.tree.base.intro":"车队介绍","kmCarmngDispatchersInfo.fdMotorcadeId":"车队号","kmCarmngApplication.authReaderId":"可阅读者  ","kmCarmngInfomation.fdCardParameter":"载客/载货量","kmCarmngMotorcadeSet.create.title":"新建车队","kmCarmng.message.frequency.month":"月/次","kmCarmngApplication.fdDepartureCoordinate":"出发点经纬度","kmCarmngMotorcadeSet.fdNotifyTypeUser":"通知方式","kmCarmng.excel.exportCarUseExcel.dept.detail":"部门用车统计-明细","kmCarmngMaintenanceInfo.fdRepairFee":"维修费","kmCarmngInsuranceInfo.fdInsuranceEndTime":"保险结束日期","mui.kmCarmng.message.title0":"至","KmCarmngPath.fdDestination":"目的地","kmCarmng.tree.fee.count3":"违章统计","kmCarmng.tree.fee.count2":"保养统计","ROLE_KMCARMNG_CHARGESTAT.description":"可进行车辆的报表统计","kmCarmng.tree.fee.count1":"出车统计","kmCarmngDispatchersInfo.fdCarInfoId":"车牌号码","ROLE_KMCARMNG_READER.name":"车辆管理_阅读申请","kmCarmngRegisterInfo.fdTotalFee1":"用车费用合计","kmCarmngInfomation.fdNotifyPersons":"保险到期前通知人","kmCarmngUserFeeInfo.kmDispatchersInfo":"调度信息","kmCarmngInfomation.seat":"座","kmCarmngMotorcadeSet.fdNotifyMinuterUser":"通知用车人员时间间隔","kmCarmng.excel.exportQueryCarFeeExcel":"车辆费用汇总统计","table.kmCarmngDispatchersLog":"调度日志","kmCarmngCategory.authAllEditors":"可编辑者","kmCarmngApplication.authOtherReaders":"其他可阅读者","kmCarmngRegisterInfo.fdMileageAfterNumber":"回车里程表数","kmCarmng.calendar":"用车日历","kmCarmngRegisterInfo.fdStartTime":"回车开始时间","ROLE_KMCARMNG_ATTEMPER.name":"车辆管理_用车调度管理员","kmCarmngCount.custom":"自定义","kmCarmng.fdTotalFee":"总金额","kmCarmngInsuranceInfo.notify.before.day":"提前通知天数","kmCarmng.message.frequency":"年/次","kmCarmngDispatchersInfo.fdMotorcadeName":"车队名称","kmCarmngDriversInfo.fdId":"ID","kmCarmng.calendar.selectAll":"全选","kmCarmngDispatchersInfo.fdVehichesTypeName":"车辆类型名称","kmCarmng.excel.exportCarUseExcel.person.detail":"个人用车统计-明细","kmCarmng.tree.publish3":"完成","KmCarmngDispatchersInfo.field.null":"<无>","kmCarmng.tree.publish4":"待评价","kmCarmng.tree.publish2":"出车","kmCarmng.tree.already":"已审","kmCarmng.base.info":"基本信息","kmCarmngDriversInfo.fdNotifyType":"通知方式","kmCarmngDispatchersLog.fdEndTime":"调度结束时间","kmCarmngInfomation.phone":"电话","table.kmCarmngInsuranceInfo":"车辆保险","kmCarmngInfomation.docStatus":"状态","ROLE_KMCARMNG_TRANSPORT_EXPORT.description":"可导出文档","kmCarmng.page.serial":"序号","kmCarmngInfomation.fdVehichesType":"车辆类型","kmCarmngRegisterInfo.fdEndTime":"回车结束时间","kmCarmngInfomation.fdBuyTime":"购买时间","button.printConfig":"打印设置","kmCarmngApplication.fdId":"ID","kmCarmng.tree.fee.count":"统计报表","ROLE_KMCARMNG_CALENDAR.description":"可查看用车日历","kmCarmng.status.publish.unHold":"待出车","mui.kmCarmngMaintenanceInfo.fdMaintenanceFee":"保养费","kmCarmngMotorcadeSet.docCreateTime":"创建时间","ROLE_KMCARMNG_USECARQUERY.name":"车辆管理_用车查询","kmCarmngMotorcadeSet.docCreatorId":"创建者","kmCarmng.fdEndTime":"回车时间","kmCarmngUserFeeInfo.fdFee":"费用","kmCarmng.message.phone.error":"请输入有效的手机号码","km.carmng.operation":"操作","kmCarmngApplication.fdUseTime":"用车时间","ROLE_KMCARMNG_USECARQUERY.description":"可以进行用车查询操作","kmCarmngInfringeInfo.fdInfringePersonId":"违章人","kmCarmngUserFeeInfo.fdUseStartTime":"用车开始时间","kmCarmngApplication.authReaderFlag":"可阅读者标记","kmCarmng.tree.publish":"通过","kmCarmngCategory.authReaders":"可阅读者","kmCarmngApplication.dispatcher.notify.2.subject":"车辆调度通过，回车请做好登记，调度信息：%km-carmnag:kmCarmngDispatcher.message%","mui.kmCarmngDispatchersInfo.submit":"提交","kmCarmng.tree.evaluate":"满意度","kmCarmngApplication.fdApplicationPerson":"联系人","kmCarmngInfomation.infringeCount":"违章次数","kmCarmngApplication.dispatcher.no.car.notify.driver.subject":"您之前安排的出车已调整为不出车，请链接查看详细原因，主题：%km-carmng:kmCarmngApplication.docSubject%","kmCarmng.select":"选择车辆","kmCarmngInfomation.docSubject":"车辆名称","kmCarmngMotorcadeSet.fdOrder":"排序号","kmCarmng.use.status":"用车状态","kmCarmngMotorcadeSet.fdNotifyMinuterDriver":"通知司机时间间隔","kmCarmngApplication.attachment":"附件","kmCarmngCategory.authAllReaders":"可阅读者","kmCarmngInfomation.fdRepairFee":"维修费用","kmCarmngUserFeeInfo.fdFuelFee":"燃油费用","kmCarmngDispatchersLog.fdRemark":"不派车原因","kmCarmngApplication.fdNo":"申请单编号","portlet.listtable.desc":"可配置表头列表展现方式，建议部件宽度不低于450px","kmCarmngDriversInfo.fdMotorcadeId":"所属车队","kmCarmngInfomation.fdSysDriver":"驾驶员","kmCarmngApplication.authEditors":"可编辑者","kmCarmngApplication.delete.confirm":"用车申请单删除后,对应的用车调度信息、回车登记信息、评价信息及费用信息也将被删除，请确认是否继续?","kmCarmngDispatchersInfo.fdCarInfoNames":"车辆名称","kmCarmngDriversInfo.fdNotifyType.person":"通知人员","ROLE_KMCARMNG_DEFAULT.name":"车辆管理_默认权限","kmCarmngDispatchersInfo.driver.add":"添加驾驶员","kmCarmngRegisterInfo.fdMileageEndNumber":"结束行驶里程","kmCarmngUserFeeInfo.fdId":"ID","kmCarmng.quartz2.description":"【车辆管理】查找驾驶员信息（注意只针对注册用户），从组织架构中更新手机号码，如果组织架构中该驾驶员的手机是空值，则保留当前手机号码不变。","kmCarmng.error.message13":"请重新输入以1打头的11位有效手机号码！","kmCarmng.error.message12":"驾驶员不能为空！","kmCarmngInfomation.fdMaintenanceFee":"保养费用","kmCarmngCategory.docCreatorId":"创建者","kmCarmng.tree.base.set2":"驾驶员信息","kmCarmng.error.message14":"结束行驶里程不能小于开始行驶里程","kmCarmng.tree.base.set1":"车队设置","kmCarmng.tree.base.set4":"通用流程模板","kmCarmng.tree.base.set3":"车辆类别","kmCarmng.error.message11":"车牌号码不能为空！","kmCarmng.error.message10":"结束时间不能小于开始时间！","kmCarmngDriversInfo.fdRelationPhone.message":"手机号码只能为数字","kmCarmngDispatchersInfo.fdCarInfoIds":"车辆信息","kmCarmngInsuranceInfo.fdInsuranceFee":"保险金额","kmCarmngDispatchersLog.car":"调度派车：","kmCarmngInsuranceInfo.fdIsHeadline":"强制险","kmCarmngInfringeInfo.fdInfringeFee":"违章费用","kmCarmngUserFeeInfo.fdUserId":"用车人员","kmCarmngMotorcadeSet.fdNotify_2":"分钟通知调度人","kmCarmngMotorcadeSet.fdNotify_3":"分钟通知用车人","kmCarmngApplication.fdStartTime":"开始时间","kmCarmngMotorcadeSet.fdNotify_0":"用车前","kmCarmngMotorcadeSet.fdNotify_1":"分钟通知司机","kmCarmngRegisterInfo.fdRegisterTime":"登记时间","kmCarmngInfomation.fdVin":"车架号","kmCarmngInfomation.fdRelationPhone":"联系电话","kmCarmngRegisterInfo.view.info":"查看回车登记","kmCarmngUserFeeInfo.fdOtherFee":"其他费用","kmCarmngApplication.docCreateTime":"创建时间","kmCarmngUserFeeInfo.fdDeptIds":"用车部门","kmCarmngRegisterInfo.fdCarwashFee":"洗车费用","kmCarmngCategory.fdHierarchyId":"层级ID","kmCarmngApplication.dispatcher.notify.7.subject":"您的驾照快到年审时间，请关注！","ROLE_KMCARMNG_CHARGESTAT.name":"车辆管理_统计报表","kmCarmng.config.base":"用车申请","kmCarmngMotorcadeSet.fdRegisterId":"回车登记员"})}}});