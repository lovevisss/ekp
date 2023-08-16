require({cache:{"km/archives/mobile/resource/js/ArchSelection":function(){define(["dojo/_base/declare","mui/iconUtils","dojo/_base/array","mui/category/CategorySelection","dojo/topic","dojo/_base/lang"],function(b,d,g,e,a,f){var c=b("km.archives.mobile.js.ArchSelection",[e],{_initSelection:function(){var h=this;a.publish("km/archives/selectedarch/get",function(i){g.forEach(i||[],function(j){h._addSelItme(h,f.mixin(j,{label:j.title}))})})},buildIcon:function(h,i){d.setIcon("mui mui-file-text",null,null,null,h)},_calcCurSel:function(){return this.cateSelArr}});return c})},"km/archives/mobile/resource/js/util":function(){define(function(){return{htmlEncode:function(c){var b=document.createElement("div");(b.textContent!=undefined)?(b.textContent=c):(b.innerText=c);var a=b.innerHTML;b=null;return a},htmlDecode:function(c){var b=document.createElement("div");b.innerHTML=c;var a=b.innerText||b.textContent;b=null;return a},htmlEncodeByRegExp:function(b){var a="";if(b.length==0){return""}a=b.replace(/&/g,"&amp;");a=a.replace(/</g,"&lt;");a=a.replace(/>/g,"&gt;");a=a.replace(/ /g,"&nbsp;");a=a.replace(/\'/g,"&#39;");a=a.replace(/\"/g,"&quot;");return a},htmlDecodeByRegExp:function(b){var a="";if(b.length==0){return""}a=b.replace(/&amp;/g,"&");a=a.replace(/&lt;/g,"<");a=a.replace(/&gt;/g,">");a=a.replace(/&nbsp;/g," ");a=a.replace(/&#39;/g,"'");a=a.replace(/&quot;/g,'"');return a}}})},"km/archives/mobile/resource/js/ArchivesSelectorButton":function(){define(["dojo/_base/declare","dojox/mobile/Button","dojo/query","mui/dialog/Tip","mui/form/_CategoryBase","dojox/mobile/sniff"],function(e,b,f,d,a,c){return e("km.archives.mobile.js.ArchivesSelectorButton",[b,a],{key:"_archSelect",buildRendering:function(){this.inherited(arguments);this.domNode.dojoClick=!c("ios")},postCreate:function(){this.inherited(arguments);this.eventBind()},_onClick:function(g){var i=f("input[name='docTemplateId']")[0];if(i&&i.value){this.defer(function(){this._selectCate()},350)}else{var h="请先选择借阅流程！";d.tip({text:h,icon:"mui mui-warn"})}}})})},"km/archives/mobile/resource/js/ArchSelectorListItem":function(){define(["dojo/_base/declare","dijit/_WidgetBase","dijit/_Contained","dijit/_Container","dojo/window","dojo/_base/array","dojo/dom-style","dojo/dom-class","dojo/dom-construct","dojo/dom-attr","dojo/topic","dojo/on","dojo/request","dojo/touch"],function(e,c,n,a,g,j,h,l,m,k,f,i,b,d){return e("km.archives.mobile.js.ArchSelectorListItem",[c,n,a],{tagName:"li",TYPE_ARCH:0,TYPE_CAT:1,isMul:false,type:"",fdId:"",text:"",postCreate:function(){this.inherited(arguments);this.bindEvents()},buildRendering:function(){this.domNode=m.create(this.tagName,{className:"muiCateItem"});k.set(this.domNode,"data-id",this.fdId);k.set(this.domNode,"data-type",this.type);k.set(this.domNode,"data-text",this.text);this.renderItem()},bindEvents:function(){},renderItem:function(){var o=this;var q=m.create("div",{className:"muiCateInfoItem"},o.domNode);var p=m.create("div",{className:"muiCateContainer"},q);if(o.type==o.TYPE_ARCH){m.create("div",{className:"muiCateSelArea",innerHTML:'<div class="muiCateSel'+(o.isMul?" muiCateSelMul":"")+'"></div>'},p)}m.create("div",{className:"muiCateInfo",innerHTML:'<div class="muiCateName">'+o.text+"</div>"},p);if(o.type==o.TYPE_CAT){m.create("div",{className:"muiCateMore",innerHTML:'<i class="mui mui-forward"></i>'},p)}}})})},"km/archives/mobile/resource/js/SimpleItemList":function(){define(["dojo/_base/declare","dojo/_base/lang","dojo/_base/array","dojo/topic","dojo/request","dojo/on","dojo/dom","dojo/dom-construct","dojo/dom-style","dojo/dom-class","dijit/_WidgetBase","dijit/_Container","dijit/_Contained","dojox/mobile/_ItemBase"],function(g,a,j,h,f,k,e,o,i,m,d,c,n,l){var b=g("km.archives.mobile.js.SimpleItemList",[l],{buildRendering:function(){var p=this;p.inherited(arguments);m.add(p.domNode,"muiCateInfoItem");var q=o.create("div",{className:"muiCateContainer",innerHTML:'					<div class="muiCateSelArea"> 						<div class="muiCateSel" />         			</div>'},p.domNode);o.create("div",{className:"muiCateInfo",innerHTML:'<div class="muiCateName">'+p.data.fdName+"</div>"},q);if(p.url){k(p.domNode,"click",function(){location.href=p.url;m.add(p.domNode,"muiCateSeled")})}}});return g("mui.list.SimpleItemList",[d,c,n],{itemRenderer:b,url:"",redirectUrl:"",method:"post",handleAs:"json",postCreate:function(){m.add(this.domNode,"muiCateLists");this.loadData()},loadData:function(){var p=this;if(!p.url){return}f(p.url,{method:p.method,handleAs:p.handleAs}).then(function(q){p.onComplete(q)},function(q){p.onError(q)})},onComplete:function(p){h.publish("/mui/list/simple/loaded",p);this.generateList(p)},onError:function(p){console.error(p)},generateList:function(r){var p=this;if(!r||r.length<=0){var q=o.create("div",{className:"muiListNoDataArea",innerHTML:' 						<div class="muiListNoDataInnerArea"> 							<div class="muiListNoDataContainer muiListNoDataIcon"> 							<i class="mui mui-message"></i></div> 							</div> 						<div class="muiListNoDataTxt"> 							暂无内容 						</div> 					'},p.domNode)}else{j.forEach(r,function(t,s){var u=o.create("li",{className:"muiCateItem"},p.domNode);new p.itemRenderer({data:t,url:a.replace(p.redirectUrl,t)}).placeAt(u)})}}})})},"km/archives/mobile/resource/js/TextItemListMixin":function(){define(["dojo/_base/declare","mui/list/_TemplateItemListMixin","km/archives/mobile/resource/js/TextItemMixin"],function(a,c,b){return a("km.archives.TextItemListMixin",[c],{itemTemplateString:null,itemRenderer:b})})},"km/archives/mobile/resource/js/ArchivesSelectorMixin":function(){define(["dojo/_base/declare"],function(a){return a("km.archives.mobile.js.ArchivesSelectorMixin",null,{templURL:"/km/archives/mobile/resource/tmpl/archselector.jsp",fdTemplatId:"",postCreate:function(){this.inherited(arguments);if(this.isMul){this.templURL="/km/archives/mobile/resource/tmpl/archselector_mul.jsp"}this.templURL+="?fdTemplatId="+this.fdTemplatId}})})},"km/archives/mobile/resource/js/SelectArchMixin":function(){define(["dojo/_base/declare","dojo/_base/lang","dojo/_base/array","dojo/dom","dojo/dom-attr","dojo/dom-style","dojo/query","dijit/registry","mui/form/_ValidateMixin"],function(d,b,f,c,g,e,h,a,i){return d("km.archives.mobile.js.SelectArchMixin",[i],{validate:function(k){var j=true;if(h(".selectedArchRow").length<1){e.set(c.byId("selectArchTips"),"display","block");j=false}else{e.set(c.byId("selectArchTips"),"display","none")}return this.inherited(arguments)&&j}})})},"km/archives/mobile/resource/js/ArchivesTable":function(){define(["dojo/_base/declare","dojo/_base/lang","dojo/parser","dijit/_WidgetBase","dijit/_Contained","dijit/_Container","dojo/window","dojo/dom","dojo/_base/array","dojo/dom-style","dojo/dom-class","dojo/dom-construct","dojo/query","dojo/topic","dojo/on","dojo/request","dojo/touch","mui/dialog/Tip","dojo/mouse","dojo/dom-attr","./util","mui/i18n/_i18n!km/archives/mobile/resource/js/mui-cusledger-list"],function(t,v,c,q,u,m,e,p,h,n,i,b,f,o,j,d,g,r,k,s,a,l){return t("km.archives.mobile.js.ArchivesTable",[q,u,m],{selectedArchs:[],postCreate:function(){this.inherited(arguments);this.tbody=this.domNode.getElementsByTagName("tbody")[0];this.bindEvents()},bindEvents:function(){var w=this;o.subscribe("km/archives/selectedarch/get",function(x){x&&x(w.selectedArchs)});o.subscribe("km/archives/selectedarch/init",function(x){w.selectedArchs=x;w.renderselectedArchs()});o.subscribe("km/archives/selectedarch/res",function(z){var D=0,A=0,y=(w.selectedArchs||[]).length,C=(z||[]).length,B=[];for(D;D<y;D++){for(A;A<C;A++){if(w.selectedArchs[D].fdId==z[A].fdId){B.push(w.selectedArchs[D]);break}}}for(D=0;D<C;D++){var x=true;var E=z[D];for(A=0;A<y;A++){if(E.fdId==w.selectedArchs[A].fdId){x=false;break}}if(x){B.push({fdId:E.fdId,fdBorrowerId:f("[name='fdBorrowerId']")[0].value,fdStatus:"0",title:E.title,categoryName:E.categoryName,fdValidityDate:E.fdValidityDate!=""?E.fdValidityDate:l["mui.kmArchivesMain.fdValidityDate.forever"],fdAuthorityRange:E.fdDefaultRange,fdReturnDate:""})}}w.selectedArchs=B;w.renderselectedArchs()});o.subscribe("km/archives/selectedarch/add",function(z){var y,x=w.selectedArchs.length;for(y=0;y<x;y++){if(w.selectedArchs[y].fdId==z.fdId){r.fail({text:"已选取档案"});return}}w.selectedArchs.push({fdId:z.fdId,fdBorrowerId:f("[name='fdBorrowerId']")[0].value,fdStatus:"0",title:z.title,categoryName:z.categoryName,fdValidityDate:z.fdValidityDate!=""?z.fdValidityDate:l["mui.kmArchivesMain.fdValidityDate.forever"],fdAuthorityRange:z.fdDefaultRange,fdReturnDate:""});w.renderselectedArchs()});o.subscribe("km/archives/selectedarch/remove",function(x){w.selectedArchs.splice(x,1);w.renderselectedArchs()})},renderselectedArchs:function(){var w=this;h.forEach(f(".selectedArchRow"),function(y,x){y.remove()});h.forEach(w.selectedArchs,function(A,D){var E=b.create("tr",{className:"selectedArchRow"},w.tbody);var B=b.create("td",{innerHTML:D+1},E);b.create("input",{type:"hidden",value:A.fdId,name:"fdBorrowDetail_Form["+D+"].fdArchId"},B);var F=b.create("input",{type:"hidden",value:A.fdBorrowerId,name:"fdBorrowDetail_Form["+D+"].fdBorrowerId"},B);i.add(F,"detailBorrows");b.create("input",{type:"hidden",value:A.fdStatus,name:"fdBorrowDetail_Form["+D+"].fdStatus"},B);var y=b.create("td",{innerHTML:'<a style="color:#007aff; font-size: 1.4rem;">'+a.htmlDecode(A.title)+"</a>"},E);j(y,"click",function(){window.location.href=dojoConfig.baseUrl+"km/archives/km_archives_main/kmArchivesMain.do?method=view&fdId="+A.fdId+"&_mobile=1"});b.create("td",{innerHTML:a.htmlDecode(A.categoryName)},E);b.create("td",{innerHTML:A.fdValidityDate},E);var z=b.create("td",{style:"padding: 0.6rem 1rem; text-align: left;"},E);w.generateCheckBoxGroup(z,"fdBorrowDetail_Form["+D+"].fdAuthorityRange",A.fdAuthorityRange);var C=b.create("td",{},E);w.generateDateTime(C,"fdBorrowDetail_Form["+D+"].fdReturnDate",A.fdReturnDate,A.fdValidityDate);var x=b.create("td",{},E);b.create("span",{className:"selectedArchRowAction_remove",innerHTML:"&times;"},x);j(x,"click",function(){o.publish("km/archives/selectedarch/remove",D)})});c.parse(w.tbody).then(function(x){o.publish("/mui/list/resize")})},generateCheckBoxGroup:function(w,z,A){var y=[];var C={text:l["mui.kmArchivesConfig.fdDefaultRange.copy"],value:"copy"};var x={text:l["mui.kmArchivesConfig.fdDefaultRange.download"],value:"download"};var B={text:l["mui.kmArchivesConfig.fdDefaultRange.print"],value:"print"};if(typeof(A)!="undefined"&&A!=""){if(A.indexOf("copy")>-1){C.checked=true}if(A.indexOf("download")>-1){x.checked=true}if(A.indexOf("print")>-1){B.checked=true}}y.push(C);y.push(x);y.push(B);y=JSON.stringify(y);b.create("div",{"data-dojo-type":"mui/form/CheckBoxGroup","class":"authorityRange","data-dojo-props":v.replace('edit:"{edit}",name:"{name}",value:"{value}",store:{store}',{edit:"true",name:z,value:A,store:y})},w)},generateDateTime:function(w,y,z,x){if(x=="永久"){x=""}b.create("div",{"data-dojo-type":"mui/form/DateTime","data-dojo-mixins":"mui/datetime/_DateTimeMixin","data-dojo-props":v.replace('valueField:"{valueField}",name:"{name}",value:"{value}",required:{required},validate:"{validate}",subject:"{subject}"',{valueField:y,name:y,value:z,required:true,validate:"required datetime after returnDateValidator("+x+")",subject:l["mui.kmArchivesDetails.fdReturnDate"]})},w)}})})},"km/archives/mobile/resource/js/TextItemMixin":function(){define(["dojo/_base/declare","dojo/dom-construct","dojo/dom-style","dojo/dom-attr","mui/util","dojo/on","mui/dialog/Tip","mui/list/item/TextItemMixin","mui/i18n/_i18n!km/archives/mobile/resource/js/mui-cusledger-list"],function(c,b,f,h,d,g,i,e,a){var j=c("kms.lecturer.TextItemMixin",[e],{buildInternalRender:function(){if(this.docSubject){this.muiTextItemTitle=b.create("div",{className:"muiTextItemTitle muiFontSizeM"},this.domNode);this.buildTag(this.muiTextItemTitle);this.muiTextItemTitle.innerHTML=this.muiTextItemTitle.innerHTML+this.docSubject}this.messageDomNode=b.create("ul",{className:"muiTextItemInfo"});if(this["docCreator.fdName"]){b.create("li",{innerHTML:this["docCreator.fdName"]},this.messageDomNode);this.buildMessage=true}if(this.docCreateTime){b.create("li",{innerHTML:this.docCreateTime},this.messageDomNode);this.buildMessage=true}else{if(this.fdFileDate){b.create("li",{innerHTML:this.fdFileDate},this.messageDomNode);this.buildMessage=true}}b.place(this.messageDomNode,this.domNode,"last");if(!this.href){this.makeLockLinkTip(this.domNode)}},makeLockLinkTip:function(k){this.href="javascript:void(0);";g(k,"click",function(l){i.tip({icon:"mui mui-warn",text:a["mobile.tips.viewOnPhone"]})})},buildTag:function(k){this.inherited(arguments);if(this.docStatus&&k){this.formatStatusData();b.create("span",{className:this.tagClass+this.statusClass,innerHTML:this.docStatus},k)}},formatStatusData:function(){if(this.docStatus){if("00"==this.docStatus){this.docStatus=a["mobile.enums.doc_status.00"];this.statusClass=" muiProcessDiscard"}else{if("10"==this.docStatus){this.docStatus=a["mobile.enums.doc_status.10"];this.statusClass=" muiProcessDraft"}else{if("11"==this.docStatus){this.docStatus=a["mobile.enums.doc_status.11"];this.statusClass=" muiProcessRefuse"}else{if("20"==this.docStatus){this.docStatus=a["mobile.enums.doc_status.20"];this.statusClass=" muiProcessExamine"}else{if("30"==this.docStatus){this.docStatus=a["mobile.enums.doc_status.30"];this.statusClass=" muiProcessPublish"}else{if("31"==this.docStatus){this.docStatus=a["mobile.enums.doc_status.31"];this.statusClass=" muiProcessPublish"}}}}}}}}});return j})},"km/archives/mobile/resource/js/ArchSelector":function(){define(["dojo/_base/declare","dojox/mobile/_ItemBase","dojo/_base/lang","dojo/_base/array","dojo/_base/config","dojo/window","dojo/dom","dojo/_base/array","dojo/dom-style","dojo/dom-attr","dojo/dom-class","dojo/dom-construct","dojo/query","dojo/topic","dojo/on","dojo/request","dojo/touch","./ArchSelectorListItem","./util"],function(o,c,r,h,q,e,m,h,k,n,i,b,f,l,j,d,g,p,a){return o("km.archives.mobile.js.ArchSelector",[c],{key:"",itemRenderer:p,TYPE_ARCH:0,TYPE_CAT:1,isMul:false,catList:[],archList:[],fdTemplatId:"",selectedArchs:{},catDataUrl:"sys/category/mobile/sysSimpleCategory.do?method=cateList&categoryId={categoryId}&getTemplate=0&modelName=com.landray.kmss.km.archives.model.KmArchivesCategory&authType=00",archDataUrl:"km/archives/km_archives_borrow/kmArchBorrowOption.do?method=checkArchList&categoryId={categoryId}",postCreate:function(){var s=this;s.inherited(arguments);s.initialize()},initialize:function(){var s=this;s.catList=[];s.selectedArchs={};l.publish("km/archives/selectedarch/get",function(t){h.forEach(t,function(u){s.selectedArchs[u.fdId]=true})});s.title=m.byId("archSelectorTitle");s.preBtn=m.byId("archSelectorPreBtn");s.cancelBtn=m.byId("archSelectorCalBtn");s.bindEvents();s.loadData()},bindEvents:function(){var s=this;j(s.cancelBtn,g.press,function(t){l.publish("/mui/category/cancel",{key:"_archSelect"})});j(s.preBtn,g.press,function(v){s.catList.pop();if(s.catList.length<1){k.set(s.preBtn,"display","none");s.title.innerHTML="请选择";s.loadData()}else{var u=s.catList[s.catList.length-1];s.title.innerHTML=u.text;s.loadData(u.id)}});j(s.domNode,j.selector(".muiCateItem","click"),function(v){v.stopPropagation();v.cancelBubble=true;v.preventDefault();v.returnValue=false;var u=f(v.target).closest(".muiCateItem")[0];if(u){var t=n.get(u,"data-type");var x=n.get(u,"data-id");var w=n.get(u,"data-text");if(t==s.TYPE_CAT){s.catList.push({id:x,text:w});s.title.innerHTML=w;k.set(s.preBtn,"display","block");s.loadData(x)}else{if(t==s.TYPE_ARCH){h.forEach(s.archList,function(y){if(y.fdId==x){if(s.isMul){if(i.contains(u,"muiCateSeled")){i.remove(u,"muiCateSeled");s.selectedArchs[y.arch.fdId]=false;l.publish("/mui/category/unselected",s,r.mixin(y.arch,{label:y.arch.title}))}else{i.add(u,"muiCateSeled");s.selectedArchs[y.arch.fdId]=true;l.publish("/mui/category/selected",s,r.mixin(y.arch,{label:y.arch.title}))}}else{if(s.selectedArchs[y.arch.fdId]){return}i.add(u,"muiCateSeled");l.publish("km/archives/archselector/result",y.arch);l.publish("/mui/category/cancel",{key:"_archSelect"})}}})}}}});l.subscribe("/mui/category/cancelSelected",function(t,v){if(s.key!=t.key){return}var u=f('.muiCateItem[data-id="'+v.fdId+'"]');s.selectedArchs[v.fdId]=false;if(u[0]){i.remove(u[0],"muiCateSeled")}});l.subscribe("/mui/category/submit",function(u,t){if(s.key!=u.key){return}l.publish("km/archives/archselector/result",t)})},loadData:function(t){var s=this;b.empty(s.domNode);d.post(q.baseUrl+r.replace(s.catDataUrl,{categoryId:t||""}),{handleAs:"json"}).then(function(v){var u=[];h.forEach(v,function(w){u.push({type:s.TYPE_CAT,fdId:w.value,text:a.htmlEncodeByRegExp(w.text)})});s.renderData(u);l.publish("/mui/list/loaded",s,u)});if(t){d.post(q.baseUrl+r.replace(s.archDataUrl,{categoryId:t||""}),{handleAs:"json",data:{rowsize:999999,fdTemplatId:this.fdTemplatId}}).then(function(v){var u=[];h.forEach(v.datas,function(x){var w={};h.forEach(x,function(y){w[y.col]=y.value});u.push({type:s.TYPE_ARCH,fdId:w.fdId,text:a.htmlDecode(w.title),arch:w})});s.archList=u;s.renderData(u)})}},renderData:function(t){var s=this;h.forEach(t,function(w,u){var v=new s.itemRenderer(r.mixin(w,{isMul:s.isMul}));if(s.selectedArchs[w.fdId]){i.add(v.domNode,"muiCateSeled")}v.placeAt(s.domNode)})}})})}}});