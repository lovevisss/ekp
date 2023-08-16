<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="mobile.edit" compatibleMode="true">
	<template:replace name="content"> 
	<xform:config  orient="vertical">
		<html:form action="/km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback.do">
			<html:hidden property="fdId" />
			<html:hidden property="fdMeetingId"  value="${HtmlParam['meetingId'] }"/>
			<input name="attendOther" value="false" type="hidden">
			<div data-dojo-type="mui/view/DocScrollableView" id="scrollView" data-dojo-mixins="mui/form/_ValidateMixin">
				<div data-dojo-type="mui/panel/AccordionPanel">
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message bundle="km-imeeting"  key="mobile.kmImeetingMainFeedback.title"/>',icon:'mui-ul'">
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<c:choose>
								<c:when test="${empty HtmlParam['fdOperateType'] }">
									<tr>
										<td>
											<xform:radio property="fdOperateType" required="true" mobile="true">
												<xform:enumsDataSource enumsType="km_imeeting_main_feedback_fd_operate_type" />
											</xform:radio>
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<html:hidden property="fdOperateType"  value="${HtmlParam['fdOperateType'] }"/>
								</c:otherwise>
							</c:choose>
							<tr>
								<td>
									<xform:textarea property="fdReason" mobile="true" validators="validateReason"/>
								</td>
							</tr>
							
							<tr id="docAttend" style="<c:if test="${HtmlParam['fdOperateType'] !='03' and kmImeetingMainFeedbackForm.fdOperateType!='03' }">display: none;</c:if>">
								<td>
									<xform:address propertyName="docAttendName" propertyId="docAttendId" orgType="ORG_TYPE_PERSON"
										 mobile="true" validators="validateDocAttend"></xform:address>
								</td>
							</tr>
							<tr id="docAttendOther" style="<c:if test="${HtmlParam['fdOperateType'] !='05' and  kmImeetingMainFeedbackForm.fdOperateType!='05'}">display: none;</c:if>">
								<td>
									<xform:address propertyName="attendOtherNames" propertyId="attendOtherIds" orgType="ORG_TYPE_PERSON" mulSelect="true"
										 mobile="true" validators="validateDocAttendOther"></xform:address>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
				  	
				  	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit " 
				  		data-dojo-props='colSize:2,href:"javascript:updateFeedback(\"update\",\"false\");",transition:"slide"'>
				  			<bean:message key="button.update"/>
				  	</li>
				   	
				</ul>
			</div>
		</html:form>
		<script>
			require(["mui/form/ajax-form!kmImeetingMainFeedbackForm"]);
			require(['mui/dialog/Tip',"dojo/topic","dojo/dom-style","dojo/query","mui/util","dijit/registry","dojo/ready"],
					function(tip,topic,domStyle,query,util,registry,ready){
				//校验对象
				var validorObj=null;
				
				ready(function(){
					validorObj=registry.byId('scrollView');
					//自定义校验器1：当回复不参加时，留言为必填
					validorObj._validation.addValidator("validateReason",'<bean:message bundle="km-imeeting"  key="mobile.kmImeetingMainFeedback.validateReason"/>',function(v, e, o){
						var fdOperateType=query('[name="fdOperateType"]')[0];
						var reason=query('[name="fdReason"]')[0].value;
						if(fdOperateType && fdOperateType.value=="02" && !reason){
							return false;	
						}
						return true;
					});
					
					//自定义校验器2：当回复找人代参加时，实际参与人为必填
					validorObj._validation.addValidator("validateDocAttend",'<bean:message bundle="km-imeeting"  key="mobile.kmImeetingMainFeedback.validateDocAttend"/>',function(v, e, o){
						var fdOperateType=query('[name="fdOperateType"]')[0];
						if(fdOperateType && fdOperateType.value=="03" && !v){
							return false;	
						}
						return true;
					});
					
					//自定义校验器3：邀请他人参加,参加人不能为空
					validorObj._validation.addValidator("validateDocAttendOther",'<bean:message bundle="km-imeeting"  key="mobile.kmImeetingMainFeedback.validateDocAttendOther"/>',function(v, e, o){
						var fdOperateType=query('[name="fdOperateType"]')[0];
						if(fdOperateType && fdOperateType.value=="05" && !v){
							return false;	
						}
						return true;
					});
					
					//切换radio时校验
					topic.subscribe('mui/form/radio/change',function(){
						validorObj.validate();
					});
					
				});
				
				//提交
				window.updateFeedback=function(commitType,saveDraft){
					if(validorObj.validate()){
						var formObj = document.kmImeetingMainFeedbackForm;
						var fdOperateType=query('[name="fdOperateType"]')[0],
							attendOther = query('[name="attendOther"]')[0];
						if(fdOperateType.value == '05'){
							fdOperateType.value = '01';
							attendOther.value = 'true';
						}
						
						if ('save' == commitType) {
							Com_Submit(formObj, commitType, 'fdId');
						} else {
							Com_Submit(formObj, commitType);
						}
					}
				};
				
				window.doback=function(){
					window.open('${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=view&fdId=${JsParam.meetingId}','_self');
				};
				
				topic.subscribe('/mui/form/valueChanged',function(widget,args){
					if(widget.name=='fdOperateType'){
						
						domStyle.set(query('#docAttend')[0],'display','none');
						domStyle.set(query('#docAttendOther')[0],'display','none');
						if(args.value && args.value=="03"){
							domStyle.set(query('#docAttend')[0],'display','');
						}
						if(args.value && args.value=="05"){
							domStyle.set(query('#docAttendOther')[0],'display','');
						}
						
					}
				});
				
			});
			
		</script>
	</xform:config>
	</template:replace>
</template:include>