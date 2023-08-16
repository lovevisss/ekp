<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${kmImissiveRegDetailListOuterForm.fdRegName}"></c:out>
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do">		
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
									<c:out value="${kmImissiveRegDetailListOuterForm.fdRegName}" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdDocNum"/>
								</td><td>
									<c:if test="${empty kmImissiveRegDetailListOuterForm.fdRegNo}">
								          	${lfn:message("km-imissive:kmImissiveSendMain.fdDocNum.auto") }
								    </c:if>
								    <c:if test="${not empty kmImissiveRegDetailListOuterForm.fdRegNo}">
								             <c:out value="${kmImissiveRegDetailListOuterForm.fdRegNo}" />
					                </c:if>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.docCreateTime"/>
								</td><td>
									<c:out value="${kmImissiveRegDetailListOuterForm.docCreateTime}"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdSendUnit"/>
								</td><td>
									<c:out value="${kmImissiveRegDetailListOuterForm.fdFromUnitName}" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdUnit"/>
								</td><td>
									<c:out value="${kmImissiveRegDetailListOuterForm.fdUnitName}" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdOrgNames"/>
								</td><td>
									<c:out value="${kmImissiveRegDetailListOuterForm.fdOrgNames}" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdStatus"/>
								</td><td>
								    <sunbor:enumsShow value="${kmImissiveRegDetailListOuterForm.fdStatus}" enumsType="kmImissiveReg_status" bundle="km-imissive" />
								</td>
							</tr>
							<c:if test="${not empty kmImissiveRegDetailListOuterForm.fdSignTime}">
							 <tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdSignerName"/>
								</td>
								<td>
									<c:out value="${kmImissiveRegDetailListOuterForm.fdSignerName}"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdSignTime"/>
								</td>
								<td>
									<c:out value="${kmImissiveRegDetailListOuterForm.fdSignTime}"/>
								</td>
							</tr>
						</c:if>
						<c:if test="${kmImissiveRegDetailListOuterForm.fdStatus eq '2' or kmImissiveRegDetailListOuterForm.fdStatus eq '4'}">
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdLinkSubject"/>
								</td>
								<td>
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
						<c:if test="${kmImissiveRegDetailListOuterForm.fdStatus eq '3'}">
							 <tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.return.reason"/>
								</td>
								<td>
									<c:out value="${docContent}"/>
								</td>
							</tr>
						</c:if>
						</table>
					</div>
				</div>
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'正文附件',icon:'mui-ul'">
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegDetailListOuterForm" />
						<c:param name="fdKey" value="editonline" />
						<c:param name="fdModelId" value="${kmImissiveRegDetailListOuterForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveRegDetailListOuter" />
					</c:import>
				</div>
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'文档附件',icon:'mui-ul'">
				    <c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegDetailListOuterForm" />
						<c:param name="fdKey" value="regAtt" />
						<c:param name="fdModelId" value="${kmImissiveRegDetailListOuterForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveRegDetailListOuter" />
					</c:import>
				</div>
		   </div>
		   
		   <ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" >
			   <kmss:auth requestURL="/km/imissive/km_imissive_regdetail_list_outer/kmImissiveRegDetailListOuter.do?method=updateSign&fdId=${kmImissiveRegDetailListOuterForm.fdId}" requestMethod="GET">
				  	<c:choose>
						<c:when test="${kmImissiveRegDetailListOuterForm.fdRegType eq '2' }">
								<c:if test="${kmImissiveRegDetailListOuterForm.fdStatus!='2' and kmImissiveRegDetailListOuterForm.fdStatus!='3' and kmImissiveRegDetailListOuterForm.fdStatus!='4' and kmImissiveRegDetailListOuterForm.fdStatus!='5'}">
						    		<li data-dojo-type="mui/tabbar/CreateButton" 
								  		data-dojo-mixins="mui/syscategory/SysCategoryMixin"
								  		data-dojo-props="icon1:'',key:'sendAdd',createUrl:'/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=addSendOuter&fddetaiId=${kmImissiveRegDetailListOuterForm.fdId}&fdTemplateId=!{curIds}&mobile=true',mainModelName:'com.landray.kmss.km.imissive.model.KmImissiveSendMain',
								  		modelName:'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate'">
								  		<bean:message  bundle="km-imissive" key="kmImissiveReg.updateSignSend"/>
								  	</li>
				  					 <li data-dojo-type="mui/tabbar/CreateButton" 
								  		data-dojo-mixins="mui/syscategory/SysCategoryMixin"
								  		data-dojo-props="icon1:'',key:'receiveAdd',createUrl:'/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceiveOuter&fddetaiId=${kmImissiveRegDetailListOuterForm.fdId}&fdTemplateId=!{curIds}&mobile=true',mainModelName:'com.landray.kmss.km.imissive.model.KmImissiveReceiveMain',
								  		modelName:'com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate'">
								  		<bean:message  bundle="km-imissive" key="kmImissiveReg.updateSignReceive"/>
								  	 </li>
								</c:if>
						</c:when>
						<c:otherwise>
							 <kmss:auth requestURL="/km/imissive/km_imissive_regdetail_list_outer/kmImissiveRegDetailListOuter.do?method=updateSign&fdId=${kmImissiveRegDetailListOuterForm.fdId}" requestMethod="GET">
								<c:if test="${kmImissiveRegDetailListOuterForm.fdStatus!='2' and kmImissiveRegDetailListOuterForm.fdStatus!='3' and kmImissiveRegDetailListOuterForm.fdStatus!='4' and kmImissiveRegDetailListOuterForm.fdStatus!='5'}">
				  					 <li data-dojo-type="mui/tabbar/CreateButton" 
								  		data-dojo-mixins="mui/syscategory/SysCategoryMixin"
								  		data-dojo-props="icon1:'',key:'receiveAdd',createUrl:'/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceiveOuter&fddetaiId=${kmImissiveRegDetailListOuterForm.fdId}&fdTemplateId=!{curIds}&mobile=true',mainModelName:'com.landray.kmss.km.imissive.model.KmImissiveReceiveMain',
								  		modelName:'com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate'">
								  		<bean:message  bundle="km-imissive" key="kmImissiveReg.updateSign"/>
								  	 </li>
								</c:if>
							</kmss:auth>
						</c:otherwise>
					</c:choose>
				</kmss:auth> 	
				<c:if test="${kmImissiveRegDetailListOuterForm.fdRegDeliverType!='3' and kmImissiveRegDetailListOuterForm.fdStatus!='2' and kmImissiveRegDetailListOuterForm.fdStatus!='3' and kmImissiveRegDetailListOuterForm.fdStatus!='4' and kmImissiveRegDetailListOuterForm.fdStatus!='5'}">
				 	<li data-dojo-type="km/imissive/mobile/list/SignOnlyButton" data-dojo-props="url:'/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=saveReceiveOnly&fddetaiId=${kmImissiveRegDetailListOuterForm.fdId}&outer=true'"></li>
				</c:if>
			</ul>
	</html:form>
	<script type="text/javascript">
require(["mui/device/adapter"], function(adapter){
	window.openReceiveDoc = function(){
		var url = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=view&fdId=${kmImissiveRegDetailListOuterForm.fdReceiveId}";
		if("${kmImissiveRegDetailListForm.fdSignType}" == '1'){
			url = "${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=${kmImissiveRegDetailListOuterForm.fdReceiveId}";
		}
		adapter.open(url, "_blank");
	};
});
</script>
	<script>
		window.updateSignOnly = function(){
			var url = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=saveReceiveOnly&fddetaiId=${kmImissiveRegDetailListOuterForm.fdId}";
			window.open(url, "_self");
		};
	</script>
	</template:replace>
</template:include>
