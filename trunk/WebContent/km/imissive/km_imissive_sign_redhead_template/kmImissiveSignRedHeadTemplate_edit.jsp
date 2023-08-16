<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>

<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>
<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
<script>
Com_IncludeFile("doclist.js|dialog.js|calendar.js|optbar.js|jquery.js");
</script>
<script language="JavaScript">
$(document).ready(function(){
	checkEditType("${kmImissiveSignRedHeadTemplateForm.fdType}", null);
	if("${_isWpsCloudEnable}" == "true"){
		var table = document.getElementById("Label_Tabel");
		if(table != null && window.Doc_AddLabelSwitchEvent){
			Doc_AddLabelSwitchEvent(table, "showWps");
		}
	}else if("${_isWpsCenterEnable}" == "true"){
		var table = document.getElementById("Label_Tabel");
		if(table != null && window.Doc_AddLabelSwitchEvent){
			Doc_AddLabelSwitchEvent(table, "showWpsCenter");
		}
	}
});
var wpsFlag = false;
function showWps(tableName,index){
	var trs = document.getElementById(tableName).rows;
	var type=document.getElementsByName("fdType")[0];
	if(trs[index].id =="tr_content" && type.value =="0"){
		if(!wpsFlag){
			wps_cloud_editonline.load();
			wpsFlag = true;
		}
	}
}
var wpsCenterFlag = false;
function showWpsCenter(tableName,index){
	var trs = document.getElementById(tableName).rows;
	var type=document.getElementsByName("fdType")[0];
	if(trs[index].id =="tr_content" && type.value =="0"){
		if(!wpsCenterFlag){
			wps_center_editonline.load();
			var styleOffice = document.getElementById("office-iframe");
			styleOffice.style.height='580px';
			styleOffice.style.width='100%';
			wpsCenterFlag = true;
		}
	}
}
function Cate_CheckNotReaderFlag(el){
	document.getElementById("Cate_AllUserId").style.display=el.checked?"none":"";
	document.getElementById("Cate_AllUserNote").style.display=el.checked?"none":"";
	el.value=el.checked;
}
function checkEditType(value){
	var type=document.getElementsByName("fdType")[0];
	var _templateDesc = document.getElementById('templateDesc');
	var _categoryDesc = document.getElementById('categoryDesc');
	var authNotReaderFlag=document.getElementsByName("authNotReaderFlag")[0];
	var _wpsImissive = document.getElementById('wpsImissive');
	if(value==""){
		value = "0";
	}
	if("0" == value){
		_templateDesc.style.display = "block";
		_categoryDesc.style.display = "none";
		if("${wpsoaassist}" == "true"){
			_wpsImissive.style.display = "block";
		}
		$("#missiveButtonDiv").show();
		$("#wordEdit").css({ 
			width:'100%',
			height:'600px'

		});
		authNotReaderFlag.checked = "";
		authNotReaderFlag.onclick = function(){Cate_CheckNotReaderFlag(authNotReaderFlag);};
		Cate_CheckNotReaderFlag(authNotReaderFlag);
	} else {
		_categoryDesc.style.display = "block";
		_templateDesc.style.display = "none";
		if("${wpsoaassist}" == "true"){
			_wpsImissive.style.display = "none";
		}
		$("#wordEdit").css({
			width:'0px',
			height:'0px'
		});
		$("#missiveButtonDiv").hide();
		authNotReaderFlag.checked = "checked";
		authNotReaderFlag.onclick=function(){return false;};
		Cate_CheckNotReaderFlag(authNotReaderFlag);
	}
	type.value = value;
}

Com_Parameter.event["submit"].push(function(){
		//提交时判断是模板还是分类，如果是分类则移除页面控件对象
		var type =  document.getElementsByName("fdType");
		var flag = false;
		if("${_isWpsCloudEnable}" == "true" || "${_isWpsCenterEnable}" == "true"){
			flag = true;
		}else {
			var obj = document.getElementById("JGWebOffice_editonline");
			if (type[0].value != "0") {
				if (obj && Attachment_ObjectInfo['editonline'] && jg_attachmentObject_editonline.hasLoad) {
					jg_attachmentObject_editonline.unLoad();
				}
				$("#wordEdit").remove();
				flag = true;
			} else {
				if (obj && Attachment_ObjectInfo['editonline'] && jg_attachmentObject_editonline.hasLoad) {
					if (jg_attachmentObject_editonline.ocxObj) {
						jg_attachmentObject_editonline.ocxObj.Active(true);
					}
					if (!jg_attachmentObject_editonline._submit()) {
						return false;
					}
				}
				flag = true;
			}
		}
		return flag;
});

function addCategory(){
	seajs.use(['lui/dialog'],function(dialog){
		dialog.simpleCategory('com.landray.kmss.km.imissive.model.KmImissiveSignRedHeadTemplate','fdParentId','fdParentName',false,Cate_getParentMaintainer,null,true,null,false);
	});
}

</script>
<html:form action="/km/imissive/km_imissive_sign_redhead_template/kmImissiveSignRedHeadTemplate.do">
	<c:import url="/sys/simplecategory/sys_simple_category/sysCategoryMain_edit_button.jsp"
				charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSignRedHeadTemplateForm" />
	</c:import>
<p class="txttitle"><bean:message  bundle="km-imissive" key="table.kmImissiveRedHeadTemplate"/></p>
<center>
<table id="Label_Tabel" width="95%">
	<tr LKS_LabelName="<bean:message bundle="km-imissive" key="kmImissiveRedHeadTemplate.template.fdName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:set var="selectEmpty" value="true" />
				<kmss:auth
					requestURL="/km/imissive/km_imissive_sign_redhead_template/kmImissiveSignRedHeadTemplate.do?method=add"
					requestMethod="Get">
					<c:set var="selectEmpty" value="false" />
				</kmss:auth>
				<html:hidden property="fdId" />
				 <%-- 编辑方式 --%>
				<html:hidden property="fdType" />
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imissive" key="kmImissiveRedHeadTemplate.fdType" />
					</td>
					<td width="85%" colspan="3">
						<xform:radio property="fdEditType" showStatus="edit" value="${kmImissiveSignRedHeadTemplateForm.fdType}" onValueChange="checkEditType">
							<xform:enumsDataSource enumsType="kmImissiveRedHeadTemplate_fdType" />
						</xform:radio><br><div style="margin-top:5px"><bean:message bundle="km-imissive" key="kmImissiveRedHeadTemplate.fdType.desc" /></div>
					</td>
				</tr>
				<!-- 模板名称 -->
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imissive" key="kmImissiveRedHeadTemplate.fdName" />
					</td><td colspan="3">
						<xform:text property="fdName" style="width:90%"  required="true" validators="maxLength(200)"/>
					</td>
				</tr>
               <tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveRedHeadTemplate.fdParentName" /></td>
					<td colspan="3"><html:hidden property="fdParentId" /> <html:text
						property="fdParentName" readonly="true" styleClass="inputsgl"
						style="width:90%" /> <a href="#"
						onclick="addCategory();null">
					<bean:message key="dialog.selectOther" /> </a></td>
				</tr> 
				<tr>
					<td class="td_normal_title" width=15%><bean:message bundle="km-imissive"
						key="kmImissiveRedHeadTemplate.parentMaintainer" /></td>
						<td colspan="3" id="parentMaintainerId">${parentMaintainer}</td>					 
							</tr>
							<%---更改父类时同时修改继承上级分类维护者---%>
							<script>
					function checkParentId(){
						var formObj = document.forms['kmImissiveSignRedHeadTemplateForm'];
						if(formObj.fdParentId.value!="" && formObj.fdParentId.value==formObj.fdId.value){
							alert('<bean:message bundle="sys-simplecategory" key="error.illegalSelected" />');
							return false;
						}else
							return true;	
					}
					Com_Parameter.event["submit"][Com_Parameter.event["submit"].length] = checkParentId;
			
					function Cate_getParentMaintainer(){				
						var parameters ="parentId="+document.getElementsByName("fdParentId")[0].value;
						var s_url = Com_Parameter.ContextPath+"km/imissive/km_imissive_sign_redhead_template/kmImissiveSignRedHeadTemplate.do?method=getParentMaintainer";
						$.ajax({
							url: s_url,
							type: "GET",
							data: parameters,
							dataType:"text",
							async: false,
							success: function(text){
								Com_SetInnerText(document.getElementById("parentMaintainerId"),text);
							}});
					}
				</script>
				<%-- 所属场所 --%>
                <c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
                    <c:param name="id" value="${kmImissiveSignRedHeadTemplateForm.authAreaId}"/>
                </c:import> 
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message key="model.fdOrder" />
					</td><td colspan="3">
						<xform:text property="fdOrder" validators="digits maxLength(10)"/>
					</td>			
				</tr>	
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						key="model.tempEditorName" /></td>
					<td colspan="3">
					<xform:address textarea="true" mulSelect="true" propertyId="authEditorIds" propertyName="authEditorNames" orgType="ORG_TYPE_ALL" style="width:97%;height:90px;" ></xform:address>
					<div class="description_txt">
					<bean:message bundle="sys-simplecategory" key="description.main.tempEditor" />
					</div>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						key="model.tempReaderName" /></td>
					<td colspan="3">
					<input type="checkbox"  name="authNotReaderFlag" value="${sysSimpleCategoryMain.authNotReaderFlag}" onclick="Cate_CheckNotReaderFlag(this);" 
					<c:if test="${sysSimpleCategoryMain.authNotReaderFlag eq 'true'}">checked</c:if>>
					<bean:message bundle="sys-simplecategory" key="description.main.tempReader.notUse" />
					<div id="Cate_AllUserId">
					<xform:address textarea="true" mulSelect="true" propertyId="authReaderIds" propertyName="authReaderNames" orgType="ORG_TYPE_ALL" style="width:97%;height:90px;" ></xform:address>
					</div>
					<div id="Cate_AllUserNote">
					<bean:message bundle="sys-simplecategory" key="description.main.tempReader.allUse" />
					</div>
					</td>
				</tr>
				<tr>
	              <td  width="15%" class="td_normal_title" valign="top">
	                      <bean:message  bundle="km-imissive" key="kmImissiveRedHeadTemplate.fdDesc"/> 
	              </td>
	              <td width="85%" colspan="3">
	                <html:textarea property="fdDesc" style="width:90%;height:90px" 	styleClass="inputmul" />
	              </td>
                 </tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							key="model.fdCreator" /></td>
						<td width=35%><bean:write name="kmImissiveSignRedHeadTemplateForm" property="docCreatorName"/></td>
						<td class="td_normal_title" width=15%><bean:message
							key="model.fdCreateTime" /></td>
						<td width=35%><bean:write name="kmImissiveSignRedHeadTemplateForm" property="docCreateTime"/></td>			
					</tr>
					<c:if test="${kmImissiveSignRedHeadTemplateForm.docAlterorName!=''}">
						<tr>
							<td class="td_normal_title" width=15%><bean:message
								key="model.docAlteror" /></td>
							<td width=35%><bean:write name="kmImissiveSignRedHeadTemplateForm" property="docAlterorName"/></td>
							<td class="td_normal_title" width=15%><bean:message
								key="model.fdAlterTime" /></td>
							<td width=35%><bean:write name="kmImissiveSignRedHeadTemplateForm" property="docAlterTime"/></td>
						</tr>
					</c:if>
			</table>
		</td>
	</tr>													
	<tr id="tr_content" LKS_LabelName="<bean:message bundle="km-imissive" key="kmImissiveRedHeadTemplate.docContent" />">
		<td>
			<table class="tb_normal" width="100%">
			     <tr>
				    <td class="td_normal_title" width=10%> 
				        <bean:message key="kmImissiveRedHeadTemplate.hint" bundle="km-imissive"/>
				    </td>
				    <td>
				       <div id="templateDesc" style="display:none">
				        <bean:message key="kmImissiveRedHeadTemplate.hint.content1" bundle="km-imissive"/><br>
				         <bean:message key="kmImissiveRedHeadTemplate.hint.content2" bundle="km-imissive"/><br>
				          <bean:message key="kmImissiveRedHeadTemplate.hint.content3" bundle="km-imissive"/><br>
				       </div>
				       <div id="categoryDesc" style="display:none">
				                     模板类型为分类，不需要设置套红正文
				       </div>
				    </td>
				 </tr>
				<tr>
					<td width=100% colspan="2">
						<div id="wordEdit" style="height:600px;">
						<div id="missiveButtonDiv" style="text-align:right">
						   &nbsp;
						   <a href="javascript:void(0);" class="attbook" onclick="Com_OpenWindow(Com_Parameter.ContextPath+'km/imissive/km_imissive_sign_main/bookMarks.jsp','_blank');">
					       <bean:message key="kmImissive.bookMarks.title" bundle="km-imissive"/>
					       </a>
						</div>
						<div>
							<c:choose>
								<c:when test="${wpsoaassist eq 'true'}">
								<c:choose>
									<c:when test="${kmImissiveSignRedHeadTemplateForm.method_GET=='edit'}">
										<div id="wpsImissive">
										<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="editonline" />
											<c:param name="fdModelId" value="${kmImissiveSignRedHeadTemplateForm.fdId }" />
											<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveRedHeadTemplate" />
											<c:param name="fdMulti" value="false" />
											<c:param name="fdTemplateKey" value="editonline" />
											<c:param name="buttonDiv" value="missiveButtonDiv" />
											<c:param  name="fdViewType"  value="imissive"/>
											<c:param name="wpsExtAppModel" value="kmImissive" />
											<c:param name="newFlag" value="true" />
										</c:import>
										</div>
									</c:when>
									<c:otherwise>
										<div id="wpsImissive">
										<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
													<c:param name="fdKey" value="editonline" />
													<c:param name="fdModelId" value="${kmImissiveRedHeadTemplateForm.fdId }" />
													<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.kmImissiveSignRedHeadTemplateForm" />
													<c:param name="formBeanName" value="kmImissiveSignRedHeadTemplateForm" />
													<c:param name="uploadAfterSelect" value="true" />
													<c:param name="fdMulti" value="false" />
													<c:param  name="fdViewType"  value="imissive"/>
													<c:param name="wpsExtAppModel" value="kmImissive" />
													<c:param name="newFlag" value="true" />
												</c:import>
										</div>
									</c:otherwise>
								</c:choose>
							</c:when>
								<c:when test="${_isWpsCloudEnable}">
									<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_edit.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="editonline" />
										<c:param name="load" value="false" />
										<c:param name="bindSubmit" value="false"/>	
										<c:param name="fdModelId" value="${kmImissiveSignRedHeadTemplateForm.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignRedHeadTemplate" />
										<c:param name="formBeanName" value="kmImissiveSignRedHeadTemplateForm" />
										<c:param name="fdTemplateKey" value="editonline" />
										<c:param name="buttonDiv" value="missiveButtonDiv" />
										<c:param name="isTemplate" value="true"/>
									</c:import>
								</c:when>
								<c:when test="${_isWpsCenterEnable}">
									<c:import url="/sys/attachment/sys_att_main/wps/center/sysAttMain_edit.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="editonline" />
										<c:param name="load" value="false" />
										<c:param name="bindSubmit" value="false"/>
										<c:param name="fdModelId" value="${kmImissiveSignRedHeadTemplateForm.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignRedHeadTemplate" />
										<c:param name="formBeanName" value="kmImissiveSignRedHeadTemplateForm" />
										<c:param name="fdTemplateKey" value="editonline" />
										<c:param name="buttonDiv" value="missiveButtonDiv" />
										<c:param name="isTemplate" value="true"/>
									</c:import>
								</c:when>
								<c:otherwise>
									<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_edit.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="editonline" />
										<c:param name="fdAttType" value="office" />
										<c:param name="fdModelId" value="${kmImissiveSignRedHeadTemplateForm.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignRedHeadTemplate" />
										<c:param name="buttonDiv" value="missiveButtonDiv" />
										<c:param name="bindSubmit" value="false"/>
										<c:param  name="isTemplate" value="true"/>
										<c:param  name="attHeight" value="580"/>
									</c:import>
								</c:otherwise>
							</c:choose>
					   </div>
					</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</center>
<script language="JavaScript">
			$KMSSValidation(document.forms['kmImissiveSignRedHeadTemplateForm']);
</script>
<html:hidden property="method_GET"/>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>