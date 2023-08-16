<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.edit" compatibleMode="true">
	<template:replace name="title">
		<c:choose>
			<c:when test="${hrRatifySalaryForm.method_GET == 'add' }">
				<c:out
					value="${ lfn:message('operation.create') } - ${ lfn:message('hr-ratify:table.hrRatifySalary') }" />
			</c:when>
			<c:otherwise>
				<c:out value="${hrRatifySalaryForm.docSubject} - " />
				<c:out value="${ lfn:message('hr-ratify:table.hrRatifySalary') }" />
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
		<mui:min-file name="mui-review-view.css"/>
		<link rel="stylesheet" type="text/css" 
			href="<%=request.getContextPath()%>/sys/attend/map/mobile/resource/css/location.css?s_cache=${MUI_Cache}"></link>
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
				<html:form action="/hr/ratify/hr_ratify_salary/hrRatifySalary.do?method=save">
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
								<%-- <html:hidden property="fdCanCircularize" value="${hrRatifySalaryForm.fdCanCircularize}"/> --%>
								<table class="muiSimple" cellpadding="0" cellspacing="0">
									<tr>
										<td class="muiTitle">
											${lfn:message('hr-ratify:hrRatifyMain.docSubject') }
										</td>
										<td>
											<c:if test="${hrRatifySalaryForm.titleRegulation==null || hrRatifySalaryForm.titleRegulation=='' }">
												<xform:text property="docSubject" mobile="true" subject="${lfn:message('hr-ratify:hrRatifyMain.docSubject') }" htmlElementProperties="id='docSubject'"/>
											</c:if>
											<c:if test="${hrRatifySalaryForm.titleRegulation!=null && hrRatifySalaryForm.titleRegulation!='' }">
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
									<c:param name="formName" value="hrRatifySalaryForm" />
									<c:param name="moduleModelName" value="com.landray.kmss.hr.ratify.model.HrRatifySalary" />
								</c:import>
								<c:import url="/sys/relation/mobile/edit_hidden.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="hrRatifySalaryForm" />
								</c:import>
								<%-- <c:import url="/sys/agenda/mobile/edit_hidden.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="hrRatifySalaryForm" />
								</c:import> --%>
								<c:import url="/sys/authorization/mobile/edit_hidden.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="hrRatifySalaryForm" />
								</c:import>
							</div>
							<div class="muiFlowInfoW muiFormContent">
								<c:if test="${hrRatifySalaryForm.docUseXform == 'false'}">
									<table class="muiSimple" cellpadding="0" cellspacing="0">
										<tr>
											<td colspan="2">
												<c:if test="${empty hrRatifySalaryForm.docContent }">
													<c:set property="docContent" target="${hrRatifySalaryForm}" value=""/>
													<xform:textarea property="docContent" mobile="true"/>
												</c:if>
												<c:if test="${not empty hrRatifySalaryForm.docContent }">
													<html:hidden property="docContent"/>
													<xform:rtf showStatus="view" property="docContent" mobile="true"></xform:rtf>
												</c:if>
											</td>
										</tr><tr>
											<td colspan="2">
												<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
													<c:param name="formName" value="hrRatifySalaryForm"></c:param>
													<c:param name="fdKey" value="fdAttachment"></c:param>
												</c:import> 
											</td>
										</tr>
									</table>
								</c:if>
								<c:if test="${hrRatifySalaryForm.docUseXform == 'true' || empty hrRatifySalaryForm.docUseXform}">
									<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp"
										charEncoding="UTF-8">
										<c:param name="formName" value="hrRatifySalaryForm" />
										<c:param name="fdKey" value="${fdTempKey}" />
										<c:param name="viewName" value="lbpmView" />
										<c:param name="backTo" value="scrollView" />
									</c:import>
								</c:if>
							</div>
							<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
							  	<li data-dojo-type="hr/ratify/mobile/resource/js/SaveDraftButton" 
					  				data-dojo-props='validateDomId:"scrollView",validateElementId:"docSubject"'>
									<bean:message key="button.savedraft" /></li>
							  	<li data-dojo-type="mui/tabbar/TabBarButton" class="mainTabBarButton"
							  		data-dojo-props='colSize:2,moveTo:"lbpmView",transition:"slide"'>
							  		<bean:message  bundle="hr-ratify"  key="button.next" /></li>
							</ul>
						</div>
						<c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="hrRatifySalaryForm" />
							<c:param name="fdKey" value="attRatifySalary" />
							<c:param name="viewName" value="lbpmView" />
							<c:param name="backTo" value="scrollView" />
							<c:param name="onClickSubmitButton" value="review_submit();" />
						</c:import>
						<script type="text/javascript">
						require(["mui/form/ajax-form!hrRatifySalaryForm"]);
						window.addDeptPost=function(){}
						require(['dojo/ready','dijit/registry','dojo/query','dojo/ready','dojo/topic',"dojo/request"],function(ready,registry,query,ready,topic,request){
							//自动计算工资差额
		            		window.calculateDiff=function(type,value){
		                		var fdSalaryDiff = query("[name='fdSalaryDiff']")[0];
		                		var fdSalaryAfter = query("[name='fdSalaryAfter']")[0];
		                		var fdSalaryBefore = query("[name='fdSalaryBefore']")[0];
		                		if(type == 'before' && fdSalaryAfter.value != ''){
		                			var afterV = fdSalaryAfter.value;
		                			fdSalaryDiff.value = afterV - value;
		                		}
		                		if(type == 'after' && fdSalaryBefore.value != ''){
		                			var beforeV = fdSalaryBefore.value;
		                			fdSalaryDiff.value = value - beforeV;
		                		}
		                	};
							ready(function(){
								var fdSalaryDept = registry.byId('fdSalaryDept');
								var fdSalaryBefore = query('[name="fdSalaryBefore"]')[0];
								var fdSalaryStaffId = $('input[name="fdSalaryStaffId"]').val();
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
													if(fdSalaryDept&&d.dept){
														  var dept = d.dept;
														  fdSalaryDept._setCurIdsAttr(dept.id);
														  fdSalaryDept._setCurNamesAttr(dept.name);
													}
													if(fdSalaryBefore && d.salary){
														fdSalaryBefore.value = d.salary;
													}
												},
												error:function(e){
													//console.log(e)
												}
											});
										}else{
											if(fdSalaryDept){
												fdSalaryDept._setCurIdsAttr("");
												fdSalaryDept._setCurNamesAttr("");
											}
										}
									
									
								 }
								window.addDeptPost(fdSalaryStaffId);
							})
						})
						function review_submit(){
							var status = document.getElementsByName("docStatus")[0];
							var method = Com_GetUrlParameter(location.href,'method');
							if(method=='add'){
								status.value="20"
								Com_Submit(document.forms[0],'save');
							}else{
								status.value="20"
								Com_Submit(document.forms[0],'update');
							}
						}
						</script>
					</div>
				</html:form>
			</c:otherwise>
		</c:choose>
	</template:replace>
</template:include>
