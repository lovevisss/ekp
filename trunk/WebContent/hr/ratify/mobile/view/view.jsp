<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<template:include ref="mobile.view" compatibleMode="true" >
	<template:replace name="loading">
		<c:import url="/hr/ratify/mobile/view/view_banner.jsp" charEncoding="UTF-8">
			<c:param name="formBeanName" value="hrRatifyPositiveForm"></c:param>
			<c:param name="loading" value="true"></c:param>
		</c:import>
	</template:replace>
	<template:replace name="title">
		<c:out value="${hrRatifyPositiveForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="head">
	   <mui:cache-file name="mui-review-view.css" cacheType="md5"/>
	   <script type="text/javascript">
	   	require(["dojo/store/Memory","dojo/topic",'dijit/registry'],function(Memory, topic, registry){
	   		window._narStore = new Memory({data:[{'text':'<bean:message bundle="hr-ratify" key="mui.kmReviewMain.mobile.info" />',
	   			'moveTo':'_contentView','selected':true},{'text':'<bean:message bundle="hr-ratify" key="mui.kmReviewMain.mobile.note" />',
	   			'moveTo':'_noteView'}]});
	   		var previousY = null;
	   		topic.subscribe("/mui/navitem/_selected",function(evtObj){
	   			setTimeout(function(){
	   				if(evtObj && evtObj.tabIndex === 1){
	   					var scrollview = registry.byId('scrollView');
	   					previousY = scrollview.getPos().y;
	   				}
	   				topic.publish("/mui/list/resize");
	   				if(evtObj && evtObj.tabIndex === 0 && previousY){
	   					var scrollview = registry.byId('scrollView');
	   					scrollview.scrollTo({ y : previousY  });
	   					//通知Fixed组件
	   					topic.publish('/mui/list/_runSlideAnimation',scrollview,{
	   						from : { y : 0 },
	   						to : { y : previousY }
	   					})
	   				}
	   			},150);
	   		});
	   	});
	   </script>
	</template:replace>
	<template:replace name="content">
		<html:form action="/hr/ratify/hr_ratify_positive/hrRatifyPositive.do">		
		<div id="scrollView"
			data-dojo-type="mui/view/DocScrollableView"
			data-dojo-mixins="mui/form/_ValidateMixin" class="muiFlowBack">
			
			<c:import url="/hr/ratify/mobile/view/view_banner.jsp" charEncoding="UTF-8">
				<c:param name="formBeanName" value="hrRatifyPositiveForm"></c:param>
			</c:import>
			<c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="hrRatifyPositiveForm" />
				<c:param name="moduleModelName" value="com.landray.kmss.km.review.model.KmReviewMain" />
			</c:import>
			<c:import url="/sys/relation/mobile/edit_hidden.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="hrRatifyPositiveForm" />
			</c:import>
	<%-- 		<c:import url="/sys/agenda/mobile/edit_hidden.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="hrRatifyPositiveForm" />
			</c:import> --%>
			<c:import url="/sys/authorization/mobile/edit_hidden.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="hrRatifyPositiveForm" />
			</c:import>
			<%-- 支持移动端查阅 --%>
			<%-- <c:if test="${'true' eq hrRatifyPositiveForm.fdIsMobileView}"> --%>
			
				<div class="muiFlowInfoW">
					<div data-dojo-type="mui/fixed/Fixed" id="fixed">
						<div data-dojo-type="mui/fixed/FixedItem" class="muiFlowFixedItem">
							<div data-dojo-type="mui/nav/NavBarStore" data-dojo-props="store:_narStore">
							</div>
						</div>
					</div>
					<div data-dojo-type="dojox/mobile/View" id="_contentView">
						<c:if test="${hrRatifyPositiveForm.docUseXform == 'false'}">
					<%-- 		<c:choose> --%>
							<%-- 	<c:when test="${hrRatifyPositiveForm.fdUseWord == 'true'}">
									<c:import url="/sys/attachment/mobile/import/viewContent.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="hrRatifyPositiveForm"></c:param>
										<c:param name="fdKey" value="mainContent"></c:param>
									</c:import> 
								</c:when> --%>
							<%-- 	<c:otherwise> --%>
									<div class="muiFormContent">
										<br/>
										<xform:rtf property="docContent" mobile="true"></xform:rtf>
										<br/>
										<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
											<c:param name="formName" value="hrRatifyPositiveForm"></c:param>
											<c:param name="fdKey" value="fdAttachment"></c:param>
										</c:import> 
										<br/>
									</div>
								<%-- </c:otherwise> --%>
						<%-- 	</c:choose> --%>
						</c:if>
						<c:if test="${hrRatifyPositiveForm.docUseXform == 'true' || empty hrRatifyPositiveForm.docUseXform}">
							<div data-dojo-type="mui/table/ScrollableHContainer">
								<div data-dojo-type="mui/table/ScrollableHView" class="muiFormContent">
									<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp"
										charEncoding="UTF-8">
										<c:param name="formName" value="hrRatifyPositiveForm" />
										<c:param name="fdKey" value="reviewMainDoc" />
										<c:param name="backTo" value="scrollView" />
									</c:import>
								</div>
							</div>
						</c:if>
					</div>
					<div data-dojo-type="km/review/mobile/resource/js/DelayView" id="_noteView">
						<div class="muiFormContent">
							<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
								<c:param name="fdModelId" value="${hrRatifyPositiveForm.fdId }"/>
								<c:param name="fdModelName" value="com.landray.kmss.km.review.model.KmReviewMain"/>
								<c:param name="formBeanName" value="hrRatifyPositiveForm"/>
							</c:import>
							<xform:isExistRelationProcesses relationType="parent">
								<xform:showParentProcesse mobile="true" />
							</xform:isExistRelationProcesses>
								
							<xform:isExistRelationProcesses relationType="subs">
								<xform:showSubProcesses mobile="true"/>
							</xform:isExistRelationProcesses>
						</div>
					</div>
				</div>
			
			
			<template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp" 
							editUrl="/km/review/km_review_main/kmReviewMain.do?method=edit&fdId=${param.fdId }"
							formName="hrRatifyPositiveForm"
							viewName="lbpmView"
							allowReview="true">
				<template:replace name="flowArea">
				<%-- 	<c:if test="${'true' eq hrRatifyPositiveForm.fdIsMobileView}">
						<c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
						  <c:param name="fdModelName" value="${hrRatifyPositiveForm.modelClass.name}"/>
						  <c:param name="fdModelId" value="${hrRatifyPositiveForm.fdId}"/>
						  <c:param name="fdSubject" value="${hrRatifyPositiveForm.docSubject}"/>
						  <c:param name="showOption" value="label"></c:param>
						</c:import>
					</c:if> --%>
					<%--传阅 --%>
					<%-- <c:if test="${'true' eq hrRatifyPositiveForm.fdCanCircularize }"> --%>
					 	<c:import url="/sys/circulation/mobile/import/view.jsp" charEncoding="UTF-8">
							 <c:param name="formName" value="hrRatifyPositiveForm"></c:param>
							 <c:param name="showOption" value="label"></c:param>
					 	</c:import>
					<%-- </c:if> --%>
					<%-- <c:if test="${'true' eq hrRatifyPositiveForm.fdIsMobileView}">
						<c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
					  		<c:param name="formName" value="hrRatifyPositiveForm"/>
					  		 <c:param name="showOption" value="label"></c:param>
					  	</c:import>
					</c:if> --%>
				</template:replace>
				<template:replace name="publishArea">
					<c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
					  <c:param name="fdModelName" value="${hrRatifyPositiveForm.modelClass.name}"/>
					  <c:param name="fdModelId" value="${hrRatifyPositiveForm.fdId}"/>
					  <c:param name="fdSubject" value="${hrRatifyPositiveForm.docSubject}"/>
					  <c:param name="showOption" value="label"></c:param>
					</c:import>
					<%--传阅 --%>
					<%-- <c:if test="${'true' eq hrRatifyPositiveForm.fdCanCircularize }"> --%>
					 	<c:import url="/sys/circulation/mobile/import/view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="hrRatifyPositiveForm"></c:param>
							 <c:param name="showOption" value="label"></c:param>
					 	</c:import>
				<%-- 	</c:if> --%>
					<%-- <c:if test="${'true' eq hrRatifyPositiveForm.fdIsMobileView}"> --%>
						<c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
					  		<c:param name="formName" value="hrRatifyPositiveForm"/>
					  		 <c:param name="showOption" value="label"></c:param>
					  	</c:import>
					<%-- </c:if> --%>
				</template:replace>
			</template:include>
		</div>
		<%-- 支持移动端查阅 --%>
		<%-- <c:if test="${'true' eq hrRatifyPositiveForm.fdIsMobileView}"> --%>
			<!-- 钉钉图标 -->
			<kmss:ifModuleExist path="/third/ding">
				<c:import url="/third/ding/import/ding_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="hrRatifyPositiveForm" />
				</c:import>
			</kmss:ifModuleExist>
			<kmss:ifModuleExist path="/third/lding">
				<c:import url="/third/lding/import/ding_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="hrRatifyPositiveForm" />
				</c:import>
			</kmss:ifModuleExist>
			
			<!-- 钉钉图标 end -->
			<c:if test="${hrRatifyPositiveForm.docStatus < '30' }">
				<%-- <c:choose> --%>
					<%-- <c:when test="${'false' eq hrRatifyPositiveForm.fdIsMobileApprove}">
						<script type="text/javascript">
							require(["mui/dialog/BarTip", "dojo/ready"], function(BarTip, ready) {
								ready(function() {
									BarTip.tip({text: "<bean:message key='hr-ratify:kmReviewTemplate.tipmessage.approve'/>"});
								});
							});
						</script>
					</c:when> --%>
					<%-- <c:otherwise> --%>
						<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="hrRatifyPositiveForm" />
							<c:param name="fdKey" value="reviewMainDoc" />
							<c:param name="lbpmViewName" value="lbpmView" />
							<c:param name="onClickSubmitButton" value="Com_Submit(document.hrRatifyPositiveForm, 'publishDraft');" />
						</c:import>
						<script type="text/javascript">
							require(["mui/form/ajax-form!hrRatifyPositiveForm"]);
						</script>
			<%-- 		</c:otherwise>
				</c:choose> --%>
			</c:if>
			<c:if test="${hrRatifyPositiveForm.docStatus eq '30'}">
				<script type="text/javascript">
					require(["dojo/ready"], function(ready) {
						ready(function() {
							document.getElementById("processStatusDiv").className="muiProcessStatus stamp";
						});
					});
				</script>
			</c:if>
			<c:if test="${hrRatifyPositiveForm.docStatus eq '00'}">
				<script type="text/javascript">
					require(["dojo/ready"], function(ready) {
						ready(function() {
							document.getElementById("discardStatusDiv").className="muiProcessStatus muiDiscardStatus stamp";
						});
					});
				</script>
			</c:if>
	<%-- 	</c:if> --%>
	</html:form>
	<%-- 支持移动端查阅 --%>
	<%-- <c:if test="${'true' eq hrRatifyPositiveForm.fdIsMobileView}"> --%>
		<!-- 分享机制  -->
		<kmss:ifModuleExist path="/third/ywork/">
			 <c:import url="/third/ywork/ywork_share/yworkDoc_mobile_share.jsp"
				charEncoding="UTF-8">
				<c:param name="modelId" value="${hrRatifyPositiveForm.fdId}" />
				<c:param name="modelName" value="com.landray.kmss.km.review.model.KmReviewMain" />
				<c:param name="templateId" value="${ hrRatifyPositiveForm.fdTemplateId}" />
				<c:param name="allPath" value="${ hrRatifyPositiveForm.fdTemplateName}" />
			</c:import>
		</kmss:ifModuleExist>
	<%-- </c:if> --%>
	
		<%-- 不支持移动端查阅 --%>
		<%-- <c:if test="${'false' eq hrRatifyPositiveForm.fdIsMobileView}">
			<script type="text/javascript">
				require(["mui/dialog/BarTip", "dojo/ready"], function(BarTip, ready) {
					ready(function() {
						BarTip.tip({text: "<bean:message key='hr-ratify:kmReviewTemplate.tipmessage.view'/>"});
					});
				});
			</script>
		</c:if> --%>
		
	</template:replace>
</template:include>
