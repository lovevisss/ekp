<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="content">  
		<list:criteria id="receiveCriteria">
	      <list:cri-ref key="docSubject" ref="criterion.sys.docSubject"> 
		  </list:cri-ref>
			<list:cri-criterion title="${ lfn:message('km-imissive:kmImissiveReceiveMain.docStatus')}" key="docStatus"  multi="false"> 
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('status.draft')}', value:'10'},{text:'${ lfn:message('status.examine')}',value:'20'},{text:'${ lfn:message('km-imissive:kmImissive.status.refuse')}',value:'11'},{text:'${ lfn:message('status.discard')}',value:'00'},{text:'${ lfn:message('km-imissive:kmImissive.status.publish')}',value:'30'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:cri-criterion title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdSendtoDept')}" key="SendtoUnit">
		      <list:box-select> 
		        <list:item-select type="lui/criteria/criterion_input!TextInput"> 
		        <ui:source type="Static">
		           [{placeholder:'${ lfn:message('km-imissive:kmImissiveReceiveMain.fdSendtoDept')}'}]
		        </ui:source>
		        </list:item-select>
		      </list:box-select>
		    </list:cri-criterion>  
		    <list:cri-auto modelName="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" property="fdDocNum"/>
		    <list:cri-auto modelName="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" property="fdReceiveNum"/>
		    <list:cri-criterion title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdReceiveUnit')}" key="ReceiveUnit">
		      <list:box-select> 
		        <list:item-select type="lui/criteria/criterion_input!TextInput"> 
		        <ui:source type="Static">
		           [{placeholder:'${ lfn:message('km-imissive:kmImissiveReceiveMain.fdReceiveUnit')}'}]
		        </ui:source>
		        </list:item-select>
		      </list:box-select>
		    </list:cri-criterion>  
			<list:cri-auto modelName="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" property="fdReceiveTime;fdSigner;fdSignTime;fdIsFiling;fdIsReturn"/>
	  </list:criteria>
		<div class="lui_list_operation">
			<!-- 全选 -->
			<div class="lui_list_operation_order_btn">
				<list:selectall></list:selectall>
			</div>
			<!-- 分割线 -->
			<div class="lui_list_operation_line"></div>
			<!-- 排序 -->
			<div class="lui_list_operation_sort_btn">
				<div class="lui_list_operation_order_text">
					${ lfn:message('list.orderType') }：
				</div>
				<div class="lui_list_operation_sort_toolbar">
						<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
							<list:sortgroup>
								<list:sort property="docCreateTime" text="${ lfn:message('km-imissive:kmImissiveReceiveMain.docCreateTime')}" group="sort.list"  value="down"></list:sort>
								<list:sort property="docPublishTime" text="${ lfn:message('km-imissive:kmImissiveReceiveMain.docPublishTime')}" group="sort.list"></list:sort>
							    <list:sort property="fdDocNum" text="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdReceiveNum')}" group="sort.list"></list:sort>
							</list:sortgroup>
						</ui:toolbar>
						</div>
					</div>
					<!-- 分页 -->
					<div class="lui_list_operation_page_top">	
						<list:paging layout="sys.ui.paging.top" > 		
						</list:paging>
					</div>	
					<div style="float:right">
						<div style="display: inline-block;vertical-align: middle;">
						<ui:toolbar count="4" id="Btntoolbar">
							<%-- 收藏 --%>
							<c:import url="/sys/bookmark/import/bookmark_bar_all.jsp" charEncoding="UTF-8">
								<c:param name="fdTitleProName" value="docSubject" />
								<c:param name="fdModelName"	value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
							</c:import>
							
							<c:if test="${param.categoryId==null || param.nodeType=='CATEGORY'}">	
								<kmss:authShow roles="ROLE_KMIMISSIVE_RECEIVE_CREATE">
									<ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2"></ui:button>	
								</kmss:authShow>
							</c:if>
							<c:if test="${param.nodeType=='TEMPLATE'}">
								<kmss:auth
									requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=add&fdTemplateId=${param.categoryId}"
									requestMethod="GET">
									<ui:button text="${lfn:message('button.add')}" onclick="Com_OpenWindow('${LUI_ContextPath }/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=add&fdTemplateId=${JsParam.categoryId}');" order="2"></ui:button>
								</kmss:auth>
							</c:if>	
							<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=deleteall&categoryId=${param.categoryId}&nodeType=${param.nodeType}" requestMethod="GET">
								<ui:button id='del' text="${lfn:message('button.deleteall')}" onclick="delDoc()" order="3">
								</ui:button>
							</kmss:auth>
							<%-- 修改权限 --%>
							<c:import url="/sys/right/import/cchange_doc_right_button.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
								<c:param name="authReaderNoteFlag" value="2" />
							</c:import>	
							<%-- 分类转移 --%>
							<kmss:auth
									requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=changeTemplate&categoryId=${param.categoryId}&nodeType=${param.nodeType}"
									requestMethod="GET">
								<ui:button id="chgCate" text="${lfn:message('km-imissive:kmImissive.button.translate')}" order="3" onclick="chgSelect();"></ui:button>
							</kmss:auth>
						</ui:toolbar>
					</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=manageList&categoryId=${JsParam.categoryId}&nodeType=${JsParam.nodeType}'}
			</ui:source>
			<list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"  isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props=""></list:col-auto>
			</list:colTable>
		</list:listview> 
	 	<list:paging></list:paging>	 
	 	<script type="text/javascript">

	 	    var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain";
	 	
			seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {

				//记录当前筛选器的分类（或模板）id和节点类型
				 var cateId = "";
				 var nodeType = "";
				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
				//根据地址获取key对应的筛选值
				var getValueByHash=function(key){
					var hash = window.location.hash;
	                if(hash.indexOf(key)<0){
	                    return "";
	                }
	            	var url = hash.split("cri.q=")[1];
	  			    var reg = new RegExp("(^|;)"+ key +":([^;]*)(;|$)");
				    var r=url.match(reg);
					if(r!=null){
						return unescape(r[2]);
					}
					return "";
				};
				
				//新建
				window.addDoc = function() {
					dialog.categoryForNewFile(
							'com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate',
							'/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=add&fdTemplateId=!{id}',false,null,null,getValueByHash("fdTemplate"),null,null,true);
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
					var url='<c:url value="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=deleteall"/>&categoryId=${param.categoryId}&nodeType=${param.nodeType}';
					var config = {
						url : url, // 删除数据的URL
						data : $.param({"List_Selected":values},true), // 要删除的数据
						modelName : "com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"
					};
					// 通用删除方法
					Com_Delete(config, delCallback);
				};
				window.delCallback = function(data){
					topic.publish("list.refresh");
					dialog.result(data);
				};
				
				//分类转移
				window.chgSelect = function() {
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
							'modelName':'com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate',
							'mulSelect':false,
							<%-- 如果用户有“分类权限扩充”角色，则允许转移到所有的分类 --%>
							<% 
								if(com.landray.kmss.util.UserUtil.checkRole("ROLE_KMIMISSIVE_RECEIVE_OPTALL")) {
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
									$.post('<c:url value="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=changeTemplate"/>',
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
							$.post('<c:url value="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=filingall"/>'+'&categoryId='+cateId+'&nodeType='+nodeType,
									$.param({"List_Selected":values},true),filingCallback,'json');
						}
					});
				};
				window.filingCallback = function(data){
					if(window.del_load!=null)
						window.del_load.hide();
					if(data!=null && data.status==true){
						topic.publish("list.refresh");
						dialog.success('<bean:message bundle="km-imissive" key="msg.filing.success"/>');
					}else{
						dialog.success('<bean:message bundle="km-imissive" key="msg.filing.failure"/>');
					}
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
									serviceName:'kmImissiveReceiveMainService'},true),
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
					var url = '/km/imissive/kmImissiveShowNumber.jsp?fdId='+cateId+'&type=receive';
					dialog.iframe(url,'查看编号',function(rtn){},{width:800,height:500});
				};
				
				
				/******************************************
				  * 验证权限并显示按钮 
				  * param：
				  *       categoryId 模板id
				  *       nodeType 模板类型
				  *****************************************/
				var AuthCache = {};
				window.showButtons = function(cateId,nodeType){
					 if(AuthCache[cateId]){
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
		            	 var checkChgCateUrl = "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=changeTemplate&categoryId="+cateId+"&nodeType="+nodeType;
			                 var checkDelUrl = "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=deleteall&categoryId="+cateId+"&nodeType="+nodeType;
							 var changeRightBatchUrl = "/sys/right/cchange_doc_right/cchange_doc_right.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&categoryId="+cateId+"&nodeType="+nodeType;
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
       			 var checkDelUrl ="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=filingall&categoryId="+cateId+"&nodeType="+nodeType;
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
				 window.removeShowNumberBtn = function(){
					   if(LUI('showNumber')){
	               	    LUI('Btntoolbar').removeButton(LUI('showNumber'));
	               	    LUI('showNumber').destroy();
	               	   }
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
					removeShowNumberBtn();
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
						 if(nodeType == "TEMPLATE"){
							 var showNumberBtn = toolbar.buildButton({id:'showNumber',order:'5',text:'查看编号',click:'showNumber()'});
		    					LUI('Btntoolbar').addButton(showNumberBtn);
						 }
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