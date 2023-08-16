<%@page import="com.landray.kmss.sys.webservice2.util.SysWsUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%
	String isJGSignatureHTMLEnabled = ResourceUtil.getKmssConfigString("sys.att.isJGSignatureHTMLEnabled");
	request.setAttribute("JGSignatureHTMLEnabled",isJGSignatureHTMLEnabled);
%>
<template:include ref="default.print">
	<template:replace name="head">
	<style type="text/css">
	.titleDiv{
			padding-bottom:5px;
			border-bottom: 2px;
			border-bottom-style: dotted;
			border-bottom-color: rgb(240, 20, 87);
			font-family:Microsoft YaHei, Geneva, "sans-serif", SimSun;
			font-size: 14px;
			font-weight: bold
		}
		@media print {
			#toolBarDiv{
				display: none;
			}
		}
		.lui_upload_img_box .upload_opt_td,.lui_upload_img_box .upload_list_operation,.lui_upload_img_box .upload_list_download_count{display:none;}
	</style>
	</template:replace>
	<template:replace name="title">
		<c:out value="${ kmImissiveSendMainForm.docSubject } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out> 
	</template:replace>
	<template:replace name="toolbar">
<%
	if(request.getHeader("User-Agent").toUpperCase().indexOf("MSIE")>-1){
		request.setAttribute("isIE",true);
	}else if(request.getHeader("User-Agent").toUpperCase().indexOf("TRIDENT")>-1){
		request.setAttribute("isIE",true);
	}else{
		request.setAttribute("isIE",false);
	}
%>
<script>
	Com_IncludeFile("jquery.js|dialog.js|doclist.js");
	Com_IncludeFile("previewdesign.js",Com_Parameter.ContextPath+"sys/print/import/","js",true);
	Com_IncludeFile("print.js",Com_Parameter.ContextPath+"km/review/resource/js/","js",true);
</script>
<script>
Com_AddEventListener(window, "load", function() {
	ClearDomWidth(document.getElementById("info_content"));
	expandXformTab();
	//清除链接样式
	$('#_xform_detail a').css('text-decoration','none');
	$('a[id^=thirdCtripXformPlane_]').removeAttr('onclick');
	$('a[id^=thirdCtripXformHotel_]').removeAttr('onclick');
	sysPreviewDesign.resetBoxWidth($('.sysDefineXform')[0]);
	resetTableSize();
});
function ClearDomWidth(dom) {
	if (dom != null && dom.nodeType == 1 && dom.tagName != 'OBJECT' && dom.tagName != 'SCRIPT' && dom.tagName != 'STYLE' && dom.tagName != 'HTML') {
		//修改打印布局为 百分比布局 #曹映辉 2014.8.7
		/****
		 var w = dom.getAttribute("width");
		 if (w != '100%')
		 dom.removeAttribute("width");
		 w = dom.style.width;
		 if (w != '100%')
		 dom.style.removeAttribute("width");
		 ****/
		if (dom.style.whiteSpace == 'nowrap') {
			dom.style.whiteSpace = 'normal';
		}
		if (dom.style.display == 'inline') {
			dom.style.wordBreak  = 'break-all';
			dom.style.wordWrap  = 'break-word';
		}
		ClearDomsWidth(dom);
	}
}
function expandXformTab(){
	var xformArea = $("#_xform_detail");
	if(xformArea.length>0){
		var tabs = $("#_xform_detail table.tb_label");
		if(tabs.length>0){
			for(var i=0; i<tabs.length; i++){
				var id = $(tabs[i]).prop("id");
				if(id==null || id=='') continue;
				$(tabs[i]).toggleClass("tb_normal");
				var tmpFun = function(idx,trObj){
					var trObj = $(trObj);
					//trObj.children("td").css({"padding":"0px","margin":"0px"});
					var tmpTitleTr = $("<tr class='tr_normal_title'>");
					var tempTd = $('<td align="left">');
					tempTd.html(trObj.attr("LKS_LabelName"));
					tempTd.appendTo(tmpTitleTr);
					trObj.before(tmpTitleTr);
				};
				var trArr = $("#"+id+" >tbody > tr[LKS_LabelName]");
				if(trArr.length<1){
					trArr = $("#"+id+" > tr[LKS_LabelName]");
				}
				trArr.each(tmpFun).show();
				tabs[i].deleteRow(0);
			}
		}
	}
}
function resetTableSize(){
	var tables = $(".sysDefineXform table[fd_type='standardTable']");
	for(var i = 0 ;i < tables.length;i++){
		var table = tables[i];
		//表格宽度调整
		$(table).css('width','100%');
		var tbWidth = $(table).width();
		//计算原始宽度
		for (var j = 0; j < table.rows.length; j++) {
			var cells = table.rows[j].cells;
			var cellsCount = cells.length;
			for(var k = 0;k < cellsCount;k++){
				var w = $(cells[k]).width();
				$(cells[k]).attr('cfg-width',w * 980/tbWidth);
			}
		}
		//重置宽度
		for (var j = 0; j < table.rows.length; j++) {
			var cells = table.rows[j].cells;
			var cellsCount = cells.length;
			for(var k = 0;k < cellsCount;k++){
				$(cells[k]).css('width',$(cells[k]).attr('cfg-width'));
			}
		}
	}
}

function changeValue(obj){
	if(obj.checked){
      $("#"+obj.id+"Div").show();
	}else{
		$("#"+obj.id+"Div").hide();
	}
}
seajs.use(['lui/jquery'], function($) {
	$(document).ready(function(){
		//$("#attDiv").hide();
		$("#wflogDiv").hide();
		$("#relationDiv").hide();
		if($("#circulationDiv")){
		  $("#circulationDiv").hide();
		}
		if($("#disandrepDiv")){
		  $("#disandrepDiv").hide();
		}
		$("#readlogDiv").hide();
		if($("#publiclogDiv")){
		  $("#publiclogDiv").hide();
		}
		//ZoomFontSize(3);
	});
});

function ZoomFontSize(size) {
	var root = document.getElementById("printTable");
	var i = 0;
	for (i = 0; i < root.childNodes.length; i++) {
		SetZoomFontSize(root.childNodes[i], size);
	}
	var tag_fontsize;
	if(root.currentStyle){
	    tag_fontsize = root.currentStyle.fontSize;  
	}  
	else{  
	    tag_fontsize = getComputedStyle(root, null).fontSize;  
	} 
	root.style.fontSize = parseInt(tag_fontsize) + size + 'px';
}
function SetZoomFontSize(dom, size) {
	if (dom.nodeType == 1 && dom.tagName != 'OBJECT' && dom.tagName != 'SCRIPT' && dom.tagName != 'STYLE' && dom.tagName != 'HTML') {
		for (var i = 0; i < dom.childNodes.length; i ++) {
			if(dom.childNodes[i].tagName=='IFRAME'){
				SetZoomFontSize(dom.childNodes[i].contentDocument.body, size);
			}else{
			   SetZoomFontSize(dom.childNodes[i], size);
			}
		}
		var tag_fontsize;
		if(dom.currentStyle){  
		    tag_fontsize = dom.currentStyle.fontSize;  
		}  
		else{  
		    tag_fontsize = getComputedStyle(dom, null).fontSize;  
		} 
		dom.style.fontSize = parseInt(tag_fontsize) + size + 'px';
	}
}

<c:if test="${JGSignatureHTMLEnabled == 'true'}">
window.onload=function(){
	kmImissiveSendMainForm.SignatureControl.ShowSignature('${param.fdId}');
};
window.onunload=function(){
	kmImissiveSendMainForm.SignatureControl.DeleteSignature();
};
</c:if>
</script>
	<ui:toolbar  id="toolbar" layout="sys.ui.toolbar.float" count="6">
	    <ui:button text="${ lfn:message('button.print') }"   onclick="window.print();">
	    </ui:button>
		<ui:button text="${ lfn:message('km-imissive:button.zoom.in') }" order="5" onclick="ZoomFontSize(3);">
		</ui:button>
		<ui:button text="${ lfn:message('km-imissive:button.zoom.out') }" order="5" onclick="ZoomFontSize(-3);">
		</ui:button>
	    <c:import url="/sys/print/import/switchNewButton.jsp" charEncoding="UTF-8"></c:import>
		<c:import url="/sys/common/exportButton.jsp" charEncoding="UTF-8"></c:import>
		<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
		</ui:button>	
	</ui:toolbar>
</template:replace>
<template:replace name="content">
<html:form action="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do">
<%-- 网页签章(首先判断是否启用了网页签章) --%>
<c:if test="${JGSignatureHTMLEnabled == 'true'}">
	<%
		String projectServerURL = SysWsUtil.getUrlPrefix(request);
		String mServerUrl=projectServerURL+"/km/imissive/iSignatureHTML/Service.jsp";
	  	request.setAttribute("jgHtmlSigVersion",JgWebOffice.getJGVersion("signaturehtml"));
	  	request.setAttribute("jgHtmlSigUrl",projectServerURL + JgWebOffice.getJGDownLoadUrl("signaturehtml"));
	%>
   	<span id="processNodeId" style="display: none;"><kmss:showWfPropertyValues idValue="${kmImissiveSendMainForm.fdId}" propertyName="handerNameDetail" /></span>
   	<input type="hidden" name="DOCUMENTID" value="${kmImissiveSendMainForm.fdId }">
   	<OBJECT id="SignatureControl"   classid="clsid:D85C89BE-263C-472D-9B6B-5264CD85B36E"  codebase="${jgHtmlSigUrl }#version=${jgHtmlSigVersion }" width=0 height=0>
		<param name="ServiceUrl" value="<%=mServerUrl%>"><!--读去数据库相关信息-->
		<param name="PrintControlType" value=2>               <!--打印控制方式（0:不控制  1：签章服务器控制  2：开发商控制）-->
	</OBJECT>	
</c:if>    	
<center>
<div id="toolBarDiv" style="padding-top: 12px;max-width:1000px;" data-remove="false">
	 <table class="tb_normal" width=98%>
		<tr>
			<%--
			<td>
				<label>
				<input  id="att" type="checkbox" onclick="changeValue(this);"/>
				 <bean:message bundle="km-imissive" key="kmImissive.print.attachment"/>
				</label>
			</td>
			 --%>
			<kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=readViewLog&fdId=${param.fdId}" requestMethod="GET">
			<td>
				<label>
				<input id="wflog" type="checkbox" onclick="changeValue(this);"/>
				<bean:message bundle="km-imissive" key="kmImissive.print.review"/>
				</label>
			</td>
			</kmss:auth>
			<td>
				<label>
				<input id="relation" type="checkbox" onclick="changeValue(this);"/>
				<bean:message bundle="km-imissive" key="kmImissive.print.relation"/>
				</label>
			</td>
			<c:if test="${kmImissiveSendMainForm.docStatus eq '30'}">
				<td>
					<label>
					<input id="circulation" type="checkbox" onclick="changeValue(this);"/>
					<bean:message bundle="km-imissive" key="kmImissive.print.circulation"/>
					</label>
				</td>
			</c:if>
			<c:if test="${kmImissiveSendMainForm.docStatus eq '30'}">
				<td>
					<label>
					<input id="disandrep" type="checkbox" onclick="changeValue(this);"/>
					<bean:message bundle="km-imissive" key="kmImissive.print.distributeAndReport"/>
					</label>
				</td>
			</c:if>
				<td>
					<label>
					<input id="readlog" type="checkbox" onclick="changeValue(this);"/>
					<bean:message bundle="km-imissive" key="kmImissive.print.read"/>
					</label>
				</td>
			<c:if test="${kmImissiveSendMainForm.docStatus eq '30'}">
			<td>
				<label>
				<input id="publiclog" type="checkbox" onclick="changeValue(this);"/>
				 <bean:message bundle="km-imissive" key="kmImissive.print.publish"/>
				</label>
			</td>
			</c:if>
		</tr>
	</table>
</div>
</center>
<div id="printTable" class="tb_normal" style="border: none;font-size: 12px;max-width:1000px;">
 <div class="lui_form_content_frame" style="padding-top:10px">
	    <table width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
				 <c:import url="/sys/xform/include/sysForm_view.jsp"	charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
					<c:param name="fdKey" value="sendMainDoc" />
					<c:param name="messageKey" value="km-imissive:kmImissiveSendMain.baseinfo"/>
					<c:param name="useTab" value="false"/>
				</c:import>
				</td>
			</tr>
		</table>
		</div>
	<c:if test="${not empty kmImissiveSendMainForm.attachmentForms['attachment'].attachments}">
		<c:set var="existAtt" value="true" scope="request"/>
	</c:if>
	<c:if test="${empty loadAtt and 'true' eq existAtt}">
		<div class="lui_form_content_frame" style="padding-top:10px" id="attDiv">
		<div class="titleDiv"><img src="${KMSS_Parameter_ContextPath}third/pda/resource/images/attachment.png"><bean:message bundle="km-imissive" key="kmImissive.print.attachment.record"/></div>
	    <table  width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
				<c:choose>
				  <c:when test="${not empty kmImissiveSendMainForm.attachmentForms['attachment'].attachments}">
					   <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param
								name="fdKey"
								value="attachment" />
							<c:param
								name="formBeanName"
								value="kmImissiveSendMainForm" />
						</c:import>
				  </c:when>
				  <c:otherwise>
				        <%@ include file="/resource/jsp/list_norecord_simple.jsp"%>
				  </c:otherwise>
				</c:choose>
				</td>
			</tr>
		</table>
		</div>
	</c:if>
		<kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=readViewLog&fdId=${param.fdId}" requestMethod="GET">
		<div class="lui_form_content_frame" style="padding-top:10px" id="wflogDiv">
	    <div class="titleDiv"><bean:message bundle="km-imissive" key="kmImissive.print.review.record"/></div>
	    <table width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
				   <c:import url="/sys/workflow/include/sysWfProcess_log.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSendMainForm" />
					</c:import>
				</td>
			</tr>
		</table>
		</div>
		</kmss:auth>
		<div class="lui_form_content_frame" style="padding-top:10px" id="relationDiv">
	    <div class="titleDiv"><bean:message bundle="km-imissive" key="kmImissive.print.relation.record"/></div>
	    <table width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
					<%--<list:listview>
						<ui:source type="AjaxJson">
							{"url":"/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=list&fdMainId=${kmImissiveSendMainForm.fdId}&rowsize=100"}
						</ui:source>
						<list:colTable isDefault="true" layout="sys.ui.listview.listtable" cfg-norecodeLayout="simple">
							<list:col-auto props=""></list:col-auto>
						</list:colTable>
					</list:listview>--%>

					<c:import url="/km/imissive/import/kmImissiveReceiveMainRelation_viewPrint.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSendMainForm" />
					</c:import>
				</td>
			</tr>
		</table>
		</div>
		<c:if test="${kmImissiveSendMainForm.docStatus eq '30'}">
		<div class="lui_form_content_frame" style="padding-top:10px" id="circulationDiv">
		<div class="titleDiv"><bean:message bundle="km-imissive" key="kmImissive.print.circulation.record"/></div>
	    <table width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
					 <c:import
						url="/km/imissive/import/sysCirculationMain_viewPrint2.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSendMainForm" />
					</c:import>
				</td>
			</tr>
		</table>
		</div>
		<div class="lui_form_content_frame" style="padding-top:10px" id="disandrepDiv">
		<div class="titleDiv"><bean:message bundle="km-imissive" key="kmImissive.print.distributeAndReport.record"/></div>
	     <table width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
				 <div>
					 <b><bean:message bundle="km-imissive" key="kmImissive.print.distribute.record"/>：
					 </b>
				 </div>
				<%--<list:listview>
					<ui:source type="AjaxJson">
						{"url":"/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&deliver=true&fdMainId=${kmImissiveSendMainForm.fdId}&type=1&rowsize=100"}
					</ui:source>
					<list:colTable  isDefault="true" layout="sys.ui.listview.listtable" cfg-norecodeLayout="simple">
						<list:col-auto props="kmImissiveRegDetailList.fdReg.fdName;kmImissiveRegDetailList.fdReg.fdDeliverType;fdUnit.fdName;docCreateTime;fdOrgNames;fdStatus;nodeName;handlerName"></list:col-auto>
					</list:colTable>						
				</list:listview>--%>
					<c:import
							url="/km/imissive/import/kmImissiveRegDetailListDistribute_viewPrint.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSendMainForm" />
					</c:import>
				</td>
			</tr>
			<tr>
				<td colspan="4">
				<div>
					 <b><bean:message bundle="km-imissive" key="kmImissive.print.Report.record"/>：
					 </b>
				</div>
				<%--<list:listview>
					<ui:source type="AjaxJson">
						{"url":"/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&deliver=true&fdMainId=${kmImissiveSendMainForm.fdId}&type=2&rowsize=100"}
					</ui:source>
					<list:colTable isDefault="true" layout="sys.ui.listview.listtable" cfg-norecodeLayout="simple">
						<list:col-auto props="kmImissiveRegDetailList.fdReg.fdName;kmImissiveRegDetailList.fdReg.fdDeliverType;fdUnit.fdName;docCreateTime;fdOrgNames;fdStatus;nodeName;handlerName"></list:col-auto>
					</list:colTable>	
				</list:listview>--%>
					<c:import
							url="/km/imissive/import/kmImissiveRegDetailListReport_viewPrint.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSendMainForm" />
					</c:import>
				</td>
			</tr>
		 </table>
		 </div>
		 </c:if>
		 <div class="lui_form_content_frame" style="padding-top:10px" id="readlogDiv">
		 <div class="titleDiv"><bean:message bundle="km-imissive" key="kmImissive.print.read.record"/></div>
	     <table width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
				 <c:import url="/km/imissive/import/sysReadLog_viewPrint2.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
			      </c:import>
				</td>
			</tr>
		 </table>
		 </div>
		 <c:if test="${kmImissiveSendMainForm.docStatus eq '30'}">
		 <div class="lui_form_content_frame" style="padding-top:10px" id="publiclogDiv">
		 <div class="titleDiv"><bean:message bundle="km-imissive" key="kmImissive.print.publish.record"/></div>
	     <table width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
				<c:import url="/km/imissive/import/sysNewsPublishMain_viewPrint2.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
					<c:param name="fdKey" value="sendMainDoc" />
			    </c:import>
				</td>
			</tr>
		 </table>
		 </div>
	</c:if>
</div>
</html:form>
<script>

function outputPDF() {
	seajs.use(['lui/jquery','lui/export/export'],function($,exp) {
		$("#toolBarDiv").hide();
		exp.exportPdf(document.getElementById('printTable'),{title:'${ kmImissiveSendMainForm.docSubject }',callback:function() {
			$("#toolBarDiv").css("display", "");
			setTimeout(function() {
				$("#printTable").unwrap();
			}, 500);
		}});
	});
}

function outputMHT() {
	seajs.use(['lui/export/export'],function(exp) {
		exp.exportMht({
			title:'${ kmImissiveSendMainForm.docSubject }'
		});
	});
}
</script>
</template:replace>
</template:include>
