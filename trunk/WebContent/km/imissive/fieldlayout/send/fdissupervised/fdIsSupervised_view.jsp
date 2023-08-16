<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%
	pageContext.setAttribute("fdSuperviseTemplateId", KmImissiveConfigUtil.getDefSuperviseTemplateId());
%>

<c:choose>
	<c:when test="${param.mobile ne 'true' and kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.addSupervise =='true'}">
		<xform:select property="fdIsSupervised" mobile="${param.mobile eq 'true'? 'true':'false'}" style="<%=parse.getStyle()%>" showStatus="edit" onValueChange="changeSupervised(this.value);">
			<xform:enumsDataSource  enumsType="kmMissive_fdIsSupervised"></xform:enumsDataSource>
		</xform:select>
		<%-- <ui:button text="纳入督办" id="superVisedBtn" style="vertical-align:top;display:none"  onclick="addToSupervised();"></ui:button>  --%>
		<script>
		
		//src先查找改文档有没纳入过督办，有则直接返回之前数据修改，否则创建一个督办form返回
		function changeSupervised(value){
			if(value == 'true'){
				if("${fdSuperviseTemplateId}" != ""){
					//$('#superVisedFrame').prop("src","${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main/kmSuperviseMain.do?method=editToSupervise&i.docTemplate=${fdSuperviseTemplateId}&modelId=${kmImissiveSendMainForm.fdId}&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain");
					$('#superVisedDiv').show();
					var myIframe=LUI("superVisedFrame");
					myIframe.src="${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main/kmSuperviseMain.do?method=editToSupervise&i.docTemplate=${fdSuperviseTemplateId}&modelId=${kmImissiveSendMainForm.fdId}&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain";
					myIframe.reload();
				}else{
					alert("请到后台参数设置设置默认督办模板");
				}
			}else{
				$('#superVisedFrame').prop("src","");
				$('#superVisedDiv').hide(); 
			}
		}
		window.onload = function(){
			if("${kmImissiveSendMainForm.fdIsSupervised}" == "true"){
				if("${fdSuperviseTemplateId}" != ""){
					$('#superVisedDiv').show();
					 var myIframe=LUI("superVisedFrame");
					 myIframe.src="${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main/kmSuperviseMain.do?method=editToSupervise&i.docTemplate=${fdSuperviseTemplateId}&modelId=${kmImissiveSendMainForm.fdId}&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain";
					 myIframe.reload();
					//$('#superVisedFrame').prop("src","${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main/kmSuperviseMain.do?method=editToSupervise&i.docTemplate=${fdSuperviseTemplateId}&modelId=${kmImissiveSendMainForm.fdId}&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain");
				}else{
					alert("请到后台参数设置设置默认督办模板");
				}
			}else{
				$('#superVisedDiv').hide();
			}
			//changeSupervised("${kmImissiveSendMainForm.fdIsSupervised}");
		}
		</script>
	</c:when>
	<c:otherwise>
		<xform:select property="fdIsSupervised" mobile="${param.mobile eq 'true'? 'true':'false'}" style="<%=parse.getStyle()%>" showStatus="view">
		   <xform:enumsDataSource  enumsType="kmMissive_fdIsSupervised"></xform:enumsDataSource>
		</xform:select>
	</c:otherwise>
</c:choose>
<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.confirmSupervise =='true'  and not empty fdSuperviseId and kmImissiveSendMainForm.fdSuperviseFlag ne true}">
	<ui:button text="核发督办" id="confirmSuperVisedBtn" style="vertical-align:top;"  onclick="confirmSupervised();"></ui:button>
</c:if>
 