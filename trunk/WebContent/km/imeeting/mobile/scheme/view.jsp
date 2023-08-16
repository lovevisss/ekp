<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="mobile.view" compatibleMode="true" tiny="true">
	<template:replace name="csshead">
		<mui:cache-file name="mui-imeeting-view.css" cacheType="md5"/>
	</template:replace>
	
	<template:replace name="head">
		<mui:min-file name="mui-imeeting.js"/>
		<link rel="Stylesheet" type="text/css" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/view.css?s_cache=${MUI_Cache}" />   
	</template:replace>
	<template:replace name="title">
			<c:out value="${ kmImeetingSchemeForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do">		
			<html:hidden property="fdId" />
			<div id="scrollView" data-dojo-type="mui/view/DocScrollableView">
				<div data-dojo-type="mui/fixed/Fixed" id="fixed">
					<div data-dojo-type="mui/fixed/FixedItem">
						<%--切换页签--%>
						<div class="muiHeader">
							<div
								data-dojo-type="mui/nav/MobileCfgNavBar" 
								data-dojo-props="defaultUrl:'/km/imeeting/mobile/scheme/view_nav.jsp' ">
							</div>
						</div>
					</div>
				</div>
				
				<div id="baseView" data-dojo-type="dojox/mobile/View">
					<div class="meetingDocContent">
						<table class="muiSimple" cellpadding="0" cellspacing="0">
		                    <tr>
		                        <td colspan="2">
									<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp"
										charEncoding="UTF-8">
										<c:param name="formName" value="kmImeetingSchemeForm" />
										<c:param name="fdKey" value="ImeetingScheme" />
									</c:import>
		                        </td>
		                    </tr>
						</table>
					</div>
				</div>
				
				<%--流程记录--%>
				<div data-dojo-type="dojox/mobile/View" id="folwView">
					<div class="meetingDocContent">
						<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
							<c:param name="fdModelId" value="${kmImeetingSchemeForm.fdId }"/>
							<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme"/>
							<c:param name="formBeanName" value="kmImeetingSchemeForm"/>
						</c:import>
					</div>
				</div>
				
				<template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp" 
							editUrl="/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=edit&fdId=${param.fdId }"
							formName="kmImeetingSchemeForm"
							viewName="lbpmView"
							allowReview="true">
					<template:replace name="flowArea">
						<c:if test="${(kmImeetingSchemeForm.sysWfBusinessForm.fdIsHander ne 'true'
                                    	and kmImeetingSchemeForm.docStatusFirstDigit ne '0')
                                	or kmImeetingSchemeForm.docStatusFirstDigit >= '2'}">
							<kmss:auth requestURL="/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=edit&fdId=${kmImeetingSchemeForm.fdId}"
									   requestMethod="GET">
								<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit"
									data-dojo-props="colSize:2"
									onclick="window.open('${LUI_ContextPath}/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=edit&fdId=${kmImeetingSchemeForm.fdId}','_self');">
										${lfn:message('button.edit')}
								</li>
							</kmss:auth>
						</c:if>
					</template:replace>
				</template:include>
			</div>

			<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingSchemeForm" />
				<c:param name="fdKey" value="ImeetingScheme" />
				<c:param name="viewName" value="lbpmView" />
				<c:param name="backTo" value="scrollView" />
				<c:param name="onClickSubmitButton" value="Com_Submit(document.kmImeetingSchemeForm, 'publishDraft');" />
			</c:import>
			<script type="text/javascript">
				require(["mui/form/ajax-form!kmImeetingSchemeForm"]);
			</script>
		</html:form>
	</template:replace>
</template:include>