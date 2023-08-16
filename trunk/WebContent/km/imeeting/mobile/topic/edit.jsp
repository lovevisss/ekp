<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingTopicUtil"%>
<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingTopicForm"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<%
	KmImeetingTopicForm kmImeetingTopicForm = (KmImeetingTopicForm)request
		.getAttribute("kmImeetingTopicForm");
	String isShowBtn = KmImeetingTopicUtil.isShowSumbitBtn(kmImeetingTopicForm);
	request.setAttribute("isShowBtn", isShowBtn);
%>
<template:include ref="mobile.edit" compatibleMode="true" tiny="true">
	<template:replace name="title">
		<c:if test="${empty  kmImeetingTopicForm.docSubject}">
			<bean:message bundle="km-imeeting" key="mobile.header.addTopic" />
		</c:if>
		<c:out value="${kmImeetingTopicForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="head">
		<mui:min-file name="mui-imeeting-edit.css"/>
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/edit_topic.css" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/edit.css" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/detailInput.css" />
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/imeeting/km_imeeting_topic/kmImeetingTopic.do">
			<div>
				<div data-dojo-type="mui/fixed/Fixed" data-dojo-props="fixedOrder:1" class="muiFlowEditFixed">
					<div data-dojo-type="mui/fixed/FixedItem">
						<div  data-dojo-type="mui/nav/NavBarStore" data-dojo-mixins="mui/nav/NavBarStepMixin,km/imeeting/mobile/topic/js/TopicEditNavMixin" id="_flowNav">
						</div>
					</div>
				</div>
			</div>
			<div data-dojo-type="mui/view/DocScrollableView" 
					data-dojo-mixins="mui/form/_ValidateMixin,mui/form/_AlignMixin" id="scrollView">
					<div class="muiFlowInfoW muiFormContent">
						<html:hidden property="fdId" />
						<html:hidden property="fdModelId" />
						<html:hidden property="fdModelName" />
						<html:hidden property="docStatus" />
						<html:hidden property="docCreateTime"/>
						<html:hidden property="method_GET" />
						<html:hidden property="fdIsOtherDraft" />
						
						<c:choose>
							<c:when test="${notXFormFilePath eq 'true'}">
								<c:import url="/km/imeeting/mobile/topic/import/topic_xform_default_edit_mobile.jsp"
									charEncoding="UTF-8">
								</c:import>
							</c:when>
							<c:otherwise>
								<table class="muiSimple" cellpadding="0" cellspacing="0">
		                             <tr>
		                                <td colspan="2">
											<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp" charEncoding="UTF-8">
												<c:param name="formName" value="kmImeetingTopicForm" />
												<c:param name="fdKey" value="mainTopic" />
												<c:param name="backTo" value="scrollView" />
											</c:import>
		                                </td>
		                            </tr>
								</table>
							</c:otherwise>
						</c:choose>
						
						<c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
							  <c:param name="formName" value="kmImeetingTopicForm" />
                       		  <c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
						</c:import>
					</div>
			
					<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" >
						<c:if test="${kmImeetingTopicForm.docStatusFirstDigit=='1'}">
							<li data-dojo-type="mui/tabbar/TabBarButton" 
								  data-dojo-props="colSize:2,onClick:function(){topic_submit('saveDraft');}">
								<bean:message  bundle="km-review"  key="button.draft" />
							</li>
						</c:if>
					  	<li data-dojo-type="mui/tabbar/TabBarButton"
					  			data-dojo-props='colSize:4,moveTo:"lbpmView",transition:"slide"'>
					  		<bean:message  bundle="km-imeeting"  key="button.next" />
					  	</li>
					</ul>
				</div>
				
				<c:choose>
					<c:when test="${isShowBtn eq 'true'}">
						<c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImeetingTopicForm" />
							<c:param name="fdKey" value="mainTopic" />
							<c:param name="viewName" value="lbpmView" />
							<c:param name="backTo" value="scrollView" />
							<c:param name="onClickSubmitButton" value="topic_submit();" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImeetingTopicForm" />
							<c:param name="fdKey" value="mainTopic" />
							<c:param name="viewName" value="lbpmView" />
							<c:param name="backTo" value="scrollView" />
						</c:import>
					</c:otherwise>
				</c:choose>
				<script type="text/javascript">
					require(["mui/form/ajax-form!kmImeetingTopicForm"]);
					require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
					         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip'], 
						function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip){
							window.topic_submit = function(method){
								var validorObj = registry.byId('scrollView');
								if(!validorObj.validate()){
									return;
								}
								var status = document.getElementsByName("docStatus")[0];
								var urlMethod = Com_GetUrlParameter(location.href,'method');
								var isPublish = "${kmImeetingTopicForm.docStatusFirstDigit >= '3'}";
								if ("true" != isPublish && "saveDraft" != method) {
									query('[name="docStatus"]').val('20');
								}
								if (urlMethod=='add') {
									Com_Submit(document.forms[0],'save');
								} else {
									Com_Submit(document.forms[0],'update');
								}
							};
					 });
				</script>
			</div>
		</html:form>
	</template:replace>
</template:include>
