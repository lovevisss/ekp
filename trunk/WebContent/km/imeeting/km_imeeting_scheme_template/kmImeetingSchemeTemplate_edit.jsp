<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script>Com_IncludeFile("dialog.js|doclist.js|calendar.js|jquery.js");</script>
<script src="./resource/weui_switch.js"></script>
<html:form action="/km/imeeting/km_imeeting_scheme_template/kmImeetingSchemeTemplate.do">
<div id="optBarDiv">
	<c:if test="${kmImeetingSchemeTemplateForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="commitMethod(document.kmImeetingSchemeTemplateForm, 'update');">
	</c:if>
	<c:if test="${kmImeetingSchemeTemplateForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="commitMethod(document.kmImeetingSchemeTemplateForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="commitMethod(document.kmImeetingSchemeTemplateForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-imeeting" key="kmImeetingScheme.config"/></p>

<center>
<html:hidden property="fdId" />
<table id="Label_Tabel" width=95%  LKS_LabelDefaultIndex="2">
	<%--会务安排--%>
	<tr LKS_LabelName="基本信息">
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
						<a href="#" onclick="Dialog_Category('com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate','docCategoryId','docCategoryName');">
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
									Dialog_Category('com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate','docCategoryId','docCategoryName',null,null,null,null,closeWindows, true);
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
								<input type="checkbox" ${'true' eq kmImeetingSchemeTemplateForm.fdIsAvailable ? 'checked' : '' } />
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
							setText(${kmImeetingSchemeTemplateForm.fdIsAvailable});
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
                     <c:param name="id" value="${kmImeetingSchemeTemplateForm.authAreaId}"/>
                </c:import>
				<tr><td colspan="4">&nbsp;</td></tr>
			</table>
		</td>
	</tr>

	<c:import url="/sys/xform/include/sysFormTemplate_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImeetingSchemeTemplateForm" />
		<c:param name="fdKey" value="ImeetingScheme" />
		<c:param name="messageKey" value="km-imeeting:py.BiaoDanMuBan" />
		<c:param name="fdMainModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme" />
		<c:param name="useLabel" value="true" />
	</c:import>

	<%-- 会议主文档流程 --%>
	<c:import url="/sys/workflow/include/sysWfTemplate_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImeetingSchemeTemplateForm" />
		<c:param name="fdKey" value="ImeetingScheme" />
		<c:param name="messageKey" value="km-imeeting:kmImeetingTemplate.mainflow" />
	</c:import>
	<%--权限 --%>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/tmp_right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingSchemeTemplateForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate" />
				</c:import>
			</table>
		</td>
	</tr>
	<c:import url="/sys/news/include/sysNewsPublishCategory_edit.jsp"	charEncoding="UTF-8">
		<c:param name="formName" value="kmImeetingSchemeTemplateForm" />
		<c:param name="fdKey" value="ImeetingScheme" />
	</c:import>
	<%--编号机制 --%>
	<c:import url="/sys/number/include/sysNumberMappTemplate_edit.jsp" charEncoding="UTF-8">
    	<c:param name="formName" value="kmImeetingSchemeTemplateForm" />
   		<c:param name="modelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme"/>
    </c:import>
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
	
	
	
	$('[name="fdPeriodType"]').bind("change",function(){
		validation.validate(document.getElementsByName("fdEmceeName")[0]);
	});
	
	//提交表单
	function commitMethod(form,method){
		if(typeof XForm_BeforeSubmitForm != 'undefined' && XForm_BeforeSubmitForm instanceof Function){
			XForm_BeforeSubmitForm(function(){
				Com_Submit(form, method);
			});
		}else{
			Com_Submit(form, method);
	    }
	}
	
</script>
	
</html:form>
<html:javascript formName="kmImeetingSchemeTemplateForm" cdata="false" dynamicJavascript="true" staticJavascript="false" />
<%@ include file="/resource/jsp/edit_down.jsp"%>