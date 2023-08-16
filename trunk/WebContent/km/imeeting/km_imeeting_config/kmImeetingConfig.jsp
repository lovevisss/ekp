<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.profile.edit">
	<template:replace name="content" >
		<html:form action="/sys/appconfig/sys_appconfig/sysAppConfig.do">
			<div style="margin-top:25px">
				<p class="configtitle"><bean:message bundle="sys-organization" key="sysOrgConfig"/></p>
				<center>
					<table class="tb_normal" width=95%>
						<tr>
							<td class="td_normal_title" width=20%>
								<bean:message bundle="km-imeeting" key="kmImeetingRes.conflict.configMethod"/>
							</td>
							<td colspan="3">
								<html:hidden property="value(unShow)" />
								<input name="unShow" type="checkbox" onclick="changeValue(this);"/>
								<bean:message bundle="km-imeeting" key="kmImeetingRes.config.unShow"/>
							</td>		
						</tr>
						<tr>
							<td class="td_normal_title" width=20%>
								${lfn:message('km-imeeting:kmImeeting.SendEmails.notify')}
							</td>
							<td colspan="3">
								<html:hidden property="value(setICS)" />
								<input name="setICS" type="checkbox" onclick="changeICS(this);"/>
								${lfn:message('km-imeeting:kmImeeting.SendEmails.notify')}
								</br>
								<span style="color: red;"><bean:message bundle="km-imeeting" key="kmImeeting.SendEmails.notify.tip"/></span>
							</td>		
						</tr>
						
						<tr>
							<td class="td_normal_title" width=15%>
								<bean:message key="kmImeetingSummary.notifyPerson.config" bundle="km-imeeting" />
							</td>
							<td colspan="3">
								<xform:checkbox property="value(summaryNotifyPerson)" >
									<xform:simpleDataSource value="1"><bean:message key="kmImeetingFeedback.viewPerson.docCreator" bundle="km-imeeting" /></xform:simpleDataSource>
									<xform:simpleDataSource value="2"><bean:message key="kmImeetingSummary.fdNotifyPerson.fdHost" bundle="km-imeeting" /></xform:simpleDataSource>
									<xform:simpleDataSource value="3"><bean:message key="kmImeetingScheme.requiredPerson" bundle="km-imeeting" /></xform:simpleDataSource>
									<xform:simpleDataSource value="4"><bean:message key="kmImeetingScheme.invitationPerson" bundle="km-imeeting" /></xform:simpleDataSource>
									<xform:simpleDataSource value="5"><bean:message key="kmImeetingConfig.fdAttendPersons" bundle="km-imeeting" /></xform:simpleDataSource>
									<xform:simpleDataSource value="6"><bean:message key="kmImeetingMain.createStep.base.fdSummaryInputPerson" bundle="km-imeeting" /></xform:simpleDataSource>
								</xform:checkbox>
							</td>		
						</tr>
						<tr>
							<td class="td_normal_title" width=15%>
								<bean:message key="kmImeetingFeedback.viewPerson.config" bundle="km-imeeting" />
							</td>
							<td colspan="3">
								<xform:checkbox property="value(feedbackViewPerson)">
									<xform:simpleDataSource value="1"><bean:message key="kmImeetingFeedback.viewPerson.docCreator" bundle="km-imeeting" /></xform:simpleDataSource>
									<xform:simpleDataSource value="2"><bean:message key="kmImeetingFeedback.viewPerson.fdHost" bundle="km-imeeting" /></xform:simpleDataSource>
									<xform:simpleDataSource value="3"><bean:message key="kmImeetingFeedback.viewPerson.fdSummaryInputPerson" bundle="km-imeeting" /></xform:simpleDataSource>
								</xform:checkbox>
							</td>		
						</tr>
						
						<tr style="display:none">
							<td class="td_normal_title" width=15%>
								<bean:message bundle="km-imeeting" key="kmImeetingTopic.config" />
							</td>
							<td colspan="3">
								<ui:switch property="value(topicMng)" checkVal="2" unCheckVal="1" enabledText="${ lfn:message('km-imeeting:kmImeeting.topicMng.on') }" disabledText="${ lfn:message('km-imeeting:kmImeeting.topicMng.off') }" ></ui:switch>
							</td>
						</tr>
						<tr>
							<td class="td_normal_title" width=15%>
								<bean:message bundle="km-imeeting" key="appConfig.tongyiyunxushanghui" />
							</td>
							<td colspan="3">
								<ui:switch property="value(topicAcceptRepeat)" checkVal="2" unCheckVal="1" enabledText="${ lfn:message('km-imeeting:kmImeeting.topicAcceptRepeat.on') }" disabledText="${ lfn:message('km-imeeting:kmImeeting.topicAcceptRepeat.off') }" ></ui:switch>
							</td>
						</tr>
						<tr>
							<td class="td_normal_title" width=15%>
								<bean:message bundle="km-imeeting" key="appConfig.imissiveSummaryEnable" />
							</td>
							<td colspan="3">
								<ui:switch property="value(imissiveSummaryEnable)" checked="true"  checkVal="true" unCheckVal="false" enabledText="${ lfn:message('km-imeeting:appConfig.on') }" disabledText="${ lfn:message('km-imeeting:appConfig.off') }" ></ui:switch>
								<span style="color: red;"><bean:message bundle="km-imeeting" key="appConfig.imissiveSummaryEnable.tip"/></span>
							</td>
						</tr>
					</table>
					<div style="margin-bottom: 10px;margin-top:25px">
						   <ui:button text="${lfn:message('button.save')}" height="35" width="120" onclick="Com_Submit(document.sysAppConfigForm, 'update');" order="1" ></ui:button>
					</div>
					</center>
			</div>
			
		</html:form>
		<script type="text/javascript">
			window.onload = function(){
				var unShow=document.getElementsByName("unShow")[0];
				var unShowValue=document.getElementsByName("value(unShow)")[0];
				if(unShowValue.value=="false"){
					unShow.checked=false;
				}else{
					unShow.checked=true;
				}
				
				var setICS=document.getElementsByName("setICS")[0];
				var setICSValue=document.getElementsByName("value(setICS)")[0];
				if(setICSValue.value=="false"){
					setICS.checked=false;
				}else{
					setICS.checked=true;
				}
			};
			
			function changeValue(thisObj){
				var unShow=document.getElementsByName("unShow")[0];
				var unShowValue=document.getElementsByName("value(unShow)")[0];
				if(unShow.checked){
					unShowValue.value="true";
				}else{
					unShowValue.value="false";
				}
			}
			function changeICS(thisObj){
				var setICS=document.getElementsByName("setICS")[0];
				var setICSValue=document.getElementsByName("value(setICS)")[0];
				if(setICS.checked){
					setICSValue.value="true";
				}else{
					setICSValue.value="false";
				}
			}
		</script>
	</template:replace>
</template:include>