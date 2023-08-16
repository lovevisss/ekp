<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	  <list:criteria id="sendCriteria">
	        <list:cri-ref key="docSubject" ref="criterion.sys.docSubject"> 
			</list:cri-ref>
			<list:cri-ref ref="criterion.sys.category" key="fdTemplate" multi="false" title="${ lfn:message('km-imissive:kmImissiveSendMain.criteria.fdTemplate') }" expand="false">
			  <list:varParams modelName="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate"/>
			</list:cri-ref>
			<%-- <list:cri-criterion title="${ lfn:message('km-imissive:kmImissiveSendMain.Send.my') }" key="mydoc" multi="false">
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('km-imissive:kmImissive.tree.create.my') }', value:'create'},{text:'${ lfn:message('km-imissive:kmImissive.tree.myapproval') }',value:'approval'}, {text:'${ lfn:message('km-imissive:kmImissive.tree.myapproved') }', value: 'approved'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion> --%>
			<list:cri-criterion title="${ lfn:message('km-imissive:kmImissiveSendMain.docStatus')}" key="docStatus"> 
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('status.draft')}', value:'10'},{text:'${ lfn:message('status.examine')}',value:'20'},{text:'${ lfn:message('km-imissive:kmImissive.status.refuse')}',value:'11'},{text:'${ lfn:message('status.discard')}',value:'00'},{text:'${ lfn:message('km-imissive:kmImissive.status.publish')}',value:'30'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:cri-criterion title="${ lfn:message('km-imissive:kmImissiveSendMain.fdSendtoDept')}" key="SendtoUnit">
		      <list:box-select> 
		        <list:item-select type="lui/criteria/criterion_input!TextInput"> 
		        <ui:source type="Static">
		           [{placeholder:'${ lfn:message('km-imissive:kmImissiveSendMain.fdSendtoDept')}'}]
		        </ui:source>
		        </list:item-select>
		      </list:box-select>
		    </list:cri-criterion>
			<list:cri-auto modelName="com.landray.kmss.km.imissive.model.KmImissiveSendMain" property="fdDocNum;fdDrafter;fdDraftTime;docPublishTime;fdIsFiling" />
		</list:criteria>
		<div class="lui_list_operation">
			<div style='color: #979797;float: left;padding-top:1px;'> 
						${ lfn:message('list.orderType') }：
					</div>
					<div style="float:left">
						<div style="display: inline-block;vertical-align: middle;">
							<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
								<list:sortgroup>
									<list:sort property="docCreateTime" text="${lfn:message('km-imissive:kmImissiveSendMain.docCreateTime')}" group="sort.list"></list:sort>
									<list:sort property="docPublishTime" text="${lfn:message('km-imissive:kmImissiveSendMain.docPublishTime')}" group="sort.list"></list:sort>
								    <list:sort property="fdDocNum" text="${lfn:message('km-imissive:kmImissiveSendMain.fdDocNum')}" group="sort.list"></list:sort>
							    </list:sortgroup>
							</ui:toolbar>
						</div>
					</div>
					<div style="float:left;">	
						<list:paging layout="sys.ui.paging.top" > 		
						</list:paging>
					</div>	
					<div style="float:right">
						<div style="display: inline-block;vertical-align: middle;">
						<ui:toolbar count="3" id="Btntoolbar">
							<%-- 收藏 --%>
							<c:import url="/sys/bookmark/import/bookmark_bar_all.jsp" charEncoding="UTF-8">
								<c:param name="fdTitleProName" value="docSubject" />
								<c:param name="fdModelName"	value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
							</c:import>
							<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE">
								<ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2"></ui:button>	
							</kmss:authShow>
							<ui:button text="查看编号" onclick="showNumber()" order="2"></ui:button>
							<kmss:authShow roles="ROLE_KMIMISSIVE_TRANSPORT_EXPORT">
							<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain')" order="2" ></ui:button>
							</kmss:authShow>
							<kmss:auth
								requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=deleteall&categoryId=${param.categoryId}&nodeType=${param.nodeType}"
								requestMethod="GET">
							   <ui:button id="del" text="${lfn:message('button.deleteall')}" order="2" onclick="delDoc()"></ui:button>
							</kmss:auth>
							<%-- 分类转移 --%>
							<kmss:auth
									requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=changeTemplate&categoryId=${param.categoryId}&nodeType=${param.nodeType}"
									requestMethod="GET">
								<ui:button id="chgCate" text="${lfn:message('km-imissive:kmImissive.button.translate')}" order="2" onclick="chgSelect();"></ui:button>
							</kmss:auth>
							<%-- 修改权限 --%>
							<c:import url="/sys/right/import/cchange_doc_right_button.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
								<c:param name="authReaderNoteFlag" value="2" />
							</c:import>		
						</ui:toolbar>
				  </div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<list:listview id="listview_send">
			<ui:source type="AjaxJson">
					{url:'/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listChildren&categoryId=${JsParam.categoryId}'}
			</ui:source>
			<list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain" isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props=""></list:col-auto>
			</list:colTable>
		</list:listview> 
	 	<list:paging></list:paging>	 
	 	<script type="text/javascript">

	 	var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.km.imissive.model.KmImissiveSendMain";
	 	
			seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {
				//记录当前筛选器的分类（或模板）id和节点类型
				 var cateId = "";
				 var nodeType = "";
				
				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
				window.addDoc = function() {
					dialog.categoryForNewFile(
							'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',
							'/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdTemplateId=!{id}',false,null,null,null,null,null,true);
				};
				//删除
				window.delDoc = function(){
					var values = [];
					$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.post('<c:url value="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=deleteall"/>'+'&categoryId='+cateId+'&nodeType='+nodeType,
									$.param({"List_Selected":values},true),delCallback,'json');
						}
					});
				};
				window.delCallback = function(data){
					if(window.del_load!=null)
						window.del_load.hide();
					if(data!=null && data.status==true){
						topic.publish("list.refresh");
						dialog.success('<bean:message key="return.optSuccess" />');
					}else{
						dialog.failure('<bean:message key="return.optFailure" />');
					}
				};
				//分类转移
				window.chgSelect = function(){
					var values = "";
					$("input[name='List_Selected']:checked").each(function(){
						 values += "," + $(this).val();
					});
					if(values==''){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					values = values.substring(1);
					var cfg={
							'modelName':'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',
							'mulSelect':false,
							<%-- 如果用户有“分类权限扩充”角色，则允许转移到所有的分类 --%>
							<% 
								if(com.landray.kmss.util.UserUtil.checkRole("ROLE_KMIMISSIVE_SEND_OPTALL")) {
							%>
							'authType':'00',
							<%
								} else {
							%>
							'authType':'01',
							<%	
								}
							%>
							'action':function(value,____dialog){
								if(value.id){
									window.chg_load = dialog.loading();
									$.post('<c:url value="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=changeTemplate"/>',
											$.param({"values":values,"fdTemplateId":value.id},true),function(data){
										if(window.chg_load!=null)
											window.chg_load.hide();
										if(data!=null && data.status==true){
											topic.publish("list.refresh");
											dialog.success('<bean:message key="return.optSuccess" />');
										}else{
											dialog.failure('<bean:message key="return.optFailure" />');
										}
									},'json');
								}
							}
						};
						dialog.category(cfg);
				};
				window.serializeParams=function(params) {
					//alert(params);
					var array = [];
					for (var i = 0; i < params.length; i++) {
						var p = params[i];
						if (p.nodeType) {
							array.push('nodeType=' + p.nodeType);
						}
						for (var j = 0; j < p.value.length; j++) {
							array.push("q." + encodeURIComponent(p.key) + '='
									+ encodeURIComponent(p.value[j]));
						}
						if (p.op) {
							array.push(encodeURIComponent(p.key) + '-op='
									+ encodeURIComponent(p.op));
						}
						for (var k in p) {
							if (k == 'key' || k == 'op' || k == 'value' || k == 'nodeType') {
								continue;
							}
							array.push(encodeURIComponent(p.key + '-' + k) + "="
									+ encodeURIComponent(p[k] || ""));
						}
					}
					var str = array.join('&');
					return str;
				};
				window.exportResult=function (){
					var url = '<c:url value="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do" />?method=exportResult';
					var criterions = LUI('sendCriteria')._buildCriteriaSelectedValues();
					//alert(criterions);
					var urlParam = serializeParams(criterions);
					//alert(urlParam);
					if (urlParam) {
							if (url.indexOf('?') > 0) {
								url += "&" + urlParam;
							} else {
								url += "?" + urlParam;
							}
						}
					url +='&fdNum=5000&fdColumns=docSubject;fdDocNum;fdSendtoUnit.fdName;fdDrafter.fdName;fdDraftTime;docStatus'
					   +'&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain';
					  // alert(url);
					window.location.href = url;
				};
				
				//归档(原有的)
				window.filingDoc = function(){
					var values = [];
					$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
					});
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					dialog.confirm('<bean:message bundle="km-imissive" key="alert.msg"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.post('<c:url value="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=filingall"/>'+'&categoryId='+cateId+'&nodeType='+nodeType,
									$.param({"List_Selected":values},true),filingCallback,'json');
						}
					});
				};
				//归档（现在的）
				window.file_doc = function() {
					var values = [];
					$("input[name='List_Selected']:checked").each(function(){
						values.push($(this).val());
					});
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					var url = '${LUI_ContextPath}/sys/archives/sys_archives_file_template/sysArchivesFileTemplate.do?method=fileDocAll';
					dialog.confirm('<bean:message key="confirm.filed" bundle="sys-archives"/>',function(value){
						if(value==true){
							window.file_load = dialog.loading();
							$.ajax({
								url: url,
								type: 'POST',
								data:$.param({"List_Selected":values,
									serviceName:'kmImissiveSendMainService'},true),
								dataType: 'json',
								error: function(data){
									if(window.file_load!=null){
										window.file_load.hide(); 
									}
									dialog.result(data.responseJSON);
								},
								success: function(data){
									if(window.file_load!=null){
										window.file_load.hide(); 
									}
									topic.publish('list.refresh');
									dialog.result(data);
								}
						   });
						}
					});
				};
				//查看编号
				window.showNumber = function(){
					if(cateId !=null && cateId != "" && nodeType == "TEMPLATE"){
						var url = '/km/imissive/kmImissiveShowNumber.jsp?fdId='+cateId+'&type=send';
						dialog.iframe(url,'查看编号',function(rtn){},{width:800,height:500});
					}else{
						dialog.alert("请在筛选器中选择查看编号的模板！");
					}
				};
				
				window.filingCallback = function(data){
					if(window.del_load!=null)
						window.del_load.hide();
					if(data!=null && data.status==true){
						topic.publish("list.refresh");
						dialog.success('<bean:message bundle="km-imissive" key="msg.filing.success"/>');
					}else{
						dialog.failure('<bean:message bundle="km-imissive" key="msg.filing.failure"/>');
					}
				};
				 window.removeDelBtn = function(){
						if(LUI('del')){
	              	    LUI('Btntoolbar').removeButton(LUI('del'));
	              	    LUI('del').destroy();
	              	   }
					};
					 window.removeChgCateBtn = function(){
							if(LUI('chgCate')){
		              	    LUI('Btntoolbar').removeButton(LUI('chgCate'));
		              	    LUI('chgCate').destroy();
		              	   }
						};
					window.removeChangeRightBatchBtn = function(){
							if(LUI('docChangeRightBatch')){
		              	    LUI('Btntoolbar').removeButton(LUI('docChangeRightBatch'));
		              	    LUI('docChangeRightBatch').destroy();
		              	   }
					};
		            window.removeFilingBtn = function(){
					   if(LUI('filingAll')){
	               	    LUI('Btntoolbar').removeButton(LUI('filingAll'));
	               	    LUI('filingAll').destroy();
	               	   }
					};
				 /*  window.removeShowNumberBtn = function(){
					   if(LUI('showNumber')){
	               	    LUI('Btntoolbar').removeButton(LUI('showNumber'));
	               	    LUI('showNumber').destroy();
	               	   }
					}; */
					
				/******************************************
				  * 验证权限并显示按钮 
				  * param：
				  *       categoryId 模板id
				  *       nodeType 模板类型
				  *****************************************/
				var AuthCache = {};
				window.showButtons = function(cateId,nodeType){
				 if(AuthCache[cateId]){
					 //删除按钮
		             if(AuthCache[cateId].delBtn){
		            	 if(!LUI('del')){ 
			            	 var delBtn = toolbar.buildButton({id:'del',order:'2',text:'${lfn:message("button.delete")}',click:'delDoc()'});
	    					 LUI('Btntoolbar').addButton(delBtn);
		            	 }
		             }else{
		            	 if(LUI('del')){ 
		            	   LUI('Btntoolbar').removeButton(LUI('del'));
		            	   LUI('del').destroy();
		            	 }
			         }
			         //分类转移按钮
		             if(AuthCache[cateId].chgCateBtn){
		            	 if(!LUI('chgCate')){ 
			            	 var chgCateBtn = toolbar.buildButton({id:'chgCate',order:'2',text:'${lfn:message("km-imissive:kmImissive.button.translate")}',click:'chgSelect()'});
	    					 LUI('Btntoolbar').addButton(chgCateBtn);
		            	 }
		             }else{
		            	 if(LUI('chgCate')){ 
		            	   LUI('Btntoolbar').removeButton(LUI('chgCate'));
		            	   LUI('chgCate').destroy();
		            	 }
			         }

		             //批量修改权限按钮
		             if(AuthCache[cateId].changeRightBatchBtn){
		            	 if(!LUI('docChangeRightBatch')){
			                 var changeRightBatchBtn = toolbar.buildButton({id:'docChangeRightBatch',order:'4',text:'${lfn:message("sys-right:right.button.changeRightBatch")}',click:'changeRightCheckSelect("'+cateId+'","'+nodeType+'")'});
	    					 LUI('Btntoolbar').addButton(changeRightBatchBtn);
		            	 }
		             }else{
		            	 if(LUI('docChangeRightBatch')){ 
		            	   LUI('Btntoolbar').removeButton(LUI('docChangeRightBatch'));
		            	   LUI('docChangeRightBatch').destroy();
		            	 }
			         }
	             }
	             if(AuthCache[cateId]==null){
					     var checkChgCateUrl = "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=changeTemplate&categoryId="+cateId+"&nodeType="+nodeType;
		                 var checkDelUrl = "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=deleteall&categoryId="+cateId+"&nodeType="+nodeType;
						 var changeRightBatchUrl = "/sys/right/cchange_doc_right/cchange_doc_right.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain&categoryId="+cateId+"&nodeType="+nodeType;
			             var data = new Array();
		                 data.push(["delBtn",checkDelUrl]);
		                 data.push(["chgCateBtn",checkChgCateUrl]);
		                 data.push(["changeRightBatchBtn",changeRightBatchUrl]);
		                 $.ajax({
		       			  url: "${LUI_ContextPath}/sys/authorization/SysAuthUrlCheckAction.do?method=checkUrlAuth",
		       			  dataType:"json",
		       			  type:"post",
		       			  data:{"data":LUI.stringify(data)},
		       			  async:false,
		       			  success: function(rtn){
			       			var btnInfo = {};
			       			if(rtn.length > 0){
		       				  for(var i=0;i<rtn.length;i++){
		                 		if(rtn[i]['delBtn'] == 'true'){
		                 		 btnInfo.delBtn = true;
		                 		 if(!LUI('del')){ 
			                 		 var delBtn = toolbar.buildButton({id:'del',order:'2',text:'${lfn:message("button.delete")}',click:'delDoc()'});
			    					 LUI('Btntoolbar').addButton(delBtn);
		                 		 }
		                       }
		                 		if(rtn[i]['chgCateBtn'] == 'true'){
			                 		btnInfo.chgCateBtn = true;
			                 		 if(!LUI('chgCate')){ 
			                 			 var chgCateBtn = toolbar.buildButton({id:'chgCate',order:'2',text:'${lfn:message("km-imissive:kmImissive.button.translate")}',click:'chgSelect()'});
				    					 LUI('Btntoolbar').addButton(chgCateBtn);
			                 		 }
			                     }
		                 		if(rtn[i]['changeRightBatchBtn'] == 'true'){
			                 		btnInfo.changeRightBatchBtn = true;
			                 		 if(!LUI('docChangeRightBatch')){ 
						                 var changeRightBatchBtn = toolbar.buildButton({id:'docChangeRightBatch',order:'4',text:'${lfn:message("sys-right:right.button.changeRightBatch")}',click:'changeRightCheckSelect("'+cateId+'","'+nodeType+'")'});
				    					 LUI('Btntoolbar').addButton(changeRightBatchBtn);
			                 		 }
			                     } 
		       				  }
			       			}else{
	                    	   btnInfo.delBtn = false;
	                    	   btnInfo.chgCateBtn = false;
	                    	  if(LUI('del')){ 
	                    	    LUI('Btntoolbar').removeButton(LUI('del'));
	                    	    LUI('del').destroy();
	                    	  }
	                    	  if(LUI('chgCate')){ 
		                    	    LUI('Btntoolbar').removeButton(LUI('chgCate'));
		                    	    LUI('chgCate').destroy();
		                      }
	                    	  btnInfo.changeRightBatchBtn = false;
	                    	  if(LUI('docChangeRightBatch')){ 
	                    	    LUI('Btntoolbar').removeButton(LUI('docChangeRightBatch'));
	                    	    LUI('docChangeRightBatch').destroy();
	                    	  }
			                }
		                 	 AuthCache[cateId] = btnInfo;
		  		          }
	                  });
	               }
	            };
	            window.showFilingBtn = function(cateId,nodeType){
        			 var checkDelUrl ="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=filingall&categoryId="+cateId+"&nodeType="+nodeType;
					 var data = new Array();
	                 data.push(["filingAllBtn",checkDelUrl]);
	                 $.ajax({
	       			  url: "${LUI_ContextPath}/sys/authorization/SysAuthUrlCheckAction.do?method=checkUrlAuth",
	       			  dataType:"json",
	       			  type:"post",
	       			  data:{"data":LUI.stringify(data)},
	       			  async:false,
	       			  success: function(rtn){
	       				if(rtn.length > 0){
		       				  for(var i=0;i<rtn.length;i++){
		                 		if(rtn[i]['filingAllBtn'] == 'true'){
		                 		if(!LUI('filingAll')){
			                 		 var filingAllBtn = toolbar.buildButton({id:'filingAll',order:'2',text:'${lfn:message("km-imissive:button.filingall")}',click:'file_doc()'});
			    					 LUI('Btntoolbar').addButton(filingAllBtn);
		                 		}
		                       }
		       				 }
		       			  }else{
		       				removeFilingBtn();
		                  }
		       		  }
	               });
		        };
				<%
				   request.setAttribute("admin",UserUtil.getKMSSUser().isAdmin());
				%>

				 
				//根据筛选器分类异步校验权限
				topic.subscribe('criteria.changed',function(evt){
					if("${admin}"=="false"){
					 removeDelBtn();
					 removeChgCateBtn();
					 removeChangeRightBatchBtn();
					}
					removeFilingBtn();
					//removeShowNumberBtn();
					var hasStatus = false;  //筛选器中是否包含状态筛选项
					var hasTemp = false;    //筛选器中是否包含模板筛选项
					var docStatus = "";    //记录筛选器中状态筛选项的值
					//筛选器变化时清空分类和节点类型的值
					cateId = "";  
					nodeType = "";
					for(var i=0;i<evt['criterions'].length;i++){
						  //获取分类id和类型
		             	  if(evt['criterions'][i].key=="fdTemplate"){
		                 	 cateId= evt['criterions'][i].value[0];
			                 nodeType = evt['criterions'][i].nodeType;
			                 hasTemp = true;
		             	  }
		             	 if(evt['criterions'][i].key=="docStatus" && evt['criterions'][i].value.length==1) {
								hasStatus = true;
								docStatus = evt['criterions'][i].value[0];
						  }
					}
					if(hasTemp){
						 //分类变化或者带有分类刷新
		                showButtons(cateId,nodeType);
						/*  if(nodeType == "TEMPLATE"){
							 var showNumberBtn = toolbar.buildButton({id:'showNumber',order:'5',text:'查看编号',click:'showNumber()'});
		    					LUI('Btntoolbar').addButton(showNumberBtn);
						 } */
					}
					if(hasStatus){
						if(docStatus=='10') {
							if(!LUI('del')){
								var delBtn = toolbar.buildButton({id:'del',order:'2',text:'${lfn:message("button.delete")}',click:'delDoc()'});
		    					LUI('Btntoolbar').addButton(delBtn);
							}
						} else if(docStatus=="30"&&hasTemp){   //包含模板和状态筛选项且状态筛选项值为30
							showFilingBtn(cateId,nodeType);
	             		}else{
		             		removeFilingBtn();
		             	}
					}
					//筛选器全部清空的情况
					if(evt['criterions'].length==0){
						 showButtons("","");
					}
				});
			});
		</script>
	</template:replace>	 
</template:include>