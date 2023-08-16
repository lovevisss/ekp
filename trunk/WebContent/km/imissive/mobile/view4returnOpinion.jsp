<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${kmImissiveReturnOpinionForm.fdUnitName}"></c:out>
	</template:replace>
	<template:replace name="content">
		<div id="scrollView" 
			data-dojo-type="mui/view/DocScrollableView"
			data-dojo-mixins="mui/form/_ValidateMixin">
			<div data-dojo-type="mui/panel/AccordionPanel">
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'退回（退文）意见',icon:'mui-ul'">
				   <div class="muiFormContent">
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReturnOpinion.fdUnitName"/>
								</td>
								<td>
									<c:out value="${kmImissiveReturnOpinionForm.fdUnitName}"></c:out>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReturnOpinion.docContent"/>
								</td>
								<td>
									<xform:textarea property="docContent" mobile="true"></xform:textarea>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReturnOpinion.docCreator"/>
								</td>
								<td>
									<c:out value="${kmImissiveReturnOpinionForm.docCreatorName}"></c:out>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReturnOpinion.docCreateTime"/>
								</td>
								<td>
									<c:out value="${kmImissiveReturnOpinionForm.docCreateTime}"></c:out>
								</td>
							</tr>
						</table>
					</div>
				</div>
		   </div>
		   <ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" >
			  <li data-dojo-type="mui/back/BackButton"></li>
			    <li data-dojo-type="mui/tabbar/TabBarButtonGroup" data-dojo-props="icon1:'mui mui-more'">
			    	<div data-dojo-type="mui/back/HomeButton"></div>
			    </li>
			</ul>
		<script>
			require(["mui/form/ajax-form!kmImissiveSignMainForm"]);
		</script>
	</template:replace>
</template:include>
