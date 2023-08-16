<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<table class="muiSimple" cellpadding="0" cellspacing="0">
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.docSubject"/>
		</td>
		<td>
			<xform:xtext property="docSubject" mobile="true" validators="maxLength(100)" required="true"/>
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdTopicCategory"/>
		</td>
		<td>
			<div style="display : inline-block;float:right;margin-right: 1.8rem;">
				<html:hidden property="fdTopicCategoryId"/>
				<span>
					<c:out value="${kmImeetingTopicForm.fdTopicCategoryName}"></c:out>
				</span>
			</div>
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdNo"/>
		</td>
		<td>
			<span style="float: right;margin-right: 1.2rem;">
				<c:out value="${lfn:message('km-imeeting:kmImeetingTopic.docNumber.edit')}"></c:out>
			</span>
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdReporter"/>
		</td>
		<td>
			<xform:address 
				propertyId="fdReporterId" 
				propertyName="fdReporterName" 
				subject="${lfn:message('km-imeeting:kmImeetingTopic.fdReporter')}" 
				orgType="ORG_TYPE_PERSON" 
				required="true" 
				mobile="true" />
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdChargeUnit"/>
		</td>
		<td>
			<xform:address
				propertyName="fdChargeUnitName" 
				propertyId="fdChargeUnitId" 
				required="false"
				orgType="ORG_TYPE_ORGORDEPT"
				mobile="true" />
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdMaterialStaff"/>
		</td>
		<td>
			<xform:address 
				propertyId="fdMaterialStaffId" 
				propertyName="fdMaterialStaffName" 
				orgType="ORG_TYPE_PERSON" 
				required="false" 
				mobile="true" />
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdSourceSubject"/>
		</td>
		<td>
			<xform:text property="fdSourceSubject" showStatus="edit" mobile="true" />
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdAttendUnit"/>
		</td>
		<td>
			<div id="attend_m">
		    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_attend_m"
			    	 data-dojo-props='"afterSelect":function(evt){afterSelectAttend(evt);},"idField":"fdAttendUnitIds","nameField":"fdAttendUnitNames","curIds":"${kmImeetingTopicForm.fdAttendUnitIds}","curNames":"${kmImeetingTopicForm.fdAttendUnitNames}","subject":"建议列席单位","title":"建议列席单位","showStatus":"edit","isMul":true,"required":true,
			   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileDataBeanService&parentId=!{parentId}",
			   		  "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=all&fdKeyWord=!{keyword}",
			   		  "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
			   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
				</div>
				<script type="text/javascript">
					require(['dojo/query'], function(query) {
						window.afterSelectAttend = function(evt) {
							var attendIds = evt.curIds;
							var fdAttendUnitIds = "";
							if (!attendIds) {
								return;
							}
							if (attendIds.indexOf("_cate") > 0) {
								attendIdsArr = attendIds.split(";");
								for (var i = 0; i < attendIdsArr.length; i++) {
									if (attendIdsArr[i]) {
										fdAttendUnitIds += attendIdsArr[i].substring(0, attendIdsArr[i].indeOf("_cate")) + ";";
									} else {
										fdAttendUnitIds += attendIdsArr[i] + ";";
									}
								}
								query("[name='fdAttendUnitIds']")[0].value = fdAttendUnitIds.substring(0, fdAttendUnitIds.length - 1);
							}
						}
		            });
				</script>
			</div>
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdListenUnit"/>
		</td>
		<td>
			<div id="listen_m">
		    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_listen_m"
			    	 data-dojo-props='"afterSelect":function(evt){afterSelectListen(evt);},"idField":"fdListenUnitIds","nameField":"fdListenUnitNames","curIds":"${kmImeetingTopicForm.fdListenUnitIds}","curNames":"${kmImeetingTopicForm.fdListenUnitNames}","subject":"建议旁听单位","title":"建议旁听单位","showStatus":"edit","isMul":true,"required":false,
			   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileDataBeanService&parentId=!{parentId}",
			   		  "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=all&fdKeyWord=!{keyword}",
			   		  "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
			   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
				</div>
				<script type="text/javascript">
					require(['dojo/query'], function(query) {
						window.afterSelectListen = function(evt) {
							var listenIds = evt.curIds;
							var fdListenUnitIds = "";
							if (!listenIds) {
								return;
							}
							if (listenIds.indexOf("_cate") > 0) {
								listenIdsArr = listenIds.split(";");
								for (var i = 0; i < listenIdsArr.length; i++) {
									if (listenIdsArr[i]) {
										fdListenUnitIds += listenIdsArr[i].substring(0, listenIdsArr[i].indeOf("_cate")) + ";";
									} else {
										fdListenUnitIds += listenIdsArr[i] + ";";
									}
								}
								query("[name='fdListenUnitIds']")[0].value = fdListenUnitIds.substring(0, fdListenUnitIds.length - 1);
							}
						}
		            });
				</script>
			</div>
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.issue.text"/>
		</td>
		<td>
			<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="mainonline" />
				<c:param name="fdMulti" value="false" />
				<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
				<c:param name="formName" value="kmImeetingTopicForm"/>
				<c:param name="enabledFileType" value="doc|docx|xls|xlsx|ppt|pptx|xlc|mppx|xlcx|wps|et|vsd|rtf|pdf" />
			</c:import> 
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.issue.material"/>
		</td>
		<td>
			<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="attachment" />
				<c:param name="fdRequired" value="true" />
				<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
				<c:param name="formName" value="kmImeetingTopicForm"/>
				<c:param name="enabledFileType" value="doc|docx|xls|xlsx|ppt|pptx|xlc|mppx|xlcx|wps|et|vsd|rtf|pdf" />
			</c:import> 
		</td>
	</tr>
</table>