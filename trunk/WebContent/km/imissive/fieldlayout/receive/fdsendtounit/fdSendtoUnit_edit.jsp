<%-- 发文单位 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%parse.addStyle("width", "control_width", "45%");
  required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));%>
  
<c:choose>
    <c:when test="${param.mobile eq 'true'}">
    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
	    	 data-dojo-props='"afterSelect":function(evt){afterSelectSend(evt);},"idField":"fdSendtoUnitId","nameField":"fdSendtoUnitName","curIds":"${kmImissiveReceiveMainForm.fdSendtoUnitId}","curNames":"${kmImissiveReceiveMainForm.fdSendtoUnitName}","subject":"来文单位","title":"来文单位","showStatus":"edit","isMul":false,"validate":"required","required":<%=required%>,
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
	<div id="_fdSendtoUnit" valField="fdSendtoUnitId" xform_type="dialog">
	<xform:dialog 
	       propertyId="fdSendtoUnitId" 
	       propertyName="fdSendtoUnitName"
	       useNewStyle="true"
	       style="<%=parse.getStyle()%>" 
	       className="inputsgl"
	       required="<%=required%>" 
	       subject="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdSendtoDept') }">
		   Dialog_UnitTreeList(false, 'fdSendtoUnitId', 'fdSendtoUnitName', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}',
		                          '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>', 
		                          'kmImissiveUnitListService&parentId=!{value}',null,'kmImissiveUnitListService&fdKeyWord=!{keyword}');
	</xform:dialog>
	</div>
	</div>
	<div id="outer" style="display:none">
		<div id="_fdOutSendto" valField="fdOutSendto" xform_type="text">
		<xform:text property="fdOutSendto" 
		            style="<%=parse.getStyle()%>" 
		            className="inputsgl"
		            required="<%=required%>" 
		            subject="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdSendtoDept') }"/>
		 </div>			 
	</div>
	<div style="display:none">
	<input type="checkbox" id="outerUnit" onclick="SetIfRequired();"/><bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdOutSendtoDept"/>
	</div>
	<script>
	$(document).ready(function(){
		var id = document.getElementsByName("fdSendtoUnitId")[0].value;
	   	var name = document.getElementsByName("fdSendtoUnitName")[0].value;
		initNewDialog("fdSendtoUnitId","fdSendtoUnitName",";","kmImissiveUnitListService&newSearch=true",false,id,name,null);
	});
	</script>
	<script>
		function SetIfRequired(){
			var outerUnit=document.getElementById("outerUnit");
			var outer = document.getElementById("outer");
			var inner = document.getElementById("inner");
			var fdSendtoUnitId = document.getElementsByName("fdSendtoUnitId")[0];
			var fdSendtoUnitName = document.getElementsByName("fdSendtoUnitName")[0];
			var fdOutSendto = document.getElementsByName("fdOutSendto")[0];
			if(outerUnit.checked){
				 outer.style.display="inline";
				 inner.style.display="none";	
		         fdSendtoUnitId.value="";
		         fdSendtoUnitName.value="";	
				document.getElementsByName("fdOutSendto")[0].setAttribute("validate","required maxLength(100)");
				document.getElementsByName("fdSendtoUnitName")[0].setAttribute("validate","");
				if(document.getElementById("advice-fdSendtoUnitName")){		
					document.getElementById("advice-fdSendtoUnitName").style.display="none";	
			    }
				var _validate_serial=fdSendtoUnitName.getAttribute("__validate_serial");
				if(document.getElementById('advice-'+_validate_serial)){		
					document.getElementById('advice-'+_validate_serial).style.display="none";	
				}
				
			}else{
				outer.style.display="none";
				inner.style.display="inline";
				fdOutSendto.value="";
				document.getElementsByName("fdOutSendto")[0].setAttribute("validate","");
				//document.getElementsByName("fdSendtoUnitName")[0].setAttribute("validate","required");
				if(document.getElementById("advice-fdOutSendto")){		
					document.getElementById("advice-fdOutSendto").style.display="none";	
			    }
	
				var _validate_serial=fdOutSendto.getAttribute("__validate_serial");
				if(document.getElementById('advice-'+_validate_serial)){		
					document.getElementById('advice-'+_validate_serial).style.display="none";	
				}
			}
		}
		Com_AddEventListener(window, "load", function() {
			var fdOutSendto = document.getElementsByName("fdOutSendto")[0];
			if(fdOutSendto.value!=null&&fdOutSendto.value!=""){
				document.getElementById("outerUnit").checked="true";
			}
			SetIfRequired();
			});
	</script>
	</c:otherwise>
</c:choose>	