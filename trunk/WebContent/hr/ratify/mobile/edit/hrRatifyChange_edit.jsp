<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.edit" compatibleMode="true" newMui="true">
	<template:replace name="title">
		<c:choose>
			<c:when test="${hrRatifyChangeForm.method_GET == 'add' }">
				<c:out
					value="${ lfn:message('operation.create') } - ${ lfn:message('hr-ratify:table.hrRatifyChange') }" />
			</c:when>
			<c:otherwise>
				<c:out value="${hrRatifyChangeForm.docSubject} - " />
				<c:out value="${ lfn:message('hr-ratify:table.hrRatifyChange') }" />
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="head">
	<!-- 块状样式，因为使用全局的块状样式会导致其他样式影响。所有只引用单样式 -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/mobile/css/themes/default/form-tiny.css?s_cache=${MUI_Cache}"></link>
				<!-- 非块状多选样式变化 查看页面不需要 -->
		<style>
			.oldMui.muiFormEleWrap .muiCheckBoxWrap.muiCheckBoxNormalWrap {
			    margin-top: 0;
			}
			.muiCheckItem.hasText .muiCheckBlock {
				    top: 0.9rem;
			}
		</style>
		<!--块状end--> 
		<%-- <mui:min-file name="mui-review-view.css"/> --%>
		<link rel="stylesheet" type="text/css" 
			href="<%=request.getContextPath()%>/sys/attend/map/mobile/resource/css/location.css?s_cache=${MUI_Cache}"></link>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/hr/ratify/mobile/resource/css/contract__edit.css?s_cache=${MUI_Cache}"></link>
		<script type="text/javascript">
		   	require(["dojo/store/Memory","dojo/topic","dijit/registry"],function(Memory,topic,registry){
		   		var navData = [{'text':'01  /  <bean:message bundle="hr-ratify" key="mui.hrRatifyMain.mobile.info" />',
		   			'moveTo':'scrollView','selected':true},{'text':'02  /  <bean:message bundle="hr-ratify" key="mui.hrRatifyMain.mobile.review" />',
			   		'moveTo':'lbpmView'}]
		   		window._narStore = new Memory({data:navData});
		   		var changeNav = function(view){
		   			var wgt = registry.byId("_flowNav");
		   			for(var i=0;i<wgt.getChildren().length;i++){
		   				var tmpChild = wgt.getChildren()[i];
		   				if(view.id == tmpChild.moveTo){
		   					tmpChild.beingSelected(tmpChild.domNode);
		   					return;
		   				}
		   			}
		   		}
		   		topic.subscribe("mui/form/validateFail",function(view){
		   			changeNav(view);
		   		});
				topic.subscribe("mui/view/currentView",function(view){
					changeNav(view);
		   		});
		   	});
	   </script>
	</template:replace>
	<template:replace name="content">
		<c:choose>
			<c:when test="${'false' eq 'true'}">
				<%--不允许移动端创建的情景 --%>
				<script type="text/javascript">
					require(["mui/dialog/BarTip", "dojo/ready"], function(BarTip, ready) {
						ready(function() {
							BarTip.tip({text:"<bean:message key='hr-ratify:hrRatifyTemplate.tipmessage.create'/>"});
						});
					});
				</script>
			</c:when>
			<c:otherwise>
				<html:form action="/hr/ratify/hr_ratify_change/hrRatifyChange.do?method=save">
					<div>
						<div data-dojo-type="mui/fixed/Fixed" class="muiFlowEditFixed">
							<div data-dojo-type="mui/fixed/FixedItem" class="muiFlowEditFixedItem">
								<div data-dojo-type="mui/nav/NavBarStore" id="_flowNav" data-dojo-props="store:_narStore">
								</div>
							</div>
						</div>
						<div data-dojo-type="mui/view/DocScrollableView" 
							data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
							<div class="muiFlowInfoW muiFormContent">
								<html:hidden property="fdId" />
								<%-- <html:hidden property="fdModelId" /> --%>
								<%-- <html:hidden property="fdModelName" /> --%>
								<html:hidden property="docStatus" />
								<%-- <html:hidden property="fdCanCircularize" value="${hrRatifyChangeForm.fdCanCircularize}"/> --%>
								<table class="muiSimple" cellpadding="0" cellspacing="0">
									<tr>
										<td class="muiTitle">
											${lfn:message('hr-ratify:hrRatifyMain.docSubject') }
										</td>
										<td>
											<c:if test="${hrRatifyChangeForm.titleRegulation==null || hrRatifyChangeForm.titleRegulation=='' }">
												<xform:text property="docSubject" mobile="true" subject="${lfn:message('hr-ratify:hrRatifyMain.docSubject') }" htmlElementProperties="id='docSubject'"/>
											</c:if>
											<c:if test="${hrRatifyChangeForm.titleRegulation!=null && hrRatifyChangeForm.titleRegulation!='' }">
												<xform:text property="docSubject" mobile="true" showStatus="readOnly" value="${lfn:message('hr-ratify:hrRatifyMain.docSubject.info') }" htmlElementProperties="id='docSubject'"/>
											</c:if>
										</td>
									</tr>
									<tr>
										<td class="muiTitle">
											${lfn:message('hr-ratify:hrRatifyTemplate.fdName') }
										</td>
										<td>
											<html:hidden property="docTemplateId" /> 
											<xform:text property="docTemplateName" mobile="true" showStatus="view" subject="${lfn:message('hr-ratify:hrRatifyTemplate.fdName') }"/>
										</td>
									</tr>
									<tr>
										<td class="muiTitle">
											${lfn:message('hr-ratify:hrRatifyMain.docCreatorName') }
										</td>
										<td>
											<xform:text property="docCreatorName" mobile="true" showStatus="view" subject="${lfn:message('hr-ratify:hrRatifyMain.docCreatorName') }"/>
										</td>
									</tr>
								</table>
								<c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="hrRatifyChangeForm" />
									<c:param name="moduleModelName" value="com.landray.kmss.hr.ratify.model.HrRatifyPositive" />
								</c:import>
								<c:import url="/sys/relation/mobile/edit_hidden.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="hrRatifyChangeForm" />
								</c:import>
								<%-- <c:import url="/sys/agenda/mobile/edit_hidden.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="hrRatifyChangeForm" />
								</c:import> --%>
								<c:import url="/sys/authorization/mobile/edit_hidden.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="hrRatifyChangeForm" />
								</c:import>
							</div>
							<div class="muiFlowInfoW muiFormContent">
								<c:if test="${hrRatifyChangeForm.docUseXform == 'false'}">
									<table class="muiSimple" cellpadding="0" cellspacing="0">
										<tr>
											<td colspan="2">
												<c:if test="${empty hrRatifyChangeForm.docContent }">
													<c:set property="docContent" target="${hrRatifyChangeForm}" value=""/>
													<xform:textarea property="docContent" mobile="true"/>
												</c:if>
												<c:if test="${not empty hrRatifyChangeForm.docContent }">
													<html:hidden property="docContent"/>
													<xform:rtf showStatus="view" property="docContent" mobile="true"></xform:rtf>
												</c:if>
											</td>
										</tr><tr>
											<td colspan="2">
												<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
													<c:param name="formName" value="hrRatifyChangeForm"></c:param>
													<c:param name="fdKey" value="fdAttachment"></c:param>
												</c:import> 
											</td>
										</tr>
									</table>
								</c:if>
								<c:if test="${hrRatifyChangeForm.docUseXform == 'true' || empty hrRatifyChangeForm.docUseXform}">
									<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp"
										charEncoding="UTF-8">
										<c:param name="formName" value="hrRatifyChangeForm" />
										<c:param name="fdKey" value="${fdTempKey}" />
										<c:param name="viewName" value="lbpmView" />
										<c:param name="backTo" value="scrollView" />
									</c:import>
								</c:if>
								<table class="muiSimple" cellpadding="0" cellspacing="0">
									<tr>
										<td class="muiTitle">
											合同附件
										</td>
										<td>
											<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
												<c:param name="fdKey" value="attHrExpCont"/>
												<c:param name="formName" value="hrRatifyChangeForm" />
											</c:import>
										</td>
									</tr>
								</table>
							</div>
							<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" <c:if test="${'false' ne true}">data-dojo-props='fill:"grid"'</c:if>>
							  	<li data-dojo-type="hr/ratify/mobile/resource/js/SaveDraftButton" 
							  		data-dojo-props='validateDomId:"scrollView",validateElementId:"docSubject",docStatus:"${hrRatifyChangeForm.docStatus }"'>
									<bean:message key="button.savedraft" /></li>
							  	<li data-dojo-type="mui/tabbar/TabBarButton" class="mainTabBarButton"
							  		data-dojo-props='colSize:2,moveTo:"lbpmView",transition:"slide"'>
							  		<bean:message bundle="hr-ratify" key="button.next" /></li>
							</ul>
						</div>
						<c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="hrRatifyChangeForm" />
							<c:param name="fdKey" value="attRatifyChange" />
							<c:param name="viewName" value="lbpmView" />
							<c:param name="backTo" value="scrollView" />
							<c:param name="onClickSubmitButton" value="review_submit();" />
						</c:import>
						<script type="text/javascript">
						require(["mui/form/ajax-form!hrRatifyChangeForm"]);
						window.addDeptPost=function(){}
						require(['dojo/ready','dijit/registry','dojo/query','dojo/ready','dojo/topic',"dojo/request","mui/dialog/Tip"],function(ready,registry,query,ready,topic,request,Tip){
							ready(function(){
								var fdChangeDept = registry.byId('fdChangeDept');
								var baseUrl = dojo.config.baseUrl;
								 window.addDeptPost=function(obj){
									 if(obj){
											$.ajax({
												url : baseUrl+'hr/staff/hr_staff_person_info/hrStaffPersonInfo.do?method=getPersonInfo',
												type: 'POST',
												dataType: 'json',
												data : {
													id : obj
												},
												success : function(data, textStatus, xhr){
													var d = eval(data);
													if(fdChangeDept&&d.dept){
														  var dept = d.dept;
														  fdChangeDept._setCurIdsAttr(dept.id);
														  fdChangeDept._setCurNamesAttr(dept.name);
													}
													
												},
												error:function(e){
													//console.log(e)
												}
											});
										}else{
											if(fdChangeDept){
												fdChangeDept._setCurIdsAttr("");
												fdChangeDept._setCurNamesAttr("");
											}
										}
									
									
								 } 
							})

							window.review_submit = function(){
								var status = document.getElementsByName("docStatus")[0];
								var method = Com_GetUrlParameter(location.href,'method');
								var fdChangeStaffId = $('input[name="fdChangeStaffId"]').val();
								var fdContractId = $('[name="fdContractId"]').val();
								var fdContractName = $('[name="fdContractName"]').val();
								var fdChangeEndDate = $('[name="fdChangeEndDate"]').val();
								var fdChangeBeginDate = $('[name="fdChangeBeginDate"]').val();
								var fdIsLongtermContract = $('[name="fdIsLongtermContract"]').val();
								request.post("${LUI_ContextPath}/hr/staff/hr_staff_person_experience/contract/hrStaffPersonExperienceContract.do?method=getRepeatContract",{
									handleAs: "json",
									data:{
										"personInfoId":fdChangeStaffId,
										"fdId":fdContractId,
										"fdName":fdContractName,
										"fdBeginDate":fdChangeBeginDate,
										"fdEndDate":fdChangeEndDate,
										"fdIsLongtermContract":fdIsLongtermContract
									}
								}).then(function (result) {
									if (result.result){
										var fdChangeSignEndDate = $('[name="fdChangeSignEndDate"]').val();
										if(fdChangeSignEndDate == "长期有效"){
											$('[name="fdChangeSignEndDate"]').val('');
										}
										if(method=='add'){
											status.value="20"
											Com_Submit(document.forms[0],'save');
										}else{
											status.value="20"
											Com_Submit(document.forms[0],'update');
										}
									}else{
										Tip.warn({text: '<bean:message key="hrStaff.import.error.contract.repeat" bundle="hr-staff"/>'});
									}
								})
							}

						})
						</script>
					</div>
				</html:form>
			</c:otherwise>
		</c:choose>
	</template:replace>
</template:include>
