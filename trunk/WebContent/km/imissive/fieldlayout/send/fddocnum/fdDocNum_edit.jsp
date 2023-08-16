<%-- 发文文号 --%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%@ include file="/resource/jsp/common.jsp"%>
<html:hidden property="fdDocNum" />
<html:hidden property="fdFlowNo" />
<html:hidden property="fdNoRule" />
<html:hidden property="fdNumberMainId" />
<html:hidden property="fdYearNo" />
<%
    //SysFieldsParamsParse parse = new SysFieldsParamsParse(request).parse();
	parse.addStyle("width", "control_width", "auto");
	required = Boolean.parseBoolean(parse.getParamValue("control_required", "false"));
	request.setAttribute("required", required);
%>
<script> 

//提交时校验的数组
var kmImissiveEvent = kmImissiveEvent || new Array;
<c:if test="${nodeExtAttributeMap['modifyDocNum4Draft'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'on' or kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true'}">
	kmImissiveEvent.push(function(){
		 var dtd = $.Deferred();
		var docNum = document.getElementsByName("fdDocNum")[0];
		if("${required}" == 'true'){
			if(docNum.value != ""){
				dtd.resolve();
			}else{
				dialog.alert("请进行文件编号操作！");
				dtd.reject();
			}
		}else{
			if(docNum.value == ""){
				dialog.confirm('<bean:message key="kmImissive.number.notNull" bundle="km-imissive" />',function(rtn){
					if(rtn==true){ 
						if("${fdNoId}" != ""){
						    generateAutoNum();
						    dtd.resolve();
						}else{
							 dtd.resolve();
						}
					}else{
						dtd.reject();
					}
				});
			}else{
				 dtd.resolve();
			}
		}
		return dtd;
	});
</c:if>

</script>
<c:choose>
    <c:when test="${nodeExtAttributeMap['modifyDocNum4Draft'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'on' or kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true'}">
		<span id="docnum"> 
		  <c:if test="${not empty kmImissiveSendMainForm.fdDocNum}">
		   <c:out value="${kmImissiveSendMainForm.fdDocNum}"/>
		  </c:if>
		  <c:if test="${empty kmImissiveSendMainForm.fdDocNum and required != 'true'}">
		    <bean:message  bundle="km-imissive" key="kmImissiveSendMain.docNum.info.submit"/>
		  </c:if>
		</span>
		<span>
			<c:choose>
	  			<c:when test="${param.mobile eq 'true'}">
	  				<div data-dojo-type="mui/tabbar/TabBarButton" class="docNumBtn" data-dojo-props='moveTo:"_modifyDocNumView",transition:"slide"' onclick="optGetNum();">
						文件编号
					</div>
	  			</c:when>
	  			<c:otherwise>
	  				<ui:button text="${lfn:message('km-imissive:kmImissive.modifyDocNum') }" order="3"
						 onclick="generateFileNum();">
					 </ui:button>
	  			</c:otherwise>
	  		</c:choose>	
		</span>
	</c:when>
	<c:otherwise>
	     <c:if test="${not empty kmImissiveSendMainForm.fdDocNum}">
		   <c:out value="${kmImissiveSendMainForm.fdDocNum}"/>
		</c:if>
		 <c:if test="${empty kmImissiveSendMainForm.fdDocNum}">
		   <bean:message  bundle="km-imissive" key="kmImissiveSendMain.docNum.info"/>
		</c:if>
	</c:otherwise>
</c:choose>

