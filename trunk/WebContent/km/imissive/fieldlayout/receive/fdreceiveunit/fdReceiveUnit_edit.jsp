<%-- 收文单位 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="java.net.URLEncoder" %>
<%@ page import="com.landray.kmss.util.StringUtil"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%
	String fdMissiveUnitListIds = parse.getParamValue("fdMissiveUnitListIds");
	String fdMissiveUnitListNames = parse.getParamValue("fdMissiveUnitListNames");
	
	request.setAttribute("fdMissiveUnitListIds",fdMissiveUnitListIds);
	request.setAttribute("fdMissiveUnitListNames",fdMissiveUnitListNames);
	
	parse.addStyle("width", "control_width", "45%");
%>

<c:choose>
    <c:when test="${param.mobile eq 'true'}">
    	<c:set var="fdReceiveUnitId" value="${fdMissiveUnitListIds}"></c:set>
    	<c:set var="fdReceiveUnitName" value="${fdMissiveUnitListNames }"></c:set>
    	<c:if test="${kmImissiveReceiveMainForm.method_GET=='edit' || kmImissiveReceiveMainForm.method_GET=='add'}">
    		<c:set var="fdReceiveUnitId" value="${kmImissiveReceiveMainForm.fdReceiveUnitId}"></c:set>
    		<c:set var="fdReceiveUnitName" value="${kmImissiveReceiveMainForm.fdReceiveUnitName}"></c:set>
    	</c:if>
    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
	    	 data-dojo-props='"afterSelect":function(evt){afterSelectReceive(evt);},"idField":"fdReceiveUnitId","nameField":"fdReceiveUnitName","curIds":"${fdReceiveUnitId}","curNames":"${fdReceiveUnitName}","subject":"收文单位","title":"收文单位","showStatus":"edit","isMul":false,"validate":"required","required":<%=required%>,
	   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileDataBeanService&parentId=!{parentId}",
	    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileDataBeanService&parentId=searchUnit&amp;fdKeyWord=!{keyword}",
	    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
		</div>
		<script>
			function afterSelectReceive(evt){
				console.log(evt);
			}
		</script>
    </c:when>
    <c:otherwise>
    <div id="_fdReceiveUnit" valField="fdReceiveUnitId" xform_type="dialog">
	<xform:dialog propertyId="fdReceiveUnitId"
				  propertyName="fdReceiveUnitName" 
				  idValue="<%=fdMissiveUnitListIds%>"
				  nameValue="<%=fdMissiveUnitListNames%>"
				  style="<%=parse.getStyle()%>"
				  useNewStyle="true"
				  className="inputsgl"
				  required="<%=required%>"
				  subject="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdReceiveUnit') }">
				  Dialog_UnitTreeList(false, 'fdReceiveUnitId', 'fdReceiveUnitName', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}',
				                         '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive" />',
				                         'kmImissiveUnitListService&parentId=!{value}',null,'kmImissiveUnitListService&fdKeyWord=!{keyword}');
	</xform:dialog>
	</div>
	
	<script>
	$(document).ready(function(){
		var id = document.getElementsByName("fdReceiveUnitId")[0].value;
	   	var name = document.getElementsByName("fdReceiveUnitName")[0].value;
		initNewDialog("fdReceiveUnitId","fdReceiveUnitName",";","kmImissiveUnitListService&newSearch=true",false,id,name,null);
	});
	</script>
</c:otherwise>
</c:choose>	