<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	  	<list:criteria  channel="listview_cir" id="yuejianCriteria" cfg-canExpand="false">
	  		 <list:tab-criterion title="" key="fd_main_type"> 
				<list:box-select>
					<list:item-select type="lui/criteria/select_panel!TabCriterionSelectDatas">
						<ui:source type="Static">
							[{text:'发文', value:'send'},
							 {text:'收文',value:'receive'},
							 {text:'签报',value:'sign'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:tab-criterion>
			<list:cri-ref key="doc_subject" ref="criterion.sys.docSubject"> 
		    </list:cri-ref>
			<%--
	  		<list:cri-criterion title="标题" key="doc_subject">
		      <list:box-select>
		        <list:item-select type="lui/criteria/criterion_input!TextInput"> 
			        <ui:source type="Static">
			           [{placeholder:'请输入标题'}]
			        </ui:source>
		        </list:item-select>
		      </list:box-select>
		    </list:cri-criterion>
		    --%>
	  		 <list:cri-criterion title="文号" key="fd_doc_num">
		      <list:box-select> 
		        <list:item-select type="lui/criteria/criterion_input!TextInput"> 
			        <ui:source type="Static">
			           [{placeholder:'请输入文号'}]
			        </ui:source>
		        </list:item-select>
		      </list:box-select>
		    </list:cri-criterion>
		     <list:cri-criterion title="拟稿人" key="fd_drafter">
		      <list:box-select> 
		        <list:item-select type="lui/criteria/criterion_input!TextInput"> 
			        <ui:source type="Static">
			           [{placeholder:'请输入拟稿人'}]
			        </ui:source>
		        </list:item-select>
		      </list:box-select>
		    </list:cri-criterion>
		    <list:cri-criterion title="拟稿日期" multi="false" expand="false" key="fd_draft_time">
				<list:varDef name="title"></list:varDef>
				<list:varDef name="selectBox">
				<list:box-select>
					<list:item-select type="lui/criteria/criterion_calendar!CriterionDateDatas" >
					</list:item-select>
				</list:box-select>
				</list:varDef>
			</list:cri-criterion>
		     <list:cri-criterion title="紧急程度" key="fd_emergency">
		      <list:box-select> 
		        <list:item-select type="lui/criteria/criterion_input!TextInput"> 
			        <ui:source type="Static">
			           [{placeholder:'请输入紧急程度'}]
			        </ui:source>
		        </list:item-select>
		      </list:box-select>
		    </list:cri-criterion>
		     <list:cri-criterion title="密级程度" key="fd_secret">
		      <list:box-select> 
		        <list:item-select type="lui/criteria/criterion_input!TextInput"> 
			        <ui:source type="Static">
			           [{placeholder:'请输入密级程度'}]
			        </ui:source>
		        </list:item-select>
		      </list:box-select>
		    </list:cri-criterion>
		</list:criteria>
		<div class="lui_list_operation">
			<div class="gkp_list_operation_item_l">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar count="3" id="Btntoolbar">
						<kmss:authShow roles="ROLE_KMIMISSIVE_PRINTBATCH">	
						 	<ui:button text="${lfn:message('km-imissive:kmImissive.printBatch')}" id="batchPrint" onclick="batchPrint();" order="4" ></ui:button>
						</kmss:authShow>
						<kmss:authShow roles="ROLE_KMIMISSIVE_TRANSPORT_EXPORT">
							<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain')" order="2" ></ui:button>
						</kmss:authShow>	   
					</ui:toolbar>
				  </div>
			</div>
			
			<div class="gkp_list_operation_item_r"> 
				<div data-lui-type="lui/search_box_new!SearchBox" class="searchBox">
					<script type="text/config">
					{
						placeholder: "请输入标题",
						width: '200px'
					}
				</script>
					<ui:event event="search.changed" args="evt">
						doSearchAction(evt);
					</ui:event>
				</div>
				<div class="moreSearchBtn" >
					<a onclick="expanded();">高级搜索</a>
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<list:listview id="listview_cir" channel="listview_cir">
			<ui:source type="AjaxJson">
					{url:'/km/imissive/km_imissive_main/kmImissiveMain.do?method=listRead&mydoc=${param.mydoc}'}
			</ui:source>
			<list:colTable  isDefault="false" layout="sys.ui.listview.columntable" onRowClick="onRowClickFn('!{_fdId}','!{_fdType}');"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="docSubject,fdDocNum,fdType,fdDrafter,fdDraftTime,fdEmergency,fdSecret,nodeName,handlerName"></list:col-auto>
			</list:colTable>
		</list:listview> 
	 	<list:paging channel="listview_cir" cfg-key="${param.contentId}" id="paging-${param.contentId}"></list:paging>
	 	<script>
	 	seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {
	 		
	 		window.onRowClickFn = function(fdId,_fdType){
		 		var url = '${LUI_ContextPath}/km/imissive/km_imissive_main/kmImissiveMain.do?method=view&fdId='+fdId+'&fdType='+_fdType;
		 		window.open(url,'_blank');
				setTimeout(function(){
					topic.channel('listview_cir').publish('list.refresh');
				},3000);
		 	};
		 	
		 	window.expanded = function(){
				
				LUI('yuejianCriteria').expandCriterions(!LUI('yuejianCriteria').expand);
				
			};
			
			window.doSearchAction = function(evt){
				var topicEvent = {
						criterions :  LUI("yuejianCriteria")._buildCriteriaSelectedValues(),
						query : []
					};
				var obj = {};
				var values = [];
				values.push(evt.searchText);
				obj.key = "doc_subject";
				obj.value = values;
				topicEvent.criterions.push(obj);
				var j_path_value;
				if("${param.contentId}" == "myApprovalToReadContent"){
					j_path_value = "/myApproval/toread";
				}
				if("${param.contentId}" == "myApprovedReadedContent"){
					j_path_value = "/myApproved/readed";
				}
				if(j_path_value != ""){
					var obj2 = {};
					var values2 = [];
					values2.push(j_path_value);
					obj2.key = "j_path";
					obj2.value = values2;
					topicEvent.criterions.push(obj2);
				}
				topic.channel('listview_cir').publish("criteria.changed", topicEvent);
			}
	 	});
	 	</script>
	</template:replace>	 
</template:include>