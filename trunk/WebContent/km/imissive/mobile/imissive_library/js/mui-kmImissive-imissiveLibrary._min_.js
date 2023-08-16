require({cache:{"km/imissive/mobile/imissive_library/js/header/IndexListNavMixin":function(){define(["dojo/_base/declare","dojo/store/Memory","mui/i18n/_i18n!km/imissive/mobile/imissive_library/js/mui-kmImissive-imissiveLibrary"],function(a,c,b){return a("km.imissive.mobile.imissiveLibrary.indexListNavMixin",null,{store:new c({data:[{url:"/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listChildren&orderby=docCreateTime&ordertype=down",text:b["kmMissive.tree.sendMissive"],headerTemplate:"/km/imissive/mobile/imissive_library/js/header/ImissiveSendTemplate.js"},{url:"/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=listChildren&orderby=docCreateTime&ordertype=down",text:b["kmMissive.tree.receiveMissive"],headerTemplate:"/km/imissive/mobile/imissive_library/js/header/ImissiveReceiveTemplate.js"},{url:"/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=listChildren&orderby=docCreateTime&ordertype=down",text:b["kmMissive.tree.signMissive"],headerTemplate:"/km/imissive/mobile/imissive_library/js/header/ImissiveSignTemplate.js"}]})})})},"sys/mobile/js/mui/list/CardItemDListMixin":function(){define(["dojo/_base/declare","mui/list/_TemplateItemListMixin","mui/list/item/CardItemDMixin"],function(a,b,c){return a("mui.list.CardItemDListMixin",[b],{itemTemplateString:null,itemRenderer:c})})},"km/imissive/mobile/imissive_library/js/header/ImissiveSignTemplate":function(){define(["mui/createUtils","mui/i18n/_i18n!km/imissive/mobile/imissive_library/js/mui-kmImissive-imissiveLibrary"],function(b,g){var d=b.createTemplate;var e=d("div",{dojoType:"mui/sort/SortItem",dojoProps:{name:"docCreateTime",subject:g["mobile.kmImissive.createTime"],value:"down"}});var f=d("div",{dojoType:"mui/sort/SortItem",dojoProps:{name:"docPublishTime",subject:g["mobile.kmImissive.publishTime"],value:""}});var a=d("div",{dojoType:"mui/sort/SortItem",dojoProps:{name:"fdDeadTime",subject:g["mobile.kmImissive.deadline"],value:""}});var c=d("div",{className:"muiHeaderItemRight",dojoType:"mui/catefilter/FilterItem",dojoMixins:"mui/syscategory/SysCategoryMixin",dojoProps:{modelName:"com.landray.kmss.km.imissive.model.KmImissiveSignTemplate",catekey:"fdTemplate",prefix:"q"}});return[e,f,a,c].join("")})},"km/imissive/mobile/imissive_library/js/header/ImissiveReceiveTemplate":function(){define(["mui/createUtils","mui/i18n/_i18n!km/imissive/mobile/imissive_library/js/mui-kmImissive-imissiveLibrary"],function(b,g){var d=b.createTemplate;var e=d("div",{dojoType:"mui/sort/SortItem",dojoProps:{name:"docCreateTime",subject:g["mobile.kmImissive.createTime"],value:"down"}});var f=d("div",{dojoType:"mui/sort/SortItem",dojoProps:{name:"docPublishTime",subject:g["mobile.kmImissive.publishTime"],value:""}});var a=d("div",{dojoType:"mui/sort/SortItem",dojoProps:{name:"fdDeadTime",subject:g["mobile.kmImissive.deadline"],value:""}});var c=d("div",{className:"muiHeaderItemRight",dojoType:"mui/catefilter/FilterItem",dojoMixins:"mui/syscategory/SysCategoryMixin",dojoProps:{modelName:"com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate",catekey:"fdTemplate",prefix:"q"}});return[e,f,a,c].join("")})},"km/imissive/mobile/imissive_library/js/header/ImissiveSendTemplate":function(){define(["mui/createUtils","mui/i18n/_i18n!km/imissive/mobile/imissive_library/js/mui-kmImissive-imissiveLibrary"],function(b,g){var d=b.createTemplate;var e=d("div",{dojoType:"mui/sort/SortItem",dojoProps:{name:"docCreateTime",subject:g["mobile.kmImissive.createTime"],value:"down"}});var f=d("div",{dojoType:"mui/sort/SortItem",dojoProps:{name:"docPublishTime",subject:g["mobile.kmImissive.publishTime"],value:""}});var a=d("div",{dojoType:"mui/sort/SortItem",dojoProps:{name:"fdDeadTime",subject:g["mobile.kmImissive.deadline"],value:""}});var c=d("div",{className:"muiHeaderItemRight",dojoType:"mui/catefilter/FilterItem",dojoMixins:"mui/syscategory/SysCategoryMixin",dojoProps:{modelName:"com.landray.kmss.km.imissive.model.KmImissiveSendTemplate",catekey:"fdTemplate",prefix:"q"}});return[e,f,a,c].join("")})},"sys/mobile/js/mui/list/item/CardItemDMixin":function(){define(["dojo/_base/declare","dojo/dom-construct","dojo/dom-class","dojo/dom-style","dojo/dom-attr","dojox/mobile/_ItemBase","mui/util","dojo/on","mui/dialog/Tip","mui/openProxyMixin"],function(c,a,h,e,g,i,d,f,j,b){var k=c("mui.list.item.CardItemMixin",[i,b],{tag:"li",created:"",creator:"",icon:"",href:"",summary:"",docPublishTime:"",docDeptName:"",summary:"",docReadCount:"",tagNames:"",buildRendering:function(){this.inherited(arguments);this.domNode=a.create(this.tag,{className:"muiCardItemD"},this.containerNode);this.buildInternalRender()},buildInternalRender:function(){var m=this.isJustShowSubject()?"muiCardItemDVerticalAlignMiddle":"muiCardItemDVerticalAlignTop";var q=a.create("div",{className:"muiCardItemDContainer"},this.domNode);var n=a.create("div",{className:"muiCardItemDLeft "+m},q);if(this.icon){var o=a.create("div",{className:"muiCardItemDPersonIcon"},n);a.create("div",{className:"muiCardItemDPersonIconImg",style:{background:"url("+d.formatUrl(this.icon)+") center center no-repeat",backgroundSize:"cover"}},o)}else{var l=this.listIcon?this.listIcon:"muis-official-doc";var u=a.create("div",{className:"muiCardItemDIcon"},n);a.create("i",{className:"fontmuis "+l},u)}var t=a.create("div",{className:"muiCardItemDRight "+m},q);var s=a.create("div",{className:"muiCardItemDSubject muiFontSizeM muiFontColorInfo",innerHTML:this.label},t);if(this.summary){a.create("div",{className:"muiCardItemDSummary muiFontSizeS",innerHTML:this.summary},t)}if(this.creator||this.docDeptName||this.created||this.docPublishTime||this.docReadCount){var p=a.create("div",{className:"muiCardItemDRightFooter muiFontSizeS muiFontColorMuted "+(this.docReadCount?"muiCardItemDHasReadCount":"")},t);if(this.creator){a.create("div",{className:"muiCardItemDCreator",innerHTML:this.creator},p)}if(this.docDeptName){a.create("div",{className:"muiCardItemDDocDeptName",innerHTML:this.docDeptName},p)}if(this.created){a.create("div",{className:"muiCardItemDCreatedTime",innerHTML:this.created},p)}if(this.docPublishTime){a.create("div",{className:"muiCardItemDPublishTime",innerHTML:this.docPublishTime},p)}if(this.docReadCount){a.create("div",{className:"muiCardItemDReadInfo",innerHTML:'<span class="muiCardItemDReadCount">'+this.docReadCount+'</span><span class="muiCardItemDViewText">浏览</span>'},p)}}if(this.href){this.proxyClick(this.domNode,this.href,"_blank")}else{var r=a.create("div",{className:"muiCardItemDLock"},this.domNode);this.makeLockLinkTip(this.domNode)}},isJustShowSubject:function(){return !(this.summary||this.creator||this.docDeptName||this.created||this.docPublishTime||this.docReadCount)},makeLockLinkTip:function(l){this.href="javascript:void(0);";f(l,"click",function(m){j.tip({icon:"mui mui-warn",text:"暂不支持移动访问"})})},startup:function(){if(this._started){return}this.inherited(arguments)},_setLabelAttr:function(l){if(l){this._set("label",l)}}});return k})}}});require({cache:{"km/imissive/mobile/imissive_library/js/mui-kmImissive-imissiveLibrary_zh-cn._min_":function(){define("",{"kmMissive.tree.getPlatFormOfficialDocumentQueue":"获取平台公文队列","kmMissive.tree.commonSendNumber":"发文通用编号规则","kmMissive.tree.sendTemplate":"按发文类型","kmMissive.tree.mainMissiveReceiveFlow":"收文通用流程模板设置","kmMissive.tree.commonSendXform":"发文通用表单模板","kmMissive.tree.signMissive":"签报","kmMissive.tree.cacheNumberQuery":"缓存编号查询","kmMissive.tree.signConfig":"签报设置","kmMissive.tree.displayConfig":"默认值设置","kmMissive.tree.commonSignXformCfg":"签报表单数据映射设置","kmMissive.tree.commonReceiveXformCfg":"收文表单数据映射设置","kmMissive.tree.sendUnit":"按发文机关","kmMissive.tree.mainMissiveSignFlow":"签报通用流程模板设置","kmMissive.tree.moduleConfig":"分类设置","kmMissive.tree.ExchangeUnit":"交换机关","kmMissive.tree.displayConfig.baseInfo":"展开稿纸信息","kmMissive.tree.sendStatus":"按状态","kmMissive.tree.commonReceiveXform":"收文通用表单模板","kmMissive.tree.sendConfig":"发文设置","kmMissive.tree.mainMissiveSendFlow":"发文通用流程模板设置","kmMissive.tree.commonSendXformCfg":"发文表单数据映射设置","kmMissive.tree.permissionDiffusionLog":"权限扩散日志","kmMissive.tree.sendMissive":"发文","kmMissive.tree.UnitGroup":"机关机构组设置","kmMissive.tree.xianBanRiQiSheZhi":"限办日期设置","kmMissive.tree.distribute":"分发记录查询","kmMissive.tree.commonSignXform":"签报通用表单模板","kmMissive.tree.receiveConfig":"收文设置","kmMissive.tree.displayConfig.content":"展开正文","kmMissive.tree.receiveMissive":"收文","kmMissive.tree.commonSignNumber":"签报通用编号规则","kmMissive.tree.sendToplatformDocumentQueue":"发往平台公文队列","kmMissive.tree.process":"按办理","kmMissive.tree.commonReceiveNumber":"收文通用编号规则","mobile.kmImissive.send":"发文","mobile.kmImissive.week":"本周","mobile.kmImissive.doneStat":"已处理公文统计","mobile.kmImissive.signedReport":"已审签报","mobile.kmImissive.postsReviewed":"已审发文","mobile.kmImissive.type":"类型","mobile.supplement":"补发","mobile.kmImissive.publishDate":"办结日期","mobile.kmImissive.receive":"收文","mobile.kmImissive.status.toSend":"待发送","mobile.kmImissive.status.signed":"已签收","mobile.kmImissive.deadline":"限办日期","mobile.kmImissive.status.noOpen":"待查阅","mobile.kmImissive.reviewedReceipts":"已审收文","mobile.recall":"撤回","mobile.kmImissive.status.waitSign":"待签收","mobile.kmImissive.status.returnDoc":"已退文","mobile.kmImissive.status.cancel":"已撤回","mobile.recall.success":"撤回成功！","mobile.kmImissive.year":"本年","mobile.approval":"待审","mobile.kmImissive.status":"状态","mobile.approved":"已审","mobile.remind":"催办","mobile.kmImissive.month":"本月","mobile.kmImissive.createTime":"创建时间","mobile.kmImissive.publishTime":"签发日期","mobile.kmImissive.status.return":"已退回"})}}});