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
    String fdDraftUnitId = parse.getParamValue("fdDraftUnitId");
    String fdDraftUnitName = parse.getParamValue("fdDraftUnitName");
    
    String defaultDdDraftUnitId = parse.acquireValue("fdDraftUnitId",fdDraftUnitId);
    String defaultFdDraftUnitName = parse.acquireValue("fdDraftUnitName",fdDraftUnitName);
	parse.addStyle("width", "control_width", "45%");
%>
<c:choose>
    <c:when test="${param.mobile eq 'true'}">
    	<c:set var="fdDraftUnitId" value="<%=defaultDdDraftUnitId%>"></c:set>
    	<c:set var="fdDraftUnitName" value="<%=defaultFdDraftUnitName%>"></c:set>
    	<c:if test="${kmImissiveSendMainForm.method_GET=='edit'}">
    		<c:set var="fdDraftUnitId" value="${kmImissiveSendMainForm.fdDraftUnitId}"></c:set>
    		<c:set var="fdDraftUnitName" value="${kmImissiveSendMainForm.fdDraftUnitName}"></c:set>
    	</c:if>
    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
	    	 data-dojo-props='"afterSelect":function(evt){afterSelectDraft(evt);},"idField":"fdDraftUnitId","nameField":"fdDraftUnitName","curIds":"${fdDraftUnitId}","curNames":"${fdDraftUnitName}","subject":"拟文单位","title":"拟文单位","showStatus":"edit","isMul":false,"validate":"required","required":<%=required%>,
	   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileDataBeanService&parentId=!{parentId}",
	    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileDataBeanService&parentId=searchUnit&amp;fdKeyWord=!{keyword}",
	    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
		</div>
		<script>
			function afterSelectDraft(evt){
				console.log(evt);
			}
		</script>
    </c:when>
    <c:otherwise>
    <div id="_fdDraftUnit" valField="fdDraftUnitId" xform_type="dialog">
	<xform:dialog propertyId="fdDraftUnitId"
	              propertyName="fdDraftUnitName"
		          style="<%=parse.getStyle()%>" 
		          idValue="<%=defaultDdDraftUnitId %>"
		          nameValue="<%=defaultFdDraftUnitName %>"
		          className="inputsgl"
		          useNewStyle="true"
		          required="<%=required%>"
		          subject="${ lfn:message('km-imissive:kmImissiveSendMain.fdDraftDeptId') }">  
			      Dialog_UnitTreeList(false, 'fdDraftUnitId', 'fdDraftUnitName', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
			      '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive" />', 'kmImissiveUnitListService&parentId=!{value}');
	</xform:dialog>
	</div>
	<script>
	$(document).ready(function(){
		var id = document.getElementsByName("fdDraftUnitId")[0].value;
	   	var name = document.getElementsByName("fdDraftUnitName")[0].value;
		initNewDialog("fdDraftUnitId","fdDraftUnitName",";","kmImissiveUnitListService&newSearch=true",false,id,name,null);
	});
	</script>
</c:otherwise>
</c:choose>