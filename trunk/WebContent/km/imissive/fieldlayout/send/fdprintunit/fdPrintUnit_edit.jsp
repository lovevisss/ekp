<%-- 拟文单位 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%
    String fdPrintUnitId = parse.getParamValue("fdPrintUnitId");
    String fdPrintUnitName = parse.getParamValue("fdPrintUnitName");
    
    String defaultFdPrintUnitId = parse.acquireValue("fdPrintUnitId",fdPrintUnitId);
    String defaultFdPrintUnitName = parse.acquireValue("fdPrintUnitName",fdPrintUnitName);
	parse.addStyle("width", "control_width", "45%");
%>
<c:choose>
    <c:when test="${param.mobile eq 'true'}">
    	<c:set var="fdPrintUnitId" value="<%=defaultFdPrintUnitId%>"></c:set>
    	<c:set var="fdPrintUnitName" value="<%=defaultFdPrintUnitName%>"></c:set>
    	<c:if test="${kmImissiveSendMainForm.method_GET=='edit'}">
    		<c:set var="fdPrintUnitId" value="${kmImissiveSendMainForm.fdPrintUnitId}"></c:set>
    		<c:set var="fdPrintUnitName" value="${kmImissiveSendMainForm.fdPrintUnitName}"></c:set>
    	</c:if>
    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
	    	 data-dojo-props='"afterSelect":function(evt){afterSelectPrint(evt);},"idField":"fdPrintUnitId","nameField":"fdPrintUnitName","curIds":"${fdPrintUnitId}","curNames":"${fdPrintUnitName}","subject":"印发部门","title":"印发部门","showStatus":"edit","isMul":false,"validate":"required","required":<%=required%>,
	   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileDataBeanService&parentId=!{parentId}",
	    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileDataBeanService&parentId=searchUnit&amp;fdKeyWord=!{keyword}",
	    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   	 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
		</div>
		<script>
			function afterSelectPrint(evt){
				console.log(evt);
			}
		</script>
    </c:when>
    <c:otherwise>
    <div id="_fdPrintUnit" valField="fdPrintUnitId" xform_type="dialog">
	<xform:dialog propertyId="fdPrintUnitId"
	              propertyName="fdPrintUnitName"
		          style="<%=parse.getStyle()%>" 
		          idValue="<%=defaultFdPrintUnitId %>"
		          nameValue="<%=defaultFdPrintUnitName %>"
		          className="inputsgl"
		          useNewStyle="true"
		          required="<%=required%>"
		          subject="${ lfn:message('km-imissive:kmImissiveSendMain.fdPrintUnit') }">  
			      Dialog_UnitTreeList(false, 'fdPrintUnitId', 'fdPrintUnitName', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
			      '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive" />', 'kmImissiveUnitListService&parentId=!{value}');
	</xform:dialog>
	</div>
	<script>
	$(document).ready(function(){
		var id = document.getElementsByName("fdPrintUnitId")[0].value;
	   	var name = document.getElementsByName("fdPrintUnitName")[0].value;
		initNewDialog("fdPrintUnitId","fdPrintUnitName",";","kmImissiveUnitListService&newSearch=true",false,id,name,null);
	});
	</script>
</c:otherwise>
</c:choose>