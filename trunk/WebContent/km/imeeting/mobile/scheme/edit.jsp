<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.edit" compatibleMode="true" tiny="true">
	<template:replace name="title">
		<c:if test="${empty  kmImeetingSchemeForm.docSubject}">
			<bean:message bundle="km-imeeting" key="mobile.header.addScheme" />
		</c:if>
		<c:out value="${kmImeetingSchemeForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="head">
		<mui:min-file name="mui-imeeting-edit.css"/>
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/edit_topic.css" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/edit.css" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/detailInput.css" />
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=save">
			<div>
				<div data-dojo-type="mui/fixed/Fixed" data-dojo-props="fixedOrder:1" class="muiFlowEditFixed">
					<div data-dojo-type="mui/fixed/FixedItem">
						<div  data-dojo-type="mui/nav/NavBarStore" data-dojo-mixins="mui/nav/NavBarStepMixin,km/imeeting/mobile/scheme/js/SchemeEditNavMixin" id="_flowNav">
						</div>
					</div>
				</div>
			</div>
			<div data-dojo-type="mui/view/DocScrollableView" 
					data-dojo-mixins="mui/form/_ValidateMixin,mui/form/_AlignMixin" id="scrollView">
				<div class="muiFlowInfoW muiFormContent">
						<html:hidden property="fdId" />
				        <html:hidden property="docStatus" />
				        <html:hidden property="method_GET" />
				        
						<table class="muiSimple" cellpadding="0" cellspacing="0">
                             <tr>
                                <td colspan="2">
									<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp"
										charEncoding="UTF-8">
										<c:param name="formName" value="kmImeetingSchemeForm" />
										<c:param name="fdKey" value="ImeetingScheme" />
										<c:param name="backTo" value="scrollView" />
									</c:import>
                                </td>
                            </tr>
						</table>
						<c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
							  <c:param name="formName" value="kmImeetingSchemeForm" />
                       		  <c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme" />
						</c:import>
					</div>
			
					<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" >
					  	<li data-dojo-type="mui/tabbar/TabBarButton"
					  		data-dojo-props='colSize:4,moveTo:"lbpmView",transition:"slide"'>
					  		<bean:message  bundle="km-imeeting"  key="button.next" /></li>
					</ul>
				</div>
				
				<c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingSchemeForm" />
					<c:param name="fdKey" value="ImeetingScheme" />
					<c:param name="viewName" value="lbpmView" />
					<c:param name="backTo" value="scrollView" />
					<c:param name="onClickSubmitButton" value="scheme_submit();" />
				</c:import>
				<div style="display: none;">
					<c:import url="/sys/news/import/sysNewsPublishMain_edit.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImeetingSchemeForm" />
						<c:param name="fdKey" value="ImeetingScheme" />
						<c:param name="isShow" value="true" />
					</c:import>
				</div>
				<script type="text/javascript">
					require(["mui/form/ajax-form!kmImeetingSchemeForm"]);
					require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
					         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip'], 
						function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip) {
							var validorObj = null;
							ready(function() {
								validorObj = registry.byId('scrollView');
								//调用结束时间验证
								validorObj._validation.addValidator("schemeTime",
										'方案结束时间不可早于等于方案开始时间',
									function(v, e, o) {
										var valueField = e.valueField;
										var result = true;
										var fdBeginDate = query('[name="fdBeginDate"]')[0].value;
										var fdEndDate = query('[name="fdEndDate"]')[0].value;
										if (fdBeginDate && fdEndDate) {
											result = Com_GetDate(fdEndDate).getTime() > Com_GetDate(fdBeginDate).getTime();
											if (result && valueField) {
												if ("fdBeginDate" === valueField) {
													var endDateError = query('[name="fdEndDate"]')[0].parentNode.nextSibling;
													if(endDateError.nodeType == 1) {
														query(endDateError)[0].setAttribute("style", "display:none");
													}
												} else {
													var beginDateError = query('[name="fdBeginDate"]')[0].parentNode.nextSibling;
													if (beginDateError.nodeType == 1) {
														query(beginDateError)[0].setAttribute("style", "display:none");
													}
												}
											}
										}
										return result;
								});
							});
							
							window.scheme_submit = function() {
								if(!validorObj.validate()) {
									return;
								}
								var status = document.getElementsByName("docStatus")[0];
								var method = Com_GetUrlParameter(location.href,'method');
								query('[name="docStatus"]').val('20');
								if(method=='add') {
									Com_Submit(document.forms[0],'save');
								}else{
									Com_Submit(document.forms[0],'update');
								}
							};
					 });
				</script>
			</div>
		</html:form>
	</template:replace>
</template:include>
