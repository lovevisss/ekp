<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<div id='distributeRecordView' data-dojo-type="mui/tabbar/TabBarView">
	<div class="muiHeaderBasicInfo" data-dojo-type="mui/header/Header" fixed="top" data-dojo-props="height:'3.8rem'">
		<div class="muiHeaderBasicInfoTitle">分发记录</div>
		<div class="muiHeaderBasicInfoBack" onclick="backToDocView(this,'scrollView')">
			<i class="mui mui-close"></i>
		</div>
	</div>
	<div data-dojo-type="mui/list/StoreScrollableView">
	  	<ul data-dojo-type="mui/list/JsonStoreList" 
               data-dojo-mixins="km/imissive/mobile/resource/js/ImissiveNotClickItemList"
			data-dojo-props="url:'/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&deliver=true&fdMainId=${kmImissiveReceiveMainForm.fdId}&type=1&fdRegType=receive',lazy:false">
		</ul>
	</div>
	<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=distribute&fdId=${param.fdId}" requestMethod="GET">
		<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" id="optBar">
			<!-- 撤回 -->
		    <li data-dojo-type="mui/tabbar/TabBarButton" onclick="recall(this);">
				<bean:message bundle="km-imissive" key="mobile.recall"/>
			</li>
			<!-- 催办 -->
			 <li data-dojo-type="mui/tabbar/TabBarButton" onclick="remind(this);">
				<bean:message bundle="km-imissive" key="mobile.remind"/>
			</li>
			<!-- 补签 -->
			<li data-dojo-type="mui/tabbar/TabBarButton" onclick="distribute();">
				<bean:message bundle="km-imissive" key="mobile.supplement"/>
			</li>
		</ul>
	</kmss:auth>
</div>
<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=distribute&fdId=${param.fdId}" requestMethod="GET">
	<div id='recallView' data-dojo-type="mui/tabbar/TabBarView" class="optView">
		<div class="muiHeaderBasicInfo optHead" data-dojo-type="mui/header/Header" fixed="top" data-dojo-props="height:'3.8rem'">
			<div class="muiHeaderBasicInfoTitle">未签收记录</div>
			<div class="muiHeaderBasicInfoBack" onclick="backToDocView(this,'distributeRecordView')">
				<i class="mui mui-close"></i>
			</div>
		</div>
		<div data-dojo-type="mui/list/StoreScrollableView">
			 <div style="padding-left:1rem">
			    <div  data-dojo-type="mui/list/JsonStoreList" id="recallList" 
					data-dojo-mixins="${LUI_ContextPath}/km/imissive/mobile/resource/js/ImissiveOpinionItemListOptMixin.js"
					data-dojo-props="url:''">
				</div>
			</div>
		</div>
		<div class="muiHeaderBasicInfo optFoot" data-dojo-type="mui/header/Header" fixed="bottom" data-dojo-props="height:'3.8rem'">
			<div class="muiHeaderBasicInfoBack" onclick="selectAll(this,'recall')" >
				<div class="muiCateSelArea">
					<div class="muiCateSel muiCateSelMul">
						<i class="mui mui-checked muiCateSelected" style="display: none;"></i>
					</div>
				</div>
				全选
			</div>
			<div class="muiHeaderBasicInfoTitle" onclick="submit_recall(this)">确定撤回</div>
		</div>
	</div>
	<div id='remindView' data-dojo-type="mui/tabbar/TabBarView" class="optView">
		<div class="muiHeaderBasicInfo optHead" data-dojo-type="mui/header/Header" fixed="top" data-dojo-props="height:'3.8rem'">
			<div class="muiHeaderBasicInfoTitle">未签收记录</div>
			<div class="muiHeaderBasicInfoBack" onclick="backToDocView(this,'distributeRecordView')">
				<i class="mui mui-close"></i>
			</div>
		</div>
		<div data-dojo-type="mui/list/StoreScrollableView">
			 <div style="padding-left:1rem">
			    <div  data-dojo-type="mui/list/JsonStoreList" id="remindList" 
					data-dojo-mixins="${LUI_ContextPath}/km/imissive/mobile/resource/js/ImissiveOpinionItemListOptMixin.js"
					data-dojo-props="url:''">
				</div>
			</div>
		</div>
		<div class="muiHeaderBasicInfo optFoot" data-dojo-type="mui/header/Header" fixed="bottom" data-dojo-props="height:'3.8rem'">
			<div class="muiHeaderBasicInfoBack" onclick="selectAll(this,'remind');">
				<div class="muiCateSelArea">
					<div class="muiCateSel muiCateSelMul">
						<i class="mui mui-checked muiCateSelected" style="display: none;"></i>
					</div>
				</div>
				全选
			</div>
			<div class="muiHeaderBasicInfoTitle" onclick="submit_remind(this)">确定提醒</div>
		</div>
	</div>
</kmss:auth>
<div id='reportRecordView' data-dojo-type="dojox/mobile/View">
	<div class="muiHeaderBasicInfo" data-dojo-type="mui/header/Header" fixed="top" data-dojo-props="height:'3.8rem'">
		<div class="muiHeaderBasicInfoTitle">上报记录</div>
		<div class="muiHeaderBasicInfoBack" onclick="backToDocView(this,'scrollView')">
			<i class="mui mui-close"></i>
		</div>
	</div>
	<div data-dojo-type="mui/list/StoreScrollableView">
	  	<ul data-dojo-type="mui/list/JsonStoreList" 
               data-dojo-mixins="km/imissive/mobile/resource/js/ImissiveNotClickItemList"
			data-dojo-props="url:'/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&deliver=true&fdMainId=${kmImissiveReceiveMainForm.fdId}&type=2&fdRegType=receive',lazy:false">
		</ul>
	</div>
</div>
<div id='opinionView' data-dojo-type="dojox/mobile/View">
	<div class="muiHeaderBasicInfo" data-dojo-type="mui/header/Header" fixed="top" data-dojo-props="height:'3.8rem'">
		<div class="muiHeaderBasicInfoTitle">传阅意见</div>
		<div class="muiHeaderBasicInfoBack" onclick="backToDocView(this,'scrollView')">
			<i class="mui mui-close"></i>
		</div>
	</div>
	<div data-dojo-type="mui/list/StoreScrollableView">
		<ul
	    	data-dojo-type="mui/list/JsonStoreList"
	    	data-dojo-mixins="mui/list/ProcessItemListMixin"
	    	data-dojo-props="url:'/sys/circulation/sys_circulation_opinion/sysCirculationOpinion.do?method=list&fdModelId=${kmImissiveReceiveMainForm.fdId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&isOpinion=true',lazy:false">
		</ul>
	</div>
</div>
<script>
	require(["mui/dialog/BarTip", "dojo/ready"], function(BarTip, ready) {
		ready(function() {
			if("${_isWpsCloudEnable}" != 'true' && "${_isWpsCenterEnable}" != 'true'){
				<c:if  test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true'}">
					BarTip.tip({text: '移动设备不支持编号功能，建议使用电脑操作'});
				</c:if>
			}
		}); 
	});
</script>
<script type="text/javascript" >
require(['dojo/topic',
         'dojo/ready',
         'dijit/registry',
         'dojox/mobile/TransitionEvent',
         'mui/device/adapter',
         "dojo/_base/lang",
         "mui/dialog/Tip"
         ],function(topic,ready,registry,TransitionEvent,adapter,lang,Tip){
		
		//返回主视图
		window.backToDocView=function(obj,view){
			var opts = {
				transition : 'slide',
				transitionDir:-1,
				moveTo:view
			};
			new TransitionEvent(obj, opts).dispatch();
			
		};
	
		window.circulate = function(){
			var url = Com_GetCurDnsHost()+Com_Parameter.ContextPath+'sys/circulation/sys_circulation_opinion/sysCirculationOpinion.do?method=edit&fdModelId=${kmImissiveReceiveMainForm.fdId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain';
			window.open(url,"_self");
		};
		
		window.Com_submitReview= function(){
			Com_Submit(document.kmImissiveReceiveMainForm, 'approveReceive');
			var docNum = document.getElementsByName("fdReceiveNum")[0];
		 	if(fdBufferNumId !=""){
			    	getTempNumberFromDb(fdBufferNumId,"com.landray.kmss.km.imissive.model.KmImissiveReceiveMain").then(lang.hitch(this, function(data) { 
					 var results =  eval("("+data+")");
					 if(results['docNum']!=null){
						var docBufferNum =results['docNum'];
						if(docBufferNum){
						    	var docBufferNumArr = decodeURI(docBufferNum).split("#");
						    	if(docNum.value == formatNum(docBufferNumArr[0],docBufferNumArr[1])|| fdFlowNo.value > docBufferNumArr[1]){
						    		delTempNumFromDb(fdBufferNumId,decodeURI(docBufferNum));
						    	}
						 }
					 }
				}));
 			 }
		};
		
		window.yqq=function(key){
			 var fileTypeUrl = Com_Parameter.ContextPath+"km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=validateReceiveFileType&signId=${param.fdId}";
			 var queryStatusUrl = Com_Parameter.ContextPath+"km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryStatus&signId=${param.fdId}";
			 var validateOnceUrl = Com_Parameter.ContextPath+"km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=validateOnce&signId=${param.fdId}";
			 $.ajax({
					url : fileTypeUrl,
					type : 'post',
					data : {},
					dataType : 'text',
					async : true,     
					error : function(){
						Tip.tip({icon:'mui mui-warn', text:'请求出错',width:'180',height:'60'});
					} ,   
					success:function(data){
						if(data == "true"){
							 $.ajax({
									url : queryStatusUrl,
									type : 'post',
									data : {},
									dataType : 'text',
									async : true,     
									error : function(){
										Tip.tip({icon:'mui mui-warn', text:'请求出错',width:'180',height:'60'});
									} ,   
									success : function(data) {
										if(data == "false"){
											$.ajax({
												url : validateOnceUrl,
												type : 'post',
												data : {},
												dataType : 'text',
												async : true,     
												error : function(){
													Tip.tip({icon:'mui mui-warn', text:'请求出错',width:'180',height:'60'});
												} ,   
												success:function(data){
													if(data == "true"){
														Tip.tip({icon:'mui mui-warn', text:'当前发文已经发送过易企签签署，整个签署事件未完成，请等待完成后在发起签署！！',width:'180',height:'60'});
													}else{
														var obj_ = document.getElementById("JGWebOffice_"+key);
													    if(obj_){
															if(Attachment_ObjectInfo[key]){
																 if(Attachment_ObjectInfo[key].ocxObj){
																	 var rFlag=Attachment_ObjectInfo[key].ocxObj.WebSave();
																	 if(rFlag){
																		 var infoUrl = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=openYqqExtendInfo&signId=${param.fdId}";
																		 window.open(infoUrl,"_self");
																	 }
																 }
															}
													    }else{
													    	var infoUrl = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=openYqqExtendInfo&signId=${param.fdId}";
													    	window.open(infoUrl,"_self");
													    }
													}
												}
											});
										}else{
											window.open(data,"_self");
										}
									}
								}); 
						}else{
							Tip.tip({icon:'mui mui-warn', text:'不支持文件类型('+data+')签署，请上传以下文件类型(.pdf;.doc;.xls;.ppt;.docx;.xlsx;.pptx;.jpg;.png;.jpeg;)',width:'300',height:'160'});
						}
					}
				});
		};
		
		//正文阅读
		window.imissiveViewer = function(){
			var type = "${_sysAttMain.fdContentType}";
			var href = '${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${_sysAttMain.fdId}&viewer=mobilehtmlviewer';
			var downLoadUrl = "${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${_sysAttMain.fdId}";
			var hasViewer = "${hasViewer }";
			if(hasViewer !='true' && type !='img'){
				href = downLoadUrl;
			}
			window.location.href=href;
		}
	});
</script>
<script>
require(["mui/dialog/BarTip", "dojo/ready"], function(BarTip, ready) {
	window.distribute = function(){
		var url = Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/imissive/km_imissive_receive_dr/kmImissiveReceiveDR.do?method=distribute&mobile=true&fdMainId=${param.fdId}';
		window.open(url,"_self");
	};
	window.report = function(){
		var url = Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/imissive/km_imissive_receive_dr/kmImissiveReceiveDR.do?method=report&mobile=true&fdMainId=${param.fdId}';
		window.open(url,"_self");
	};
});
</script>
<script>
	require(["dojo/parser", 
		"dojo/ready",
		"dojo/dom",
		"dijit/registry",
		"dojo/_base/lang",
		"dojox/mobile/TransitionEvent",
		"dojo/query",
		"dojo/dom-style",
		"dojo/dom-attr" ,
		"dojo/dom-class", 
		"dojo/request",
		"mui/util",
		"mui/dialog/Tip"], function(parser, ready, dom, registry,lang, TransitionEvent, query, domStyle, domAttr, domClass, req, util, Tip){
		
		// 若无分发记录隐藏撤回、提醒、补签操作栏
		ready(function(){
			req(util.formatUrl("/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=checkListIsEmpty&deliver=true&fdMainId=${kmImissiveReceiveMainForm.fdId}&type=1&fdRegType=receive"), {
				method : 'post',
				data : {}
			}).then(function(data){
				data = eval('(' + data + ')');
				if (data.result == "true") {
					var optBar = query('#optBar')[0];
					domStyle.set(optBar,'display','none');
				}
			})
		})
		
		window.recall = function(obj){
			url = Com_GetCurDnsHost() + Com_Parameter.ContextPath + "/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&deliver=true&fdMainId=${kmImissiveReceiveMainForm.fdId}&type=1&fdRegType=receive&waitSign=true";
			registry.byId("recallList").set('url',url);
			var opts = {
				transition : 'slide',
				transitionDir:1,
				moveTo:'recallView'
			};
			new TransitionEvent(obj.domNode, opts).dispatch();
			registry.byId("recallList").reload();
		};
		
		window.remind = function(obj){
			url = Com_GetCurDnsHost() + Com_Parameter.ContextPath + "/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&deliver=true&fdMainId=${kmImissiveReceiveMainForm.fdId}&type=1&fdRegType=receive&waitSign=true";
			registry.byId("remindList").set('url',url);
			var opts = {
				transition : 'slide',
				transitionDir:1,
				moveTo:'remindView'
			};
			new TransitionEvent(obj.domNode, opts).dispatch();
			registry.byId("remindList").reload();
		};
		
		window.selectAll = function(obj,type){
			var opt = query('.muiCateSelected',obj)[0];
			var status = domStyle.get(opt,'display');
			var optList = document.getElementById(type+'List');
			var checkboxObj = query('.muiCateSel',optList);
			if(status == 'none'){
				domStyle.set(opt,'display','');
				domClass.add(query('.muiCateSel',obj)[0],"muiCateSeled");
				for(var i = 0; i < checkboxObj.length; i++){
					var aa = query('.muiCateSelected',checkboxObj[i])[0];
					domStyle.set(aa,'display','');
					domClass.add(checkboxObj[i],"muiCateSeled");
				}
			}else{
				domStyle.set(opt,'display','none');
				domClass.remove(query('.muiCateSel',obj)[0],"muiCateSeled");
				for(var i = 0; i < checkboxObj.length; i++){
					var aa = query('.muiCateSelected',checkboxObj[i])[0];
					domStyle.set(aa,'display','none');
					domClass.remove(checkboxObj[i],"muiCateSeled");
				}
			}
		};
		
		window.submit_recall = function(obj){
			var list = [];
			var selectObj = query('.muiCateSeled', document.getElementById('recallList'));
			for(var i = 0; i < selectObj.length; i++){
				list.push(selectObj[i].value);
			}
			if(list.length > 0){
				 req(util.formatUrl("/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=cancelListDR"), {
						method : 'post',
						data : {"fdIds":list}
				}).then(lang.hitch(this, function(results) {
					backToDocView(obj,'distributeRecordView');
					Tip.success({
						text : '撤回成功！'
					});
				}));
			}else{
				Tip.tip({icon:'mui mui-warn', text:'请选择操作的记录！',width:'180',height:'60'});
			}
		};
		
		window.submit_remind = function(obj){
			var list = [];
			var selectObj = query('.muiCateSeled', document.getElementById('remindList'));
			for(var i = 0; i < selectObj.length; i++){
				list.push(selectObj[i].value);
			}
			if(list.length > 0){
				 req(util.formatUrl("/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=addUrgeSign"), {
						method : 'post',
						data : {"List_Selected":list}
				}).then(lang.hitch(this, function(results) {
					backToDocView(obj,'distributeRecordView');
					Tip.success({
						text : '催办成功！'
					});
				}));
			}else{
				Tip.tip({icon:'mui mui-warn', text:'请选择操作的记录！',width:'180',height:'60'});
			}
		};
	})
</script>