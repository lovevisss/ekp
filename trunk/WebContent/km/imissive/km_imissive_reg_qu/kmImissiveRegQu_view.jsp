<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<template:include ref="default.view" sidebar="no">
	<template:replace name="title">
		<c:out value="${ kmImissiveRegForm.fdName } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out> 
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar  id="toolbar" layout="sys.ui.toolbar.float" count="3">
		<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
		</ui:button>
		</ui:toolbar>
</template:replace>
<template:replace name="content">
<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/jquery.qtip.css" />
<script language="JavaScript">
	Com_IncludeFile("jquery.js");
</script>
	<%
	   request.setAttribute("userId",UserUtil.getUser().getFdId()); 
	%>
	<div class="lui_form_content_frame" style="padding-top:10px">
		<html:form action="/km/imissive/km_imissive_reg/kmImissiveReg.do"> 
			<input type="hidden" name="fdtempId"/>
			<input type="hidden" name="fdtempName"/>
		    <table class="tb_normal" width=100%>
			   <html:hidden property="fdId"/>
			    <tr>
					<td class="td_normal_title" colspan="4">
						 <p class="txttitle"><bean:message key="table.kmImissiveReg" bundle="km-imissive" /></p>
					</td>
				</tr>
			   <tr>
					<td class="td_normal_title" width=15%>
						<bean:message key="kmImissiveReg.fdName" bundle="km-imissive" />
					</td>
					<td width=35% colspan="3">
						<c:if test="${userId eq kmImissiveRegForm.docCreatorId}">
						  <a class="com_btn_link" href="javascript:void(0)" onclick="openDoc();">
						</c:if>
						<c:out value="${kmImissiveRegForm.fdName}" />
						<c:if test="${userId eq kmImissiveRegForm.docCreatorId}">
						  </a>
						</c:if>
					</td>
				</tr>
				 <tr>
					<td class="td_normal_title" width=15%>
					   <bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdDocNum"/>
					</td>
					<td width=35%>
						<c:if test="${empty kmImissiveRegForm.fdNo}">
					          	${lfn:message("km-imissive:kmImissiveSendMain.fdDocNum.auto") }
					    </c:if>
					    <c:if test="${not empty kmImissiveRegForm.fdNo}">
					          <c:out value="${kmImissiveRegForm.fdNo}" />
					    </c:if>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.docCreateTime"/>
					</td>
					<td width=35%>
						<c:out value="${kmImissiveRegForm.docCreateTime}"/>
					</td>
				</tr>
				<c:if test="${not empty kmImissiveRegForm.fdDesc}">
					<tr>
						<td class="td_normal_title" width=15%>
							<c:if test="${kmImissiveRegForm.fdDeliverType eq '1'}">
							   <bean:message  bundle="km-imissive" key="kmImissiveReg.opinion.distribute"/>
							</c:if>
							<c:if test="${kmImissiveRegForm.fdDeliverType eq '2'}">
							   <bean:message  bundle="km-imissive" key="kmImissiveReg.opinion.report"/>
							</c:if>
						</td>
						<td width=85% colspan="3">
						   <c:out value="${kmImissiveRegForm.fdDesc}"/>
						</td>
					</tr>
				</c:if>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.attachment.content"/>
					</td>
					<td width=85% colspan="3">
					  <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
								charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="${kmImissiveRegForm.fdId}" />
					  </c:import>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.attachment"/>
					</td>
					<td width=85% colspan="3">
					  <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
								charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="regAtt" />
					  </c:import>
					</td>
				</tr>
			</table>
			<br>
			<table class="tb_normal" width=100%>
				<tr>
					<td colspan="4" style="border:none">
						<div style="margin-top: 15px;">
							<center>
								<div>
									 <b><bean:message  bundle="km-imissive" key="kmImissiveReg.signRecord"/>
									 </b>
								 </div>
							 </center>
							 <div style="height: 15px;"></div>
							 <c:choose>
								<c:when test="${kmImissiveRegForm.fdRegType eq '2' }">
									<iframe  width="100%" style="margin-bottom: -4px;border: none;" src="<c:url value="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote.do?method=listNote&fdModelId=${kmImissiveRegForm.fdReceiveMainId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&formBeanName=kmImissiveReceiveMainForm" />" scrolling="no" FRAMEBORDER=0></iframe>
								</c:when>
								<c:otherwise>
									<iframe  width="100%" style="margin-bottom: -4px;border: none;" src="<c:url value="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote.do?method=listNote&fdModelId=${kmImissiveRegForm.fdSendMainId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain&formBeanName=kmImissiveSendMainForm" />" scrolling="no" FRAMEBORDER=0></iframe>
								</c:otherwise>
							</c:choose>
						</div>
					</td>
				</tr>
			</table>
			<br>
			<table class="tb_normal" width=100%>
			    <tr>
					<td colspan="5">
						 <div style="margin-top: 15px;">
						 <center>
						     <div>
								 <b><bean:message  bundle="km-imissive" key="kmImissiveReg.feedback.Record"/>
								 </b>
							 </div>
						 </center>
						 <div style="margin-right:10px;text-align:right" id="distributeBtn">
						 	<xform:select property="fdStatus" showStatus="edit" onValueChange="changeStatus(this.value);">	
						 		<xform:enumsDataSource enumsType="kmImissiveReg_status"></xform:enumsDataSource>
						 	</xform:select>
					    </div>
					   </div>
					 	<div style="height: 15px;"></div>
					   <list:listview id="regListview" channel="distribute">
							<ui:source type="AjaxJson">
								{"url":"/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&deliver=true&fdRegId=${kmImissiveRegForm.fdId}"}
							</ui:source>
							<list:colTable  isDefault="true" layout="sys.ui.listview.listtable" cfg-norecodeLayout="simple" id="distributeT">
								<list:col-auto props="fdUnit.fdName;fdOrgNames;fdStatus;kmImissiveRegDetailList.fdReg.fdDeliverType"></list:col-auto>
							</list:colTable>	
						</list:listview>
						<div style="height: 15px;"></div>
						<list:paging layout="sys.ui.paging.simple" channel="distribute"></list:paging>
					</td>
				</tr>
			</table>
		</html:form>	
		</div>
<script type="text/javascript" src="${LUI_ContextPath}/km/imissive/resource/js/jquery.qtip.js" charset="UTF-8"></script>
<script type="text/javascript" src="${LUI_ContextPath}/km/imissive/resource/js/hogan.js" charset="UTF-8"></script>
<!-- 模板 -->
<script id="equipInfo-Template" type="text/template">
<div style="overflow:hidden;width:200px;">
<ul>
 <li style="font-size:12px;margin-bottom:5px">退回意见:{{fdContent}}</li>
 <li style="font-size:12px;margin-bottom:5px">退回人:{{docCreator}}</li>
 <li style="font-size:12px;margin-bottom:5px">退回单位:{{fdUnitName}}</li>
 <li style="font-size:12px;margin-bottom:5px">退回时间:{{docCreateTime}}</li>
</ul>
</div>
</script>
<script>
function openDoc(){
		var url = "${LUI_ContextPath}${kmImissiveRegForm.fdLink}";
		window.open(url);
}
 function ccc(){
	var source = $("#equipInfo-Template").html();  
	var template = Hogan.compile(source);
	$(".aaa").each(function(){
		$(this).qtip({
			content: {
				text: 'Loading...',
				ajax: {
					url: "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_return_opinion/kmImissiveReturnOpinion.do?method=loadOpinionById&fdDetailId="+this.id,
					type: 'GET', // POST or GET
					dataType:"json",
					success: function(data, status) {
						this.set('content.text', template.render(data));
					}
				}
			},
		    position: {
				my: 'bottom left',  
                at: 'top center',
			    effect: false,
			    target: 'mouse'
			}
		})
	});
  }
  $(document).ready(function(){
	  ccc();
 });
  function changeStatus(fdStatus){
		var url= Com_GetCurDnsHost()+Com_Parameter.ContextPath+"km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&deliver=true&fdRegId=${kmImissiveRegForm.fdId}&fdStatus="+fdStatus;
		LUI('regListview').source.setUrl(url);
		LUI('regListview').source.get();
	}
  
</script>
</template:replace>
</template:include>
