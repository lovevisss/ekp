<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%
	String imissiveSummaryEnable = KmImeetingConfigUtil.imissiveSummaryEnable();
	request.setAttribute("imissiveSummaryEnable", imissiveSummaryEnable);
%>
<script>Com_IncludeFile("dialog.js|doclist.js|calendar.js|jquery.js");</script>
<script src="./resource/weui_switch.js"></script>
<html:form action="/km/imeeting/km_imeeting_template/kmImeetingTemplate.do">
<div id="optBarDiv">
	<c:if test="${kmImeetingTemplateForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="commitMethod(document.kmImeetingTemplateForm, 'update');">
	</c:if>
	<c:if test="${kmImeetingTemplateForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="commitMethod(document.kmImeetingTemplateForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="commitMethod(document.kmImeetingTemplateForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-imeeting" key="table.kmImeetingTemplate.card"/></p>

<center>
<html:hidden property="fdId" />
<table id="Label_Tabel" width=95%>
	<%--会务安排--%>
	<tr LKS_LabelName="<bean:message  bundle="km-imeeting" key="kmImeetingTemplate.infoTitle"/>">
		<td>
			<table class="tb_normal" width=100%>
				<tr>
					<%--模板名称--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdName"/>
					</td>
					<td width="85%" colspan="3">
						<xform:text property="fdName" style="width:85%" />
					</td>
				</tr>
				<tr>
					<%--类别--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingTemplate.docCategoryId"/>
					</td>
					<td colspan="3">
						<html:hidden property="docCategoryId" /> 
						<html:text property="docCategoryName" readonly="true" styleClass="inputsgl" style="width:85%" /> 
						<a href="#" onclick="Dialog_Category('com.landray.kmss.km.imeeting.model.KmImeetingTemplate','docCategoryId','docCategoryName');">
							<span class="txtstrong">*</span><bean:message key="dialog.selectOther" />
						</a>
						<c:if test="${not empty noAccessCategory}">
							<script language="Javascript">
								function closeWindows(rtnVal){
									if(rtnVal==null){
										window.close();
									}
								}
								if(!confirm("<bean:message arg0='${noAccessCategory}' key='error.noAccessCreateTemplate.alert' />")){
									window.close();
								}else{
									Dialog_Category('com.landray.kmss.km.imeeting.model.KmImeetingTemplate','docCategoryId','docCategoryName',null,null,null,null,closeWindows, true);
								}
							</script>
						</c:if>
					</td>
				</tr>
				<tr>
					<%--排序号--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdOrder"/>
					</td>
					<td width="85%" colspan="3">
						<xform:text property="fdOrder" style="width:100px" />
					</td>
				</tr>
				<tr>
					<%--是否可用 --%>
					<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdIsAvailable" />
					</td>
					<td width="85%" colspan="3">
						<html:hidden property="fdIsAvailable" /> 
						<label class="weui_switch">
							<span class="weui_switch_bd">
								<input type="checkbox" ${'true' eq kmImeetingTemplateForm.fdIsAvailable ? 'checked' : '' } />
								<span></span>
								<small></small>
							</span>
							<span id="fdIsAvailableText"></span>
						</label>
						<script type="text/javascript">
							function setText(status) {
								if(status) {
									$("#fdIsAvailableText").text('<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdIsAvailable.true" />');
								} else {
									$("#fdIsAvailableText").text('<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdIsAvailable.false" />');
								}
							}
							$(".weui_switch :checkbox").on("click", function() {
								var status = $(this).is(':checked');
								$("input[name=fdIsAvailable]").val(status);
								setText(status);
							});
							setText(${kmImeetingTemplateForm.fdIsAvailable});
						</script>
					</td>
				</tr>
				<tr>
					<%--可使用者--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingTemplate.authReaders"/>
					</td>
					<td width="85%" colspan="3">
						<xform:address textarea="true"  propertyId="authReaderIds" propertyName="authReaderNames" orgType="ORG_TYPE_ALL" style="width:85%" mulSelect="true"/>
						<br><bean:message bundle="km-imeeting" key="kmImeetingTemplate.authReaders.tip" />
					</td>
				</tr>
				<tr>
					<%--可维护者--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingTemplate.authEditors"/>
					</td>
					<td width="85%" colspan="3">
						<xform:address textarea="true"  propertyId="authEditorIds" propertyName="authEditorNames" orgType="ORG_TYPE_ALL" style="width:85%" mulSelect="true"/>
						<br><bean:message bundle="km-imeeting" key="kmImeetingTemplate.authEditors.tip" />
					</td>
				</tr>
				<%-- 所属场所 --%>
				<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
                     <c:param name="id" value="${kmImeetingTemplateForm.authAreaId}"/>
                </c:import>
				<tr><td colspan="4">&nbsp;</td></tr>
				<tr>
					<%--会议主题--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingTemplate.docSubject"/>
					</td>
					<td width="85%" colspan="3">
						<xform:text property="docSubject" style="width:85%" />
					</td>
				</tr>
				<tr>
					<%--纪要录入人--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdSummaryInputPerson"/>
					</td>
					<td width="85%" colspan="3">
						<xform:address propertyId="fdSummaryInputPersonId" propertyName="fdSummaryInputPersonName" orgType="ORG_TYPE_PERSON" style="width:34%" />
					</td>
				</tr>
				<%-- <kmss:ifModuleExist path="/km/vote">
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imeeting" key="kmImeeting.relate.voteTemplate"/>
						</td>
						<td width="85%" colspan="3">
							<c:import url="/km/vote/import/kmVoteCategory_edit.jsp">
								<c:param name="formName" value="kmImeetingTemplateForm"></c:param>
							</c:import>
						</td>
					</tr>
				</kmss:ifModuleExist> --%>
			</table>
		</td>
	</tr>
	<%-- 会议主文档流程 --%>
	<c:import url="/sys/workflow/include/sysWfTemplate_edit.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmImeetingTemplateForm" />
		<c:param name="fdKey" value="ImeetingMain" />
		<c:param name="messageKey" value="km-imeeting:kmImeetingTemplate.mainflow" />
	</c:import>
	<c:if test="${imissiveSummaryEnable != 'true'}">
		<%-- 纪要模板 --%>	
		<tr LKS_LabelName="<bean:message  bundle="km-imeeting" key="kmImeetingTemplate.fdSummaryContent"/>">
			<td>
				<table class="tb_normal" width=100%>
					<!-- 启用电子盖章 -->
					<kmss:ifModuleExist path="/elec/yqqs">
					 	<tr>
					 		<td class="td_normal_title" width=15%>
					 			<bean:message bundle="km-imeeting" key="KmImeetingTemplate.fdSignEnable"/>
					 		</td>
					 		<td colspan="3" >
								<ui:switch property="fdSignEnable" showType="edit" checked="${kmImeetingTemplateForm.fdSignEnable}"  checkVal="true" unCheckVal="false"/>
								<bean:message bundle="km-imeeting" key="KmImeetingTemplate.fdSignEnable.tip"/>
							</td>
					 	</tr>
				 	</kmss:ifModuleExist>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdSummaryContent" /></td>
						<td colspan="3">
							<kmss:editor property="fdSummaryContent" height="300" width="100%" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<!-- 会议纪要流程 -->
		<c:import url="/sys/workflow/include/sysWfTemplate_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmImeetingTemplateForm" />
			<c:param name="fdKey" value="ImeetingSummary" />
			<c:param name="messageKey" value="km-imeeting:kmImeetingTemplate.summaryTemplate" />
		</c:import>
	</c:if>
	<%--发布 --%>
	<c:import url="/sys/news/include/sysNewsPublishCategory_edit.jsp"	charEncoding="UTF-8">
		<c:param name="formName" value="kmImeetingTemplateForm" />
		<c:param name="fdKey" value="ImeetingMain" />
	</c:import>
	<%--权限 --%>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/tmp_right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingTemplateForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTemplate" />
				</c:import>
			</table>
		</td>
	</tr>
	<%--编号机制 --%>
	<c:import url="/sys/number/include/sysNumberMappTemplate_edit.jsp" charEncoding="UTF-8">
    	<c:param name="formName" value="kmImeetingTemplateForm" />
   		<c:param name="modelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain"/>
    </c:import>
    <%--日程机制(普通模块) 开始--%>
	<tr LKS_LabelName="<bean:message bundle="sys-agenda" key="module.sys.agenda.syn" />">
	  <td>
	  	<table class="tb_normal" width=100%>
	  		<%--同步时机 --%>
			<tr>
				<td width="15%">
					<c:out value="同步时机"></c:out>
				</td>
				<td width="85%" colspan="3">
					<xform:radio property="syncDataToCalendarTime"  showStatus="edit">
						<xform:enumsDataSource enumsType="kmImeetingMain_syncDataToCalendarTime" />
					</xform:radio>
					<br>
					<font color="red"><bean:message bundle="km-imeeting" key="kmImeetingMain.agenda.syn.tip"/></font>
				</td>
			</tr>
			<tr>
				<td colspan="4" style="padding: 0px;">
					 <c:import url="/sys/agenda/include/sysAgendaCategory_general_edit.jsp"	charEncoding="UTF-8">
						<c:param name="formName" value="kmImeetingTemplateForm" />
						<c:param name="fdKey" value="ImeetingMain" />
						<c:param name="fdPrefix" value="sysAgendaCategory_formula_edit" />
						<c:param name="fdMainModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
						<c:param name="syncTimeProperty" value="syncDataToCalendarTime" />
						<c:param name="noSyncTimeValues" value="noSync" />
					</c:import>
				</td>
			</tr>
		</table>
	  </td>
	</tr>
	<c:if test="${imissiveSummaryEnable != 'true'}">
		<!-- 沉淀设置 -->
		<c:import url="/kms/multidoc/kms_multidoc_subside/include/kmsSubsideFileSetting_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImeetingTemplateForm" />
			<c:param name="fdKey" value="ImeetingSummary" />
			<c:param name="modelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary" />
			<c:param name="templateService" value="kmImeetingTemplateService" />
		</c:import>
	</c:if>
	
	<c:choose>
		<c:when test="${imissiveSummaryEnable == 'true'}">
			<!-- 规则机制 -->
			<c:import url="/sys/rule/sys_ruleset_temp/sysRuleTemplate_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingTemplateForm" />
				<c:param name="fdKey" value="ImeetingMain" />
				<c:param name="messageKey" value="通知流程规则设置" />
				<c:param name="templateModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTemplate"></c:param>
			</c:import>
		</c:when>
		<c:otherwise>
			<!-- 规则机制 -->
			<c:import url="/sys/rule/sys_ruleset_temp/sysRuleTemplate_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingTemplateForm" />
				<c:param name="fdKey" value="ImeetingMain;ImeetingSummary" />
				<c:param name="messageKey" value="会议流程规则设置;纪要流程规则设置" />
				<c:param name="templateModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTemplate"></c:param>
			</c:import>
		</c:otherwise>
	</c:choose>
	
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	Com_IncludeFile("dialog.js|jquery.js");
	var validation=$KMSSValidation();
</script>
<script>
	//判断是否为整数
	function isInteger(str) {
		var type= "^\s*[+]?[0-9]+\s*$";
		var re = new RegExp(type);
		if(str.match(re) != null) {
			return true;
		}
		return false;
	}
	
	//#9205自定义校验器:当模板中召开周期选择 非不定期时，要求会议组织人必填
	validation.addValidator('validateFdEmcee','<bean:message bundle="km-imeeting" key="kmImeetingTemplate.validate.fdEmcee" />',function(v, e, o){
		/* if(!document.getElementsByName("fdPeriodType")[4].checked && (v==null || v=="")){
			return false;
		} */
		return true;
	});
	
	validation.addValidator('validateFdPeriodType','<bean:message bundle="km-imeeting" key="kmImeetingTemplate.errors.positive.integer" argKey0="kmImeetingTemplate.fdNotifyDay" />',function(v, e, o){
		var validator = this.getValidator('validateFdPeriodType');
		if(!document.getElementsByName("fdPeriodType")[4].checked && !isInteger(v)){
			validator.error = '<bean:message bundle="km-imeeting" key="kmImeetingTemplate.errors.positive.integer" argKey0="kmImeetingTemplate.fdNotifyDay" />';
			return false;
		}
		if(document.getElementsByName("fdPeriodType")[0].checked && v > 366){
			validator.error = '<bean:message bundle="km-imeeting" key="kmImeetingTemplate.validateFdPeriodType.tip1" />';
			return false;
		}
		if(document.getElementsByName("fdPeriodType")[1].checked && v > 90){
			validator.error = '<bean:message bundle="km-imeeting" key="kmImeetingTemplate.validateFdPeriodType.tip2" />';
			return false;
		}
		if(document.getElementsByName("fdPeriodType")[2].checked && v > 31){
			validator.error = '<bean:message bundle="km-imeeting" key="kmImeetingTemplate.validateFdPeriodType.tip3" />';
			return false;
		}
		if(document.getElementsByName("fdPeriodType")[3].checked && v > 7){
			validator.error = '<bean:message bundle="km-imeeting" key="kmImeetingTemplate.validateFdPeriodType.tip4" />';
			return false;
		}
		return true;
	});
	
	$('[name="fdPeriodType"]').bind("change",function(){
		validation.validate(document.getElementsByName("fdEmceeName")[0]);
	});
	
	//提交表单
	function commitMethod(form,method){
		/* var msg = 's';
		 // 不定期不验证
		if (!document.getElementsByName("fdPeriodType")[4].checked) {
			var notifyDay = document.getElementsByName("fdNotifyDay")[0].value;
			if(notifyDay == '') {
				// 催办时间不能为空
				msg += '<bean:message key="errors.required" argKey0="km-imeeting:kmImeetingTemplate.fdNotifyDay" />' + '\r\n';
			} 
		}
		if (msg != '') {
			alert(msg);
		}else{ */
			Com_Submit(form, method);
		/* } */
	}
</script>
	
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>