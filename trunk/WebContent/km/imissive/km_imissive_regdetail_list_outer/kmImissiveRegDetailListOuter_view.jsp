<%@page import="java.util.ArrayList"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil,com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<template:include ref="default.view" sidebar="no">
    <template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/att.css" />
	</template:replace>
	<template:replace name="title">
		<c:out value="${ kmImissiveRegForm.fdName } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out> 
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar  id="toolbar" layout="sys.ui.toolbar.float" count="6">
		 <kmss:auth requestURL="/km/imissive/km_imissive_regdetail_list_outer/kmImissiveRegDetailListOuter.do?method=updateSign&fdId=${param.fdId}" requestMethod="GET">
			<c:choose>
				<c:when test="${kmImissiveRegDetailListOuterForm.fdRegType eq '2' }">
						<c:if test="${kmImissiveRegDetailListOuterForm.fdStatus!='2' and kmImissiveRegDetailListOuterForm.fdStatus!='3' and kmImissiveRegDetailListOuterForm.fdStatus!='4' and kmImissiveRegDetailListOuterForm.fdStatus!='5'}">
						    <ui:button text="${lfn:message('km-imissive:kmImissiveReg.updateSignReceive') }" order="1" onclick="updateSignReceive();">
							</ui:button>
							<ui:button text="${lfn:message('km-imissive:kmImissiveReg.updateSignSend') }" order="1" onclick="updateSignSend();">
							</ui:button>
						</c:if>
				</c:when>
				<c:otherwise>
					 <kmss:auth requestURL="/km/imissive/km_imissive_regdetail_list_outer/kmImissiveRegDetailListOuter.do?method=updateSign&fdId=${param.fdId}" requestMethod="GET">
						<c:if test="${kmImissiveRegDetailListOuterForm.fdStatus!='2' and kmImissiveRegDetailListOuterForm.fdStatus!='3' and kmImissiveRegDetailListOuterForm.fdStatus!='4' and kmImissiveRegDetailListOuterForm.fdStatus!='5'}">
						    <ui:button text="${lfn:message('km-imissive:kmImissiveReg.updateSign') }" order="1" onclick="updateSign();">
							</ui:button>
						</c:if>
					</kmss:auth>
				</c:otherwise>
			</c:choose>
			<%--非会签才允许直接签收--%>
			<c:if test="${kmImissiveRegDetailListOuterForm.fdRegDeliverType!='3' and kmImissiveRegDetailListOuterForm.fdStatus!='2' and kmImissiveRegDetailListOuterForm.fdStatus!='3' and kmImissiveRegDetailListOuterForm.fdStatus!='4'  and kmImissiveRegDetailListOuterForm.fdStatus!='5'}">
				 <ui:button text="${lfn:message('km-imissive:kmImissiveReg.updateSignOnly') }" order="1" onclick="updateSignOnly();">
				</ui:button>
			</c:if>
			<c:if test="${canReturn  and kmImissiveRegDetailListOuterForm.fdStatus!='2' and kmImissiveRegDetailListOuterForm.fdStatus!='3' and kmImissiveRegDetailListOuterForm.fdStatus!='4'  and kmImissiveRegDetailListOuterForm.fdStatus!='5'}">
			  <ui:button text="${lfn:message('km-imissive:kmImissiveReg.updateReturn') }" order="1" onclick="addBack();">
			  </ui:button>
			</c:if>
			
	   </kmss:auth>
		<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
		</ui:button>
		</ui:toolbar>
</template:replace>
<template:replace name="content">
<script>
Com_IncludeFile("dialog.js");
	seajs.use(['sys/ui/js/dialog'], function(dialog) {
		window.dialog=dialog;
	});
	window.updateSign = function(){
		 var url = "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceiveOuter&fddetaiId=${kmImissiveRegDetailListOuterForm.fdId}&fdTemplateId=!{id}";
         dialog.categoryForNewFile(
					'com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate',url,false,null,null,null,"_self",null,true);
	};
	
	
	window.updateSignSend = function(){
		 var url = "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=addSendOuter&fddetaiId=${kmImissiveRegDetailListOuterForm.fdId}&fdTemplateId=!{id}&isOuter=true";
    	 dialog.categoryForNewFile(
					'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',url,false,null,null,null,"_self",null,true);
  };
	window.updateSignReceive = function(){
		 var url = "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceiveOuter&fddetaiId=${kmImissiveRegDetailListOuterForm.fdId}&fdTemplateId=!{id}&isOuter=true";
         dialog.categoryForNewFile(
					'com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate',url,false,null,null,null,"_self",null,true);
  };
	
	window.updateSignOnly = function(){
		 dialog.confirm('<bean:message  bundle="km-imissive" key="kmImissiveRegDetailList.updateSignOnly.confirm"/>',function(flag){
			 if(flag==true){
				 var url = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=saveReceiveOnly&outer=true&fddetaiId=${kmImissiveRegDetailListOuterForm.fdId}";
				 $.ajax({     
			  	     url:url,     
			  	     async:false,    //用同步方式 
			  	     success:function(data){
			  	    	 location.reload();
			  	     }
			  	   });
			 }else{
				 return;
			 }
		 },"warn"); 
	};
	
	window.addBack = function(){
         var url = "${LUI_ContextPath}/km/imissive/km_imissive_regdetail_opinion/kmImissiveRegDetailOpinion.do?method=addOuter&fddetaiId=${kmImissiveRegDetailListOuterForm.fdId}&isOuter=true";
         window.open(url, "_self");
    };
	
	window.openReceiveDoc = function(){
		var url = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=view&fdId=${kmImissiveRegDetailListOuterForm.fdReceiveId}";
		if("${kmImissiveRegDetailListForm.fdSignType}" == '1'){
			url = "${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=${kmImissiveRegDetailListOuterForm.fdReceiveId}";
		}
		window.open(url);
	};
</script>
	<div class="lui_form_content_frame" style="padding-top:10px">
		<html:form action="/km/imissive/km_imissive_regdetail_list_outer/kmImissiveRegDetailListOuter.do"> 
			<input type="hidden" name="fdtempId"/>
			<input type="hidden" name="fdtempName"/>
			<input type="hidden" name="fdTableHead"/>
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
						<c:out value="${kmImissiveRegDetailListOuterForm.fdRegName}" />
					</td>
				</tr>
				 <tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdDocNum"/>
					</td>
					<td width=35%>
					    <c:if test="${empty kmImissiveRegDetailListOuterForm.fdRegNo}">
					          	${lfn:message("km-imissive:kmImissiveSendMain.fdDocNum.auto") }
					    </c:if>
					    <c:if test="${not empty kmImissiveRegDetailListOuterForm.fdRegNo}">
					              <c:out value="${kmImissiveRegDetailListOuterForm.fdRegNo}" />
					    </c:if>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.docCreateTime"/>
					</td>
					<td width=35%>
						<c:out value="${kmImissiveRegDetailListOuterForm.docCreateTime}"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.fdSendUnit"/>
					</td>
					<td width=35%>
						<c:out value="${kmImissiveRegDetailListOuterForm.fdFromUnitName}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.fdUnit"/>
					</td>
					<td width=35%>
						<c:out value="${kmImissiveRegDetailListOuterForm.fdUnitName}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.fdOrgNames"/>
					</td>
					<td width=35%>
						<c:out value="${kmImissiveRegDetailListOuterForm.fdOrgNames}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.fdStatus"/>
					</td>
					<td width=35%>
						 <sunbor:enumsShow value="${kmImissiveRegDetailListOuterForm.fdStatus}" enumsType="kmImissiveReg_status" bundle="km-imissive" />
					</td>
				</tr>
				<c:if test="${kmImissiveRegDetailListOuterForm.fdStatus eq '2' or kmImissiveRegDetailListOuterForm.fdStatus eq '4'}">
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-imissive" key="kmImissiveReg.fdLinkSubject"/>
						</td>
						<td width=85% colspan="3">
							<c:choose>
					            <c:when test="${not empty kmImissiveRegDetailListOuterForm.fdReceiveId}">
					              <a class="com_btn_link" href="javascript:void(0)" onclick="openReceiveDoc();">${ReceiveDocName}</a>
					            </c:when>
					            <c:otherwise>
					               <bean:message  bundle="km-imissive" key="kmImissiveReg.fdLinkSubject.null"/>
					            </c:otherwise>
				          </c:choose>
						</td>
					</tr>
				</c:if>
				<c:if test="${not empty kmImissiveRegDetailListOuterForm.fdDesc}">
					<tr>
						<td class="td_normal_title" width=15%>
							<c:if test="${kmImissiveRegDetailListOuterForm.fdRegDeliverType eq '1'}">
							   <bean:message  bundle="km-imissive" key="kmImissiveReg.opinion.distribute"/>
							</c:if>
							<c:if test="${kmImissiveRegDetailListOuterForm.fdRegDeliverType eq '2'}">
							   <bean:message  bundle="km-imissive" key="kmImissiveReg.opinion.report"/>
							</c:if>
						</td>
						<td width=85% colspan="3">
						   <c:out value="${kmImissiveRegDetailListOuterForm.fdDesc}"/>
						</td>
					</tr>
				</c:if>
				<c:if test="${not empty kmImissiveRegDetailListOuterForm.fdSignTime}">
					 <tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-imissive" key="kmImissiveReg.fdSignerName"/>
						</td>
						<td width=35%>
							<c:out value="${kmImissiveRegDetailListOuterForm.fdSignerName}"/>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-imissive" key="kmImissiveReg.fdSignTime"/>
						</td>
						<td width=35%>
							<c:out value="${kmImissiveRegDetailListOuterForm.fdSignTime}"/>
						</td>
					</tr>
				</c:if>
				<c:if test="${kmImissiveRegDetailListOuterForm.fdStatus eq '3' or kmImissiveRegDetailListOuterForm.fdStatus eq '4'}">
					<tr>
						<td class="td_normal_title" width=15%>
						<c:if test="${kmImissiveRegDetailListOuterForm.fdStatus eq '3'}">
							退回人
						</c:if>	
						<c:if test="${kmImissiveRegDetailListOuterForm.fdStatus eq '4'}">
							退文人
						</c:if>
						</td>
						<td width=35%>
							<c:out value="${returnPerson}"/>
						</td>
						<td class="td_normal_title" width=15%>
						<c:if test="${kmImissiveRegDetailListOuterForm.fdStatus eq '3'}">
							退回时间
						</c:if>	
						<c:if test="${kmImissiveRegDetailListOuterForm.fdStatus eq '4'}">
							退文时间
						</c:if>
						</td>
						<td width=35%>
							<c:out value="${returnTime}"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
						<c:if test="${kmImissiveRegDetailListOuterForm.fdStatus eq '3'}">
							<bean:message  bundle="km-imissive" key="kmImissiveReg.return.reason"/>
						</c:if>	
						<c:if test="${kmImissiveRegDetailListOuterForm.fdStatus eq '4'}">
							<bean:message  bundle="km-imissive" key="kmImissiveReg.returnDoc.reason"/>
						</c:if>
						</td>
						<td width=85% colspan="3">
							<c:out value="${docContent}"/>
						</td>
					</tr>
				</c:if>
				 <tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.attachment.content"/>
					</td>
					<td width=85% colspan="3">
					  <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegDetailListOuterForm" />
						<c:param name="fdKey" value="editonline" />
						<c:param name="fdModelId" value="${kmImissiveRegDetailListOuterForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveRegDetailListOuter" />
					  </c:import>
					</td>
				</tr>
				
				<tr>
					<td class="td_normal_title" width=15%>
						表单信息附件
					</td>
					<td width=85% colspan="3">
					  <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegDetailListOuterForm" />
						<c:param name="fdKey" value="baseInfoAtt" />
						<c:param name="fdModelId" value="${kmImissiveRegDetailListOuterForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveRegDetailListOuter" />
					  </c:import>
					</td>
				</tr>
				
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.attachment"/>
					</td>
					<td width=85% colspan="3">
					  <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegDetailListOuterForm" />
						<c:param name="fdKey" value="regAtt" />
						<c:param name="fdModelId" value="${kmImissiveRegDetailListOuterForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveRegDetailListOuter" />
					  </c:import>
					</td>
				</tr>
				
				<c:if test="${kmImissiveRegDetailListOuterForm.fdReadReviewOpinion eq '1'}">
					<tr>
						<td colspan="4" style="padding:0;">
							<div class="lui_form_subhead" style="padding:10px 8px ">原审批意见:</div> 
							<jsp:include page="/km/imissive/import/kmImissiveAuditNote_list.jsp">
								<jsp:param value="${kmImissiveRegDetailListOuterForm.fdId}" name="fdMainId"/>
								<jsp:param value="${kmImissiveRegDetailListOuterForm.fdRegDeliverType}" name="fdDeliverType"/>
								<jsp:param name="formBeanName" value="kmImissiveRegDetailListOuterForm"/>
								<jsp:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveRegDetailListOuter" />
								<jsp:param name="fdModelId" value="${kmImissiveRegDetailListOuterForm.fdId}" />
							</jsp:include>
						</td>
					</tr>
				</c:if>
			</table>
		</html:form>	
		</div>
</template:replace>
</template:include>
