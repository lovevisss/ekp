<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<%
	request.setAttribute("isCurUserAdmin", UserUtil.getKMSSUser().isAdmin());
%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	  <list:criteria id="sendCriteria" cfg-canExpand="false">
	  		 <list:tab-criterion title="" key="docStatus"> 
				<list:box-select>
					<list:item-select type="lui/criteria/select_panel!TabCriterionSelectDatas" cfg-enable="false" cfg-if=" param['mydoc']!='approval' && param['mydoc']!='approvalSend' && param['docStatus']!='00' && param['fdIsFiling']!='1'&&param['flag']!='finished'">
						<ui:source type="Static">
							[{text:'${ lfn:message('status.draft')}', value:'10'},
							 {text:'${ lfn:message('status.examine')}',value:'20'},
							 {text:'${ lfn:message('km-imissive:kmImissive.status.refuse')}',value:'11'},
							 {text:'${ lfn:message('km-imissive:kmImissive.status.publish')}',value:'30'},
							 {text:'${ lfn:message('status.discard')}',value:'00'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:tab-criterion>
			 <list:cri-ref key="docSubject" ref="criterion.sys.docSubject"> 
			</list:cri-ref>
			<list:cri-ref ref="criterion.sys.category" key="fdTemplate" multi="false" title="${ lfn:message('km-imissive:kmImissiveSendMain.criteria.fdTemplate') }" expand="false">
			  <list:varParams modelName="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate"/>
			</list:cri-ref>
			<list:cri-criterion title="${ lfn:message('km-imissive:kmImissiveSendMain.fdSendtoDept')}" key="SendtoUnit">
		      <list:box-select> 
		        <list:item-select type="lui/criteria/criterion_input!TextInput"> 
		        <ui:source type="Static">
		           [{placeholder:'${ lfn:message('km-imissive:kmImissiveSendMain.fdSendtoDept')}'}]
		        </ui:source>
		        </list:item-select>
		      </list:box-select>
		    </list:cri-criterion>
			<list:cri-auto modelName="com.landray.kmss.km.imissive.model.KmImissiveSendMain" property="fdDocNum;fdDrafter;fdDraftTime;docPublishTime;docCreateTime" />
			
			<list:cri-criterion expand="false" title="${lfn:message('km-imissive:kmImissiveSendMain.fdDeadTime') }" key="fdDeadType" multi="false">
            	<list:box-select>
                	 <list:item-select cfg-if="criteria('docStatus')[0] != '' && criteria('docStatus')[0] != '10'">
                        <ui:source type="Static">
                            [{text:'${lfn:message('km-imissive:kmImissiveMain.fdDeadType.overdue') }', value:'overdue'},
                            {text:'${lfn:message('km-imissive:kmImissiveMain.fdDeadType.normal') }',value:'normal'}]
                        </ui:source>
                	</list:item-select>
        		</list:box-select>
            </list:cri-criterion>
		</list:criteria>
		<div class="lui_list_operation">
			<div class="gkp_list_operation_item_l">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar count="8" id="Btntoolbar">
						<%-- 批量打印 --%>
						<kmss:authShow roles="ROLE_KMIMISSIVE_PRINTBATCH">
						 	<ui:button text="${lfn:message('km-imissive:kmImissive.printBatch')}" id="batchPrint" onclick="batchPrint();" order="4" ></ui:button>
						</kmss:authShow>
						<%-- 收藏 --%>
						<c:import url="/sys/bookmark/import/bookmark_bar_all.jsp" charEncoding="UTF-8">
							<c:param name="fdTitleProName" value="docSubject" />
							<c:param name="fdModelName"	value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
						</c:import>
						<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE">
							<ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="1"
										cfg-if="param['docStatus'] != '00' && param['docStatus'] != '32' && param['fdIsFiling'] != '1'"></ui:button>	
						</kmss:authShow>
						<kmss:authShow roles="ROLE_KMIMISSIVE_NUMBER">
						<ui:button text="${lfn:message('km-imissive:kmImissive.showNumber')}" onclick="showNumber()" order="2"
									cfg-if="param['docStatus'] != '00' && param['docStatus'] != '32' && param['fdIsFiling'] != '1'"></ui:button>
						</kmss:authShow>
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
		<list:listview id="listview_send">
			<ui:source type="AjaxJson">
				{url:'/km/imissive/km_imissive_send_main/kmImissiveSendMainDataOther.do?method=listChildren&categoryId=${JsParam.categoryId}&modelName=${JsParam.fdModelName}&q.docType=myApprovaled&q.j_path=%2FsummaryApproval%2FsummaryMyDone&hasDisCard=true'}
			</ui:source>
			<list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain" isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props=""></list:col-auto>
			</list:colTable>
		</list:listview> 
	 	<list:paging></list:paging>
	 	<%@ include file="/km/imissive/km_imissive_send_main/index_send_script.jsp"%>
	</template:replace>	 
</template:include>