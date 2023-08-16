<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.xform.util.LangUtil"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<script src="../resource/js/weui_switch.js"></script>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>

<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<c:set var="xinChuangWps" value="<%=ImissiveUtil.isWPSOAassistEmbed(request)%>"/>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));

%>
<script>
Com_IncludeFile("dialog.js|calendar.js|optbar.js|jquery.js");
</script>
<script>
var _isWpsCloudEnable = "${_isWpsCloudEnable}";
var wpsFlag = false;
var _isWpsCenterEnable = "${_isWpsCenterEnable}";
var wpsCenterFlag = false;
var _isXinChuangWps = "${xinChuangWps}";
var preIsWpsOaassitGw = false;
$(document).ready(function(){
	//默认选中表单模式
	var method = "${kmImissiveSendTemplateForm.method_GET}";
	
	if(method == "add"){
		if($('input:radio[name="sysFormTemplateForms.sendMainDoc.fdMode"]')){
			$('input:radio[name="sysFormTemplateForms.sendMainDoc.fdMode"][value="1"]').parent().hide();
			$('input:radio[name="sysFormTemplateForms.sendMainDoc.fdMode"][value="3"]').prop('checked', true);
		}
		if($('select[name="sysFormTemplateForms.sendMainDoc.fdMode"]')){
			$('select[name="sysFormTemplateForms.sendMainDoc.fdMode"]').children(":first").remove();
			$('select[name="sysFormTemplateForms.sendMainDoc.fdMode"]').children(":nth-child(1)").prop("selected","selected");
		}
	}
	if(method == "edit"){
		if($('input:radio[name="sysFormTemplateForms.sendMainDoc.fdMode"]')){
		   $('input:radio[name="sysFormTemplateForms.sendMainDoc.fdMode"][value="1"]').parent().hide();
		}
		if($('select[name="sysFormTemplateForms.sendMainDoc.fdMode"]')){
			$('select[name="sysFormTemplateForms.sendMainDoc.fdMode"]').children(":first").remove();
		}
	}
	//setTimeout("Doc_SetCurrentLabel('Label_Tabel', 2, true);", 500);
	//checkEditType("${kmImissiveSendTemplateForm.fdNeedContent}", null);

	// 添加标签切换事件
	var table = document.getElementById("Label_Tabel");
	if(table != null && window.Doc_AddLabelSwitchEvent){
		if(_isWpsCloudEnable == "true"){
			Doc_AddLabelSwitchEvent(table, "showWps");
		}else if(_isWpsCenterEnable == "true"){
			Doc_AddLabelSwitchEvent(table, "showWpsCenter");
		}else if(_isXinChuangWps == "true"){
			Doc_AddLabelSwitchEvent(table, "showXinChuangWps");
		}else{
			Doc_AddLabelSwitchEvent(table, "showJg");
		}
	}
	if("${wpsoaassist}" == "true"){
		var type=document.getElementsByName("fdNeedContent")[0];
		if (type.value == "" ||type.value == "0") {
			$("#wpsImissive").hide();
		}
		if (type.value =="1") {
			$("#wpsImissive").show();
		}
	}
});

function showXinChuangWps(tableName,index){
	var type=document.getElementsByName("fdNeedContent")[0];
	var trs = document.getElementById(tableName).rows;
	if("1" == type.value && trs[index].id =="tr_content"){
		$("#wordEdit").show();
		if(!preIsWpsOaassitGw){
			setTimeout(function(){
				wps_linux_editonline.load();
			}, 800);
			preIsWpsOaassitGw = true;
		}
	}else{
		if(type.value == ""){
			type.value = "0";
		}
		if(preIsWpsOaassitGw){
			wps_linux_editonline.setTmpFileByAttKey();
			wps_linux_editonline.isCurrent=false;
		}
		preIsWpsOaassitGw = false;
		$("#wordEdit").hide();
	}
}

function showWps(tableName,index){
	var type=document.getElementsByName("fdNeedContent")[0];
	var trs = document.getElementById(tableName).rows;
	if("1" == type.value && trs[index].id =="tr_content"){
		$("#wordEdit").show();
		if(!wpsFlag){
			wps_cloud_editonline.load();
			wpsFlag = true;
			if($('#office-iframe')){
				var contentH = document.documentElement.clientHeight || document.body.clientHeight;
		 		$('#office-iframe').height( (contentH-180)+"px");
		 	}
		}
	}else{
		if(type.value == ""){
			type.value = "0";
		}
		$("#wordEdit").hide();
	}
}

function showWpsCenter(tableName,index){
	var type=document.getElementsByName("fdNeedContent")[0];
	var trs = document.getElementById(tableName).rows;
	if("1" == type.value && trs[index].id =="tr_content"){
		$("#wordEdit").show();
		if(!wpsCenterFlag){
			wps_center_editonline.load();
			wpsCenterFlag = true;
			if($('#office-iframe')){
				var contentH = document.documentElement.clientHeight || document.body.clientHeight;
				$('#office-iframe').height( (contentH-180)+"px");
			}
		}
	}else{
		if(type.value == ""){
			type.value = "0";
		}
		$("#wordEdit").hide();
	}
}

function showJg(tableName,index){
	var type=document.getElementsByName("fdNeedContent")[0];
	var trs = document.getElementById(tableName).rows;
	if("1" == type.value && trs[index].id =="tr_content"){
		$("#wordEdit").css({ 
			width:'100%',
			height:'550px'

		});
		chromeHideJG_2015ByKey("editonline",1);
		$("#missiveButtonDiv").show();
		var obj = document.getElementById("JGWebOffice_editonline");
		 setTimeout(function(){
			 if(obj&&Attachment_ObjectInfo['editonline']&&!jg_attachmentObject_editonline.hasLoad){
				jg_attachmentObject_editonline.load();
				jg_attachmentObject_editonline.show();
				if(jg_attachmentObject_editonline.ocxObj){
					jg_attachmentObject_editonline.ocxObj.Active(true);
				}
			 }
		 },1000);
	}else{
		if(type.value == ""){
			type.value = "0";
		}
		var obj = document.getElementById("JGWebOffice_editonline");
		if(obj&&Attachment_ObjectInfo['editonline']&&jg_attachmentObject_editonline.hasLoad){
			chromeHideJG_2015ByKey("editonline",0);
		}
	}
	
	if(trs[index].id =="sysPrint_tab"){
		
		chromeHideJG_2015ByKey("sysprint_editonline",1);
		
	}else{
		
		chromeHideJG_2015ByKey("sysprint_editonline",0);
		
	}
}

function checkEditType(value){
	var type=document.getElementsByName("fdNeedContent")[0];
	if(value==""){
		value = "0";
	}
	if("1" == value){
		if("${xinChuangWps}" == "true"){
			$("#wpsImissive").show();
			setTimeout(function(){
				wps_linux_editonline.load();
			}, 800);
			preIsWpsOaassitGw = true;
			type.value = value;
			return;
		}
		if("${wpsoaassist}" == "true"){
			$("#wpsImissive").show();
			type.value = value;
			return;
		}
		$("#missiveButtonDiv").show();
		if(_isWpsCloudEnable == "true" && "${wpsoaassist}" != "true" ){
			$("#wordEdit").show();
			if(!wpsFlag){
				wps_cloud_editonline.load();
				wpsFlag = true;
				if($('#office-iframe')){
					var contentH = document.documentElement.clientHeight || document.body.clientHeight;
			 		$('#office-iframe').height( (contentH-180)+"px");
			 	}
			}

		}else if( _isWpsCenterEnable == "true"){
			$("#wordEdit").show();
			if(!wpsCenterFlag){
				wps_center_editonline.load();
				wpsCenterFlag = true;
				if($('#office-iframe')){
					var contentH = document.documentElement.clientHeight || document.body.clientHeight;
					$('#office-iframe').height( (contentH-180)+"px");
				}
			}
		}else{
			$("#wordEdit").css({ 
				width:'100%',
				height:'550px'

			});
			chromeHideJG_2015ByKey("editonline",1);
			var obj = document.getElementById("JGWebOffice_editonline");
			 setTimeout(function(){
				 if(!jg_attachmentObject_editonline.getOcxObj()){
						dialog.alert("当前浏览器检测不到金格控件,在线编辑功能无法使用，若是刚安装完金格控件，请刷新页面或重新浏览器试试！");
				}else{
					 if(obj&&Attachment_ObjectInfo['editonline']&&!jg_attachmentObject_editonline.hasLoad){
						jg_attachmentObject_editonline.load();
						jg_attachmentObject_editonline.show();
						if(jg_attachmentObject_editonline.ocxObj){
							jg_attachmentObject_editonline.ocxObj.Active(true);
						}
					 }
				}
			 },1000);
		}
	} else {
		$("#wpsImissive").hide();
		if(_isWpsCloudEnable == "true"|| _isWpsCenterEnable == "true"){
			$("#wordEdit").hide();
		}else{
			$("#wordEdit").css({
				width:'0px',
				height:'0px'
			});
		}
		$("#missiveButtonDiv").hide();
	}
	type.value = value;
}

Com_Parameter.event["submit"].push(function(){
	if(_isWpsCloudEnable == "true" || _isWpsCenterEnable == "true"){
		return true;
	}else if("${wpsoaassist}" == "true"){
		var type =  document.getElementsByName("fdNeedContent")[0];
		if(type.value ==""){
			type.value = "0";
		}
		return true;
	}else{
		//提交时判断是模板还是分类，如果是分类则移除页面控件对象
		var type =  document.getElementsByName("fdNeedContent");
		var flag = false;
		var obj = document.getElementById("JGWebOffice_editonline");
	  	if(type[0].value !="1"){
		  if(obj&&Attachment_ObjectInfo['editonline']&&jg_attachmentObject_editonline.hasLoad){
		 	 jg_attachmentObject_editonline.unLoad();
		  }
	     $("#wordEdit").remove();
	     flag = true;
	     }else{
	   	  if(obj&&Attachment_ObjectInfo['editonline']&&jg_attachmentObject_editonline.hasLoad){
		   		if(jg_attachmentObject_editonline.ocxObj){
					jg_attachmentObject_editonline.ocxObj.Active(true);
				}
	      		if(!jg_attachmentObject_editonline._submit()){
	      			return false;
    		    }
	   	  }
	       flag = true;
	    }
	    return flag;
	}
});

function submitForm(method) {
	if(typeof XForm_BeforeSubmitForm != 'undefined' && XForm_BeforeSubmitForm instanceof Function){
		XForm_BeforeSubmitForm(function(){
			Com_Submit(document.kmImissiveSendTemplateForm, method);
		});
	}else{
		Com_Submit(document.kmImissiveSendTemplateForm, method);
    }
}

var datas = [];
function openBookmarkHelp(){
	datas = [];
	var baseObjs;
	var fdType = $('select[name="sysFormTemplateForms.sendMainDoc.fdMode"]').find("option:selected").val();
	if(fdType == '2'){
		var fdTempId = document.getElementsByName("sysFormTemplateForms.sendMainDoc.fdCommonTemplateId")[0].value;
		baseObjs = _XForm_GetCommonExtDictObj(fdTempId);
	}else{
		var customIframe = window.frames['IFrame_FormTemplate_sendMainDoc'].contentWindow;
		if(!customIframe){
			customIframe = window.frames['IFrame_FormTemplate_sendMainDoc'];
		}
		if (customIframe.Designer && customIframe.Designer.instance && customIframe.Designer.instance.hasInitialized) {
			var designer = customIframe.Designer.instance;
			baseObjs = designer.getObj(null,null,true);
		} else {
			var xformTemplateId = document.getElementsByName("sysFormTemplateForms.sendMainDoc.fdCommonTemplateId")[0].value;
			baseObjs = _XForm_GetCommonExtDictObj(xformTemplateId);
		}
	}
	
	for(var i = 0 ; i< baseObjs.length;i++){
		if(baseObjs[i].controlType && baseObjs[i].controlType=='rtf'){
			
		}else{
			var record = {};
			record.label=baseObjs[i].label;
			var name =baseObjs[i].name;
			if(baseObjs[i].isXFormDict && name.indexOf('.') >-1){
				name=name.split('.')[1];
			}
			if(baseObjs[i].controlType && baseObjs[i].controlType=='auditShow'){
				name = name + "_auditShow";//区分审批意见
			}
			record.name = name;
			datas.push(record);
		}
	}
	Com_OpenWindow(Com_Parameter.ContextPath+'km/imissive/km_imissive_send_main/bookMarks.jsp','_blank');
}

</script>
<html:form action="/km/imissive/km_imissive_send_template/kmImissiveSendTemplate.do" onsubmit="return validateKmImissiveSendTemplateForm(this);">
	<div id="optBarDiv">
		<c:if test="${kmImissiveSendTemplateForm.method_GET=='edit'}">
			<%--更新--%>
			<input type=button value="<bean:message key="button.update"/>"
				onclick="submitForm('update');">
		</c:if>
		 <c:if test="${kmImissiveSendTemplateForm.method_GET=='add' || kmImissiveSendTemplateForm.method_GET=='clone'}">
		 	<%--新增--%>
			<input type=button value="<bean:message key="button.save"/>"
				onclick="submitForm('save');">
			<input type=button value="<bean:message key="button.saveadd"/>"
				onclick="submitForm('saveadd');">
		</c:if> 
			<%--关闭--%>
			<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
	</div>
<p class="txttitle"><bean:message  bundle="km-imissive" key="table.kmImissiveSendTemplate"/></p>
<center>
<table id="Label_Tabel" width="95%" LKS_LabelDefaultIndex="2">
		<tr LKS_LabelName="<bean:message bundle='km-imissive' key='kmImissiveSendTemplate.templateinfo'/>">
			<td>
				<table class="tb_normal" width=100%>
					<html:hidden property="fdId" />
					<%--模板名称--%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveSendTemplate.fdName" />
						</td>
						<td width=85% colspan="3">
						<%-- 
							<html:text property="fdName" style="width:80%;" /><span class="txtstrong">*</span>
						--%>
							<xform:text property="fdName" style="width:80%;" required="true"></xform:text>
						</td>
					</tr>
					<%--适用类别--%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveSendTemplate.fdCatoryName" />
						</td>
						<td width=35%>
							<html:hidden property="fdCategoryId" /> 
							<html:text property="fdCategoryName" readonly="true" styleClass="inputsgl" style="width:80%;" /> <span class="txtstrong">*</span>
							&nbsp;&nbsp;&nbsp;
							<a href="#" onclick="Dialog_Category('com.landray.kmss.km.imissive.model.KmImissiveSendTemplate','fdCategoryId','fdCategoryName');">
								<bean:message key="dialog.selectOther" />
							</a>
							<c:if test="${not empty noAccessCategory}">
								<script language="JavaScript">
									function closeWindows(rtnVal){
										if(rtnVal==null){
											window.close();
										}
									}
									if(!confirm("<bean:message arg0="${noAccessCategory}" key="error.noAccessCreateTemplate.alert" />")){
										window.close();
									}else{
										Dialog_Category('com.landray.kmss.km.imissive.model.KmImissiveSendTemplate','fdCategoryId','fdCategoryName',null,null,null,null,closeWindows, true);
									}
								</script>
							</c:if>						
						</td>
						<!-- 排序号 -->
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-imissive" key="kmImissiveSendTemplate.fdOrder" /></td>
	
						<td width=35% >
							<xform:text property="fdOrder" style="width:80%;" validators="digits" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveSendTemplate.fdFlowId" />
						</td>
						<td width=85% colspan="3">
							<%
								request.setAttribute("fdAllNumberFlag","1");
							    request.setAttribute("modelName","com.landray.kmss.km.imissive.model.KmImissiveSendMain");
							%>
							<xform:select property="fdFlowId" required="true" subject="${lfn:message('km-imissive:kmImissiveSendTemplate.fdFlowId')}"  htmlElementProperties="id='numberSelect'" style="width:200px">
								<xform:customizeDataSource className="com.landray.kmss.sys.number.service.spring.SysNumberMainDataSource"></xform:customizeDataSource>
							</xform:select></br>
							<font color="red">
								<bean:message bundle="km-imissive" key="kmImissiveSendTemplate.fdFlowId.tips" /></br>
								<bean:message bundle="km-imissive" key="kmImissiveSendTemplate.fdFlowId.tips1" /></br>
								<bean:message bundle="km-imissive" key="kmImissiveSendTemplate.fdFlowId.tips2" /></br>
								<bean:message bundle="km-imissive" key="kmImissiveSendTemplate.fdFlowId.tips3" />
							</font>
						</td>
					</tr>
					<tr>
					<td class="td_normal_title" width=15%>
						跨年编号
					</td>
					<td width=35%>
						<html:hidden property="fdAcrossYearNumber" /> 
						<label class="weui_switch acrossYearNumber">
							<span class="weui_switch_bd">
								<input type="checkbox" ${'true' eq kmImissiveSendTemplateForm.fdAcrossYearNumber ? 'checked' : '' } />
								<span></span>
								<small></small>
							</span>
							<span id="fdAcrossYearNumberText"></span>
						</label>
						<script type="text/javascript">
							function setYearText(status) {
								if(status) {
									$("#fdAcrossYearNumberText").text('<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdAcrossYearNumber.true" />');
								} else {
									$("#fdAcrossYearNumberText").text('<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdAcrossYearNumber.false" />');
								}
							}
							$(".acrossYearNumber :checkbox").on("click", function() {
								var status = $(this).is(':checked');
								$("input[name=fdAcrossYearNumber]").val(status);
								setYearText(status);
							});
							setYearText(${kmImissiveSendTemplateForm.fdAcrossYearNumber});
						</script>
					</td>
					<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable" />
						</td>
					<td width=35%>
						<html:hidden property="fdIsAvailable" /> 
						<label class="weui_switch available">
							<span class="weui_switch_bd">
								<input type="checkbox" ${'true' eq kmImissiveSendTemplateForm.fdIsAvailable ? 'checked' : '' } />
								<span></span>
								<small></small>
							</span>
							<span id="fdIsAvailableText"></span>
						</label>
						<script type="text/javascript">
							function setText(status) {
								if(status) {
									$("#fdIsAvailableText").text('<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable.true" />');
								} else {
									$("#fdIsAvailableText").text('<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable.false" />');
								}
							}
							$(".available :checkbox").on("click", function() {
								var status = $(this).is(':checked');
								$("input[name=fdIsAvailable]").val(status);
								setText(status);
							});
							setText(${kmImissiveSendTemplateForm.fdIsAvailable});
						</script>
					</td>
				</tr>
				<%-- 所属场所 --%>
				<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
                     <c:param name="id" value="${kmImissiveSendTemplateForm.authAreaId}"/>
                </c:import>
				<!-- 可使用者 -->
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveSendTemplate.authReaderIds" /></td>
					<td  width=85% colspan="3">
						<xform:address textarea="true" mulSelect="true" propertyId="authReaderIds" propertyName="authReaderNames" orgType="ORG_TYPE_ALL" style="width:97%;height:90px;" ></xform:address>
						<br>
						<bean:message key="kmImissiveSendTemplate.tepmlateUser" bundle="km-imissive"/>
				   </td>
				</tr>
				<!-- 可维护者 -->
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveSendTemplate.authEditorIds" /></td>
					<td width=85% colspan="3">
						<xform:address textarea="true" mulSelect="true" propertyId="authEditorIds" propertyName="authEditorNames" orgType="ORG_TYPE_ALL" style="width:97%;height:90px;" ></xform:address>
						<br>
						<bean:message key="kmImissiveSendTemplate.tepmlateManager" bundle="km-imissive"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveSendTemplate.authAppRecReaderIds" /></td>
					<td width=85% colspan="3">
						<xform:address textarea="true" mulSelect="true" propertyId="authTmpAppRecReaderIds" propertyName="authTmpAppRecReaderNames" orgType="ORG_TYPE_ALL" style="width:97%;height:90px;" ></xform:address>
						<br>
						<bean:message key="kmImissiveSendTemplate.appRecReader" bundle="km-imissive"/>
					</td>
				</tr>
				<%---新建时，不显示 创建人，创建时间 modify by zhouchao---%>
               <c:if
		         test="${kmImissiveSendTemplateForm.method_GET=='edit'}">
				<tr>
					<!-- 创建人员 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveSendTemplate.docCreatorId" /></td>
					
					<td width=35%><bean:write name="kmImissiveSendTemplateForm"
						property="docCreatorName" /></td>
					<!-- 创建时间 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveSendTemplate.docCreateTime" /></td>
					<td width=35%><bean:write name="kmImissiveSendTemplateForm"
						property="docCreateTime" /></td>
				</tr>
				<c:if test="${not empty kmImissiveSendTemplateForm.docAlterorName}">
				<tr>
					<!-- 修改人 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveSendTemplate.docAlterorId" /></td>
					<td width=35%><bean:write name="kmImissiveSendTemplateForm"
						property="docAlterorName" /></td>
					<!-- 修改时间 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveSendTemplate.docAlterTime" /></td>
					<td width=35%><bean:write name="kmImissiveSendTemplateForm"
						property="docAlterTime" /></td>
				</tr>
				</c:if>
				</c:if>
			</table>
			</td>
	</tr>
	<!--表单 -->
	<c:import url="/sys/xform/include/sysFormTemplate_edit.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSendTemplateForm" />
		<c:param name="fdKey" value="sendMainDoc" />
		<c:param name="fdMainModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
		<c:param name="messageKey" value="km-imissive:kmImissiveSendTemplate.baseinfo" />
	</c:import>
	<tr id="tr_content" LKS_LabelName="<bean:message bundle="km-imissive" key="kmImissiveSendTemplate.docContent" />">
		<td id="td_content">
			<table id="base_info" class="tb_normal" width=100%>
				<%-- 编辑方式 --%>
				<html:hidden property="fdNeedContent" />
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message key="kmImissiveReceiveTemplate.fdNeedContent" bundle="km-imissive" />
					</td>
					<td width="85%">
						<xform:radio property="fdEditType" showStatus="edit" value="${kmImissiveSendTemplateForm.fdNeedContent}" onValueChange="checkEditType">
							<xform:enumsDataSource enumsType="kmImissiveReceiveTemplate_fdNeedContent" />
						</xform:radio>
					</td>
				</tr>
				<tr>
					<td  colspan="2">
						<c:choose>
							<c:when test="${wpsoaassist eq 'true'}">
								<div id="wpsImissive">
									<c:choose>
										<c:when test="${'true' eq xinChuangWps}">
											<jsp:include page="/km/imissive/wps/oaassist/sysAttMain_edit.jsp">
												<jsp:param name="fdKey" value="editonline"/>
												<jsp:param name="fdModelId" value="${kmImissiveSendTemplateForm.fdId}"/>
												<jsp:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate"/>
												<jsp:param name="formBeanName" value="kmImissiveSendTemplateForm"/>
												<jsp:param name="fdTemplateKey" value="editonline" />
												<jsp:param name="load" value="false"/>
												<jsp:param name="newFlag" value="true"/>
											</jsp:include>
										</c:when>
										<c:otherwise>
											<div id="missiveButtonDiv" style="text-align:right">
												<a href="javascript:void(0);" class="attbook" onclick="openBookmarkHelp();">
													<bean:message key="kmImissive.bookMarks.title" bundle="km-imissive"/>
												</a>
											</div>
											<div<c:if test="${empty kmImissiveSendTemplateForm.attachmentForms['editonline'].attachments}">style="display:none"</c:if>>
											<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
												<c:param name="fdKey" value="editonline" />
												<c:param name="fdModelId" value="${kmImissiveSendTemplateForm.fdId }" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
												<c:param name="uploadAfterSelect" value="true" />
												<c:param name="fdMulti" value="false" />
												<c:param  name="fdViewType"  value="imissive"/>
												<c:param name="wpsExtAppModel" value="kmImissive" />
												<c:param name="newFlag" value="true" />
											</c:import>
											</div>
											<div <c:if test="${not empty kmImissiveSendTemplateForm.attachmentForms['editonline'].attachments}">style="display:none"</c:if> >
												<c:import url="/km/imissive/wps/sysAttMain_edit.jsp" charEncoding="UTF-8">
													<c:param name="fdKey" value="editonline" />
													<c:param name="fdModelId" value="${kmImissiveSendTemplateForm.fdId}" />
													<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
													<c:param name="formBeanName" value="kmImissiveSendTemplateForm" />
													<c:param name="fdTemplateKey" value="editonline" />
													<c:param name="buttonDiv" value="missiveButtonDiv" />
													<c:param name="wpsExtAppModel" value="kmImissive" />
													<c:param name="newFlag" value="true" />
												</c:import>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</c:when>
							<c:when test="${_isWpsCloudEnable}">
						    	<div id="wordEdit">
									<div id="missiveButtonDiv" style="text-align:right">
								   		&nbsp;
									   	<a href="javascript:void(0);" class="attbook" onclick="openBookmarkHelp();">
								       		<bean:message key="kmImissive.bookMarks.title" bundle="km-imissive"/>
								       	</a>
									</div>
									<div>
										<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_edit.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="editonline" />
											<c:param name="load" value="false" />
											<c:param name="bindSubmit" value="false"/>	
											<c:param name="fdModelId" value="${kmImissiveSendTemplateForm.fdId}" />
											<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
											<c:param name="formBeanName" value="kmImissiveSendTemplateForm" />
											<c:param name="fdTemplateKey" value="editonline" />
											<c:param name="buttonDiv" value="missiveButtonDiv" />
											<c:param name="isTemplate" value="true"/>
										</c:import>
							  		</div>
								</div>
							</c:when>
							<c:when test="${_isWpsCenterEnable}">
								<div id="wordEdit">
									<div id="missiveButtonDiv" style="text-align:right">
										&nbsp;
										<a href="javascript:void(0);" class="attbook" onclick="openBookmarkHelp();">
											<bean:message key="kmImissive.bookMarks.title" bundle="km-imissive"/>
										</a>
									</div>
									<div>
										<c:import url="/sys/attachment/sys_att_main/wps/center/sysAttMain_edit.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="editonline" />
											<c:param name="load" value="false" />
											<c:param name="bindSubmit" value="false"/>
											<c:param name="fdModelId" value="${kmImissiveSendTemplateForm.fdId}" />
											<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
											<c:param name="formBeanName" value="kmImissiveSendTemplateForm" />
											<c:param name="fdTemplateKey" value="editonline" />
											<c:param name="buttonDiv" value="missiveButtonDiv" />
											<c:param name="isTemplate" value="true"/>
										</c:import>
									</div>
								</div>
							</c:when>
							<c:otherwise>
			   					<%@ include file="/sys/attachment/sys_att_main/jg/sysAttMain_CheckJgSupport.jsp"%>
			     				<div id="wordEdit" style="height: 1px;width: 1px;overflow:hidden;">
			       					<c:if test="${supportJg eq 'supported'}">
										<div id="missiveButtonDiv" style="text-align:right">
					   						&nbsp;
					   						<a href="javascript:void(0);" class="attbook" onclick="openBookmarkHelp();"> 
				       							<bean:message key="kmImissive.bookMarks.title" bundle="km-imissive"/>
				       						</a>
										</div>
									</c:if>
									<div>
										<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_edit.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="editonline" />
											<c:param name="load" value="false" />
											<c:param name="fdAttType" value="office"/>
											<c:param name="fdModelId" value="${kmImissiveSendTemplateForm.fdId}"/>
											<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
											<c:param name="bindSubmit" value="false"/>
											<c:param name="buttonDiv" value="missiveButtonDiv" />
											<c:param name="attHeight" value="550" />
											<c:param name="isTemplate" value="true"/>
								       </c:import>	
				  					</div>
								</div>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<!-- 以下代码为嵌入流程模板标签的代码 -->
	<c:import url="/sys/workflow/include/sysWfTemplate_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSendTemplateForm" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
			<c:param name="fdKey" value="sendMainDoc" />
	</c:import>
	<!-- 以上代码为嵌入流程模板标签的代码 -->
	<c:import url="/sys/number/include/sysNumberMappTemplate_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSendTemplateForm" />
		<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain"/>
		<c:param name="fdKey" value="sendMainDoc" />
		<c:param name="isUnlimit" value="true"/>
	</c:import>
	<tr LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
		<c:set
			var="mainModelForm"
			value="${kmImissiveSendTemplateForm}"
			scope="request" />
		<c:set
			var="currModelName"
			value="com.landray.kmss.km.imissive.model.KmImissiveSendMain"
			scope="request" />
		<td><%@ include file="/sys/relation/include/sysRelationMain_edit.jsp"%></td>
	</tr>
	<!--发布机制开始 -->
	<c:import url="/sys/news/include/sysNewsPublishCategory_edit.jsp" 
		charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSendTemplateForm" />
		<c:param name="fdKey" value="sendMainDoc" />
	</c:import>
	<!--发布机制结束-->
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/tmp_right_edit.jsp" charEncoding="UTF-8">
					<c:param
						name="formName"
						value="kmImissiveSendTemplateForm" />
					<c:param
						name="moduleModelName"
						value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
				</c:import>
			</table>
		</td>
	</tr>
	
	<%--多语言 --%>
	<%  if(LangUtil.isEnableMultiLang(request.getParameter("fdMainModelName"), "model") && LangUtil.isEnableAdminDoMultiLang()) {%>
	<c:import url="/sys/xform/lang/include/sysFormMultiLang_edit.jsp"	charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSendTemplateForm" />
			<c:param name="fdKey" value="sendMainDoc" />
	</c:import>
	<% } %>
	
	<!-- 打印机制 -->
	<c:import url="/sys/print/include/sysPrintTemplate_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSendTemplateForm" />
		<c:param name="fdKey" value="sendMainDoc" />
		<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain"></c:param>
		<c:param name="templateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate"></c:param>
	</c:import>
	<!-- 归档设置 -->
	<c:import url="/sys/archives/include/sysArchivesFileSetting_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSendTemplateForm" />
		<c:param name="fdKey" value="sendMainDoc" />
		<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
		<c:param name="templateService" value="kmImissiveSendTemplateService" />
		<c:param name="moduleUrl" value="km/imissive" />
	</c:import>
	<!-- 沉淀设置 -->
	<c:import url="/kms/multidoc/kms_multidoc_subside/include/kmsSubsideFileSetting_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSendTemplateForm" />
		<c:param name="fdKey" value="sendMainDoc" />
		<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
		<c:param name="templateService" value="kmImissiveSendTemplateService" />
	</c:import>
	<!-- 规则机制 -->
	<c:import url="/sys/rule/sys_ruleset_temp/sysRuleTemplate_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSendTemplateForm" />
		<c:param name="fdKey" value="sendMainDoc" />
		<c:param name="templateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate"></c:param>
	</c:import>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>
<html:javascript formName="kmImissiveSendTemplateForm" cdata="false"
	dynamicJavascript="true" staticJavascript="false" />
<%@ include file="/resource/jsp/edit_down.jsp"%>