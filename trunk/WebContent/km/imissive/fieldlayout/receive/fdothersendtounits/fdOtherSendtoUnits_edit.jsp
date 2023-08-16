<%-- 发文单位 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%parse.addStyle("width", "control_width", "45%");
	required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));
%>
  
<c:choose>
    <c:when test="${param.mobile eq 'true'}">
		<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
	    	 data-dojo-props='"afterSelect":function(evt){afterSelectSend(evt);},"idField":"fdOtherSendtoUnitsIds","nameField":"fdOtherSendtoUnitsNames","curIds":"${kmImissiveReceiveMainForm.fdOtherSendtoUnitsIds}","curNames":"${kmImissiveReceiveMainForm.fdOtherSendtoUnitsNames}","subject":"其他发文单位","title":"其他发文单位","showStatus":"edit","isMul":true,"validate":"required","required":false,
	   		  "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileDataBeanService&parentId=!{parentId}",
	   		  "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileDataBeanService&parentId=searchUnit&amp;fdKeyWord=!{keyword}",
	   		  "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   	  "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
		</div>
		<script>
			function afterSelectSend(evt){
				console.log(evt);
			}
		</script>
    </c:when>
    <c:otherwise>  
		<div id="inner" style="display: inline">
			<div id="_fdOtherSendtoUnits" valField="fdOtherSendtoUnitsIds" xform_type="dialog">
			<xform:dialog propertyId="fdOtherSendtoUnitsIds"
				          propertyName="fdOtherSendtoUnitsNames" 
				          style="<%=parse.getStyle()%>" 
				          className="inputsgl"
                          useNewStyle="true"
				          subject="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdOtherSendtoUnits') }">
				           Dialog_UnitTreeList(true, 'fdOtherSendtoUnitsIds', 'fdOtherSendtoUnitsNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}',
					      '<bean:message key="kmImissiveReceiveMain.fdOtherSendtoUnits" bundle="km-imissive" />', 'kmImissiveUnitListService&parentId=!{value}');
			</xform:dialog>
			</div>
			<script>
				$(document).ready(function(){
					var ids = document.getElementsByName("fdOtherSendtoUnitsIds")[0].value;
				   	var names = document.getElementsByName("fdOtherSendtoUnitsNames")[0].value;
					initNewDialog("fdOtherSendtoUnitsIds","fdOtherSendtoUnitsNames",";","kmImissiveUnitListService&newSearch=true",true,ids,names,null);
				});
			</script>
		</div>
	</c:otherwise>
</c:choose>	