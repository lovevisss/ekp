<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${kmImissiveSignMainForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/imissive/mobile/resource/css/detail.css?s_cache=${MUI_Cache}"></link>
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/imissive/km_imissive_reg/kmImissiveReg.do">		
		<%
		   request.setAttribute("userId",UserUtil.getUser().getFdId()); 
		%>
		<div id="scrollView" 
			data-dojo-type="mui/view/DocScrollableView"
			data-dojo-mixins="mui/form/_ValidateMixin">
			<div data-dojo-type="mui/panel/AccordionPanel">
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message key="table.kmImissiveReg" bundle="km-imissive" />',icon:'mui-ul'">
				   <div class="muiFormContent">
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td class="muiTitle">
									<bean:message key="kmImissiveReg.fdName" bundle="km-imissive" />
								</td><td>
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
								<td class="muiTitle">
									 <bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdDocNum"/>
								</td><td>
									<c:if test="${empty kmImissiveRegForm.fdNo}">
								          	${lfn:message("km-imissive:kmImissiveSendMain.fdDocNum.auto") }
								    </c:if>
								    <c:if test="${not empty kmImissiveRegForm.fdNo}">
								          <c:out value="${kmImissiveRegForm.fdNo}" />
								    </c:if>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.docCreateTime"/>
								</td>
								<td>
									<c:out value="${kmImissiveRegForm.docCreateTime}"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message  bundle="km-imissive" key="kmImissiveReg.attachment.content"/>',icon:'mui-ul'">
				    <c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="${kmImissiveRegForm.fdId}" />
					</c:import>
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="convert_toPDF" />
					</c:import>
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="convert_toOFD" />
					</c:import>
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="ofdSursenSign" />
					</c:import>
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="ofdCySign" />
					</c:import>
				</div>
				<c:if test="${not empty kmImissiveRegForm.attachmentForms['editonline'].attachments}">
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message  bundle="km-imissive" key="kmImissiveReg.attachment"/>',icon:'mui-ul'">
					    <c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImissiveRegForm" />
							<c:param name="fdKey" value="regAtt" />
						</c:import>
					</div>
				</c:if>
				<%--明细 --%>
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message  bundle="km-imissive" key="kmImissiveReg.feedback.Record"/>',icon:'mui-ul'" style="padding: 10px;">
					<div data-dojo-type="mui/table/ScrollableHContainer">
			          <div data-dojo-type="mui/table/ScrollableHView">
						<table class="detailTableNormal" border="0" cellspacing="0" cellpadding="0">
					    <tr>
						<td class="detailTableNormalTd">
					      <table class="muiNormal" width="100%" border="0" cellspacing="0" cellpadding="0">
							 <tr>
								<td>
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdOrder"/>
								</td>
								<td>
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdUnit"/>
								</td>
								<td>
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdOrgNames"/>
								</td>
								<td>
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdStatus"/>
								</td>
								<td>
									<bean:message  bundle="km-imissive" key="kmImissiveReg.from"/>
								</td>
							</tr>
							<c:forEach items="${kmImissiveRegForm.fdDetailListForms}" var="fdDetailListForm" varStatus="vstatus">
								<c:if test="${(fn:contains(fdDetailListForm.fdOrgIds,userId)) or (userId eq kmImissiveRegForm.docCreatorId)}">
									<tr>
										<td>
											${vstatus.index+1}
										</td>
										<td>
											${fdDetailListForm.fdUnitName}
										</td>
										<td>
											${fdDetailListForm.fdOrgNames}
										</td>
										<td>
											 <c:if test="${fdDetailListForm.fdStatus != '3'}">
									            <sunbor:enumsShow value="${fdDetailListForm.fdStatus}" enumsType="kmImissiveReg_status" bundle="km-imissive" />
											 </c:if>
											 <c:if test="${fdDetailListForm.fdStatus eq '3'}">
												<div class="aaa com_btn_link" style="cursor:pointer" id="${fdDetailListForm.fdId}"><bean:message  bundle="km-imissive" key="status.return"/></div>
											 </c:if>
										</td>
										<td>
											 <sunbor:enumsShow value="${fdDetailListForm.fdRegDeliverType}" enumsType="kmImissiveRegDetailList_type" bundle="km-imissive" />
						                     <sunbor:enumsShow value="${fdDetailListForm.fdType}" enumsType="kmImissiveRegDetailList_unittype" bundle="km-imissive" />
										</td>
									</tr>
								</c:if>
						  </c:forEach>
						 </table>
						</td>
					</tr>
				 </table>
			    </div>
			  </div>
			</div>
			<c:if test="${kmImissiveRegForm.fdReadSendOpinion eq '1' and kmImissiveRegForm.fdReadReviewOpinion eq '1'}">
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message  bundle="km-imissive" key="kmImissiveReg.signRecord"/>',icon:'mui-ul'">
				   <c:choose>
						<c:when test="${kmImissiveRegForm.fdRegType eq '2' }">
							<c:set var="fdModelId" value="${kmImissiveRegForm.fdReceiveMainId}" scope="request"/>
							<c:set var="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" scope="request"/>
							<c:set var="formBeanName" value="kmImissiveReceiveMainFormx" scope="request"/>
						</c:when>
						<c:otherwise>
							<c:set var="fdModelId" value="${kmImissiveRegForm.fdSendMainId}" scope="request"/>
							<c:set var="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" scope="request"/>
							<c:set var="formBeanName" value="kmImissiveSendMainFormx" scope="request"/>
						</c:otherwise>
					</c:choose>
					<c:import url="/km/imissive/mobile/import/kmImissiveReg_listNote.jsp" charEncoding="UTF-8">
						<c:param name="fdMainId" value="${fdModelId}" />
						<c:param name="fdModelName" value="${fdModelName}" />
						<c:param name="formBeanName" value="${formBeanName}"/>
						<c:param name="fdRegId" value="${kmImissiveRegForm.fdId}" />
					</c:import>
				</div>
			</c:if>
		   </div>
		<script>
			require(["mui/form/ajax-form!kmImissiveSignMainForm"]);
		</script>
	</html:form>
	</template:replace>
</template:include>
<script type="text/javascript" >
function openDoc(){
		var url = "${LUI_ContextPath}${kmImissiveRegForm.fdLink}";
		window.open(url);
}
</script>
