<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
	<script type="text/javascript">
		seajs.use(['theme!list']);	
	</script>
  <list:criteria id="signCriteria" >
        <list:cri-ref key="docSubject" ref="criterion.sys.docSubject"> 
		</list:cri-ref>
		<list:cri-ref ref="criterion.sys.category" key="fdTemplate" multi="false" title="${ lfn:message('km-imissive:kmImissiveSignMain.criteria.fdTemplate') }" expand="false">
		  <list:varParams modelName="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate"/>
		</list:cri-ref>
		<list:cri-auto modelName="com.landray.kmss.km.imissive.model.KmImissiveSignMain" property="fdDocNum;fdDrafter;fdDraftTime;docPublishTime;docCreateTime" />
		<list:cri-criterion expand="false" title="${lfn:message('km-imissive:kmImissiveSignMain.fdDeadTime') }" key="fdDeadType" multi="false">
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
						<list:sort property="docCreateTime" text="${ lfn:message('km-imissive:kmImissiveSignMain.docCreateTime')}" group="sort.list" value="down"></list:sort>
						<list:sort property="docPublishTime" text="${ lfn:message('km-imissive:kmImissiveSignMain.docPublishTime')}" group="sort.list"></list:sort>
						<list:sort property="fdDeadTime" text="${lfn:message('km-imissive:kmImissiveSignMain.fdDeadTime')}" group="sort.list"></list:sort>
					    <list:sort property="fdDocNum" text="${ lfn:message('km-imissive:kmImissiveSignMain.fdDocNum')}" group="sort.list"></list:sort>
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
				<ui:toolbar count="3" id="Btntoolbar">
					<%-- 批量打印 --%>
					<kmss:authShow roles="ROLE_KMIMISSIVE_PRINTBATCH">
					 	<ui:button text="${lfn:message('km-imissive:kmImissive.printBatch')}" id="batchPrint" onclick="batchPrint();" order="4" ></ui:button>
					</kmss:authShow>
					<%-- 收藏 --%>
					<c:import url="/sys/bookmark/import/bookmark_bar_all.jsp" charEncoding="UTF-8">
						<c:param name="fdTitleProName" value="docSubject" />
						<c:param name="fdModelName"	value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
					</c:import>
					<kmss:ifModuleExist path="/km/supervise/">
						<kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
							<ui:button  text="${lfn:message('km-supervise:table.kmSuperviseMain.title')}"  onclick="openSupervise();" order="2">
							</ui:button>
						</kmss:authShow>
					</kmss:ifModuleExist>
					<kmss:authShow roles="ROLE_KMIMISSIVE_SIGN_CREATE">
						<ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="1" 
									cfg-if="param['docStatus'] != '00' && param['docStatus'] != '32' && param['fdIsFiling'] != '1'"></ui:button>	
					</kmss:authShow>
					<kmss:authShow roles="ROLE_KMIMISSIVE_NUMBER">
					<ui:button text="${lfn:message('km-imissive:kmImissive.showNumber')}" onclick="showNumber()" order="2"
								cfg-if="param['docStatus'] != '00' && param['docStatus'] != '32' && param['fdIsFiling'] != '1'"></ui:button>
					</kmss:authShow>
					<kmss:authShow roles="ROLE_KMIMISSIVE_TRANSPORT_EXPORT">
					<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain')" order="2" ></ui:button>
					</kmss:authShow>
					<kmss:auth
						requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=deleteall&categoryId=${param.categoryId}&nodeType=${param.nodeType}"
						requestMethod="GET">
					   <ui:button id="del" text="${lfn:message('button.deleteall')}" order="3" onclick="delDoc()"></ui:button>
					</kmss:auth>
					<%-- 修改权限 --%>
					<c:import url="/sys/right/import/cchange_doc_right_button.jsp" charEncoding="UTF-8">
						<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
						<c:param name="authReaderNoteFlag" value="2" />
					</c:import>	
					<%-- 分类转移 --%>
					<kmss:auth
							requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=changeTemplate&categoryId=${param.categoryId}&nodeType=${param.nodeType}"
							requestMethod="GET">
						<ui:button id="chgCate" text="${lfn:message('km-imissive:kmImissive.button.translate')}" order="3" onclick="chgSelect();"></ui:button>
					</kmss:auth>	
				</ui:toolbar>
			</div>
		</div>
	</div>
	<ui:fixed elem=".lui_list_operation"></ui:fixed>
	<list:listview id="listview_sign" >
		<ui:source type="AjaxJson">
				{url:'/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=listChildren&categoryId=${JsParam.categoryId}&q.docStatus=30'}
		</ui:source>
		<list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain"  isDefault="false" layout="sys.ui.listview.columntable" 
			rowHref="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=view&fdId=!{fdId}"  name="columntable">
			<list:col-checkbox></list:col-checkbox>
			<list:col-serial></list:col-serial>
			<list:col-auto props=""></list:col-auto>
		</list:colTable>
	</list:listview> 
 	<list:paging cfg-key="${param.contentId}"  id="paging-${param.contentId}"></list:paging>	 
 	<%@ include file="/km/imissive/km_imissive_sign_main/index_sign_script.jsp"%>
	</template:replace>
</template:include>		 
	
