<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@page import="java.util.Date"%>
<template:include ref="default.print" sidebar="no">
<template:replace name="head">
<style type="text/css">
	.titleDiv{
			padding-bottom:5px;
			border-bottom: 2px;
			border-bottom-style: dotted;
			border-bottom-color: rgb(240, 20, 87);
			font-family:Microsoft YaHei, Geneva, "sans-serif", SimSun;
			font-size: 14px;
			font-weight: bold;
			text-align:left;
		}
		@media print {
			#toolBarDiv{
				display: none;
			}
		}
	</style>
</template:replace>
<template:replace name="title">
	${ lfn:message('km-imissive:kmImissive.batch.title') }
</template:replace>
<template:replace name="toolbar">
	<ui:toolbar  id="toolbar" layout="sys.ui.toolbar.float" count="9"> 
			<ui:button  id="zoomIn" text="${ lfn:message('km-imissive:button.zoom.in') }"   onclick="ZoomFontSize(2);">
		    </ui:button>
		     <ui:button id="zoomOut" text="${ lfn:message('km-imissive:button.zoom.out') }"   onclick="ZoomFontSize(-2);">
	 	   	</ui:button>
	 	   	 <ui:button text="${ lfn:message('km-imissive:button.pageBreak') }"  onclick="ShowToPageBreak(event);">
	  		 </ui:button>
	  		 <ui:button text="${ lfn:message('button.print') }"   onclick="printorder();">
		    </ui:button>
		     <ui:button style="display:none;"  text="${ lfn:message('km-imissive:button.printPreview') }"   onclick="printView();">
		    </ui:button>
		    <%--
		     <ui:button text="${ lfn:message('km-imissive:button.printConfig') }"   onclick="ShowPrintList();">
		    </ui:button>
		    <c:if test="${isShowSwitchBtn=='true'}">
		      <ui:button text="${ lfn:message('km-imissive:button.print.new') }"   onclick="switchPrintPage();">
		   	 </ui:button>
		    </c:if>
		     --%>
		    <c:import url="/sys/common/exportButton.jsp" charEncoding="UTF-8"></c:import>
		      <ui:button text="${ lfn:message('button.close') }"   onclick="window.close();">
		    </ui:button>
	</ui:toolbar>
</template:replace>
<template:replace name="content">
<script language="JavaScript">
seajs.use(['theme!form']);
function outputPDF() {
	seajs.use(['lui/jquery','lui/export/export'],function($,exp) {
		$(".qrcodeArea").hide();
		exp.exportPdf($("#print_content")[0],{callback:function() {
			$(".qrcodeArea").show();
		}});
	});
}
</script>
<c:set var="p_defconfig" value="${p_defconfig}" scope="request"/>
<%
String base = (String)request.getAttribute("base");
String info = (String)request.getAttribute("info");
String note = (String)request.getAttribute("note");
String qrcode = (String)request.getAttribute("qrcode");
String p_config=request.getParameter("p_config");
java.util.ArrayList showConfig = new java.util.ArrayList(4);
if (p_config == null || p_config.length() == 0 ) {
	if(!"0".equals(base))
		showConfig.add("base");
	if(!"0".equals(info))
		showConfig.add("info");
	if(!"0".equals(note))
		showConfig.add("note");
} else {
	String[] configs = p_config.split(";");
	for (int i = 0; i < configs.length; i ++) {
		String cfg = configs[i];
		if (cfg != null && cfg.length() != 0 ) {
			showConfig.add(cfg);
		}
	}
}
String defValue = "";
for (int i = 0; i < showConfig.size(); i ++) {
	defValue += ",'" + showConfig.get(i) + "'";
}
defValue = defValue.substring(1);
%>
<script>
Com_IncludeFile("jquery.js|dialog.js|doclist.js");
Com_IncludeFile("previewdesign.js",Com_Parameter.ContextPath+"sys/print/import/","js",true);
Com_IncludeFile("print.js",Com_Parameter.ContextPath+"km/review/resource/js/","js",true);
</script>
<script>
var defValue = [<%=defValue%>];
var defOptions = [{id:'base', name:'<bean:message bundle="km-imissive" key="kmImissiveDocumentLableName.baseInfo" />'}, 
                  {id:'info', name:'<bean:message bundle="km-imissive" key="kmImissiveDocumentLableName.reviewContent" />'}, 
                  {id:'note', name:'<bean:message bundle="km-imissive" key="kmImissiveMain.flow.trail" />'}];

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

function ShowPrintList() {
	var optionData = new KMSSData();
	optionData.AddHashMapArray(defOptions);
	var valueData = new KMSSData();
	for (var i = 0; i < defValue.length; i ++) {
		var defV = defValue[i];
		for (var j = 0; j < defOptions.length; j ++) {
			var opt = defOptions[j];
			if (opt.id == defV) {
				valueData.AddHashMap(opt);
			}
		}
	}
	
	var dialog = new KMSSDialog(true, true);
	dialog.AddDefaultOption(optionData);
	dialog.AddDefaultValue(valueData);
	dialog.SetAfterShow(function(rtn) {
		if (rtn == null || rtn.IsEmpty()) {
			return ;
		}
		var value = '';
		var values = rtn.GetHashMapArray();
		
		for (var i = 0; i < values.length; i ++) {
			value += ';' + values[i].id;
		}
		var url = Com_SetUrlParameter(window.location.href, 'p_config', value);
		setTimeout(function(){window.location.href = url;},500);
	});
	dialog.Show();
}
var toPageBreak = false;
function ShowToPageBreak(event) {
	event.cancelBubble = true;
	toPageBreak = true;
	document.body.style.cursor = 'pointer';
}

function AbsPosition(node, stopNode) {
	var x = y = 0;
	for (var pNode = node; pNode != null && pNode !== stopNode; pNode = pNode.offsetParent) {
		x += pNode.offsetLeft - pNode.scrollLeft; y += pNode.offsetTop - pNode.scrollTop;
	}
	x = x + document.body.scrollLeft;
	y = y + document.body.scrollTop;
	return {'x':x, 'y':y};
};
function MousePosition(event) {
	if(event.pageX || event.pageY) return {x:event.pageX, y:event.pageY};
	return {
		x:event.clientX + document.body.scrollLeft - document.body.clientLeft,
		y:event.clientY + document.body.scrollTop  - document.body.clientTop
	};
};
function SetPageBreakLine(tr) {
	var pos = AbsPosition(tr);
	var line = document.createElement('div');
	line.className = 'page_line';
	line.style.top = pos.y + 'px';
	line.style.left = '0px';
	line.id = 'line_' + tr.uniqueID;
	document.body.appendChild(line);
}
function RemovePageBreakLine(tr) {
	var line = document.getElementById('line_' + tr.uniqueID);
	if (line != null)
		document.body.removeChild(line);
	line = null;
}

function createPageBreakLine(){
	var printHeaders = $("div.print_title_header");
	if(printHeaders.length > 1){
		printHeaders.each(function(index,element){
			if(index > 0){
				SetPageBreakLine(element);
				$(element).addClass('new_page');
			}
		});
	}
}

Com_AddEventListener(document, "click", function(event) {
	if (toPageBreak) {
		event = event || window.event;
		toPageBreak = false;
		document.body.style.cursor = 'default';
		var target = event.target || event.srcElement;
		while(target) {
			if (target.tagName != null && (target.tagName == 'TR' ||target.tagName=="DIV")) {
				if (target.printTr == 'true') {
					var pos = MousePosition(event);
					var tables = target.getElementsByTagName('table');
					var mtable = null, msize = 0, m = 0;
					for (var n = 0; n < tables.length; n ++) {
						var tb = tables[n];
						var tbp = AbsPosition(tb);
						if (mtable == null) {
							mtable = tb;
							msize = Math.abs(pos.y - tbp.y);
							continue;
						}
						m = Math.abs(pos.y - tbp.y);
						if (m < msize) {
							msize = m;
							mtable = tb;
						}
					}
					if (mtable == null)
						break;
					target = mtable.rows[0];
				}
				if (target.tagName=='TR' && target.rowIndex == 0) {
					target = target.parentNode.parentNode;
				}
				if (target.className.indexOf('new_page') > -1) {
					RemovePageBreakLine(target);
					target.className = target.className.replace(/new_page/g, '');
				} else if(target.className.indexOf("page_line")==-1) {
					SetPageBreakLine(target);
					target.className = 'new_page ' + target.className;
				}
				break;
			} else {
				target = target.parentNode;
			}
		}
	}
});
var flag = 0;
function ZoomFontSize(size) {
	// 先移除分页线
	$("div.page_line").remove();
	
	//当字体缩小到一定程度时，缩小字体按钮变灰不可点击
	if(flag>=0||flag==-2){
		flag = flag+size;
	}
	if(flag<0){
		$("#zoomOut").prop("disabled",true);
		$("#zoomOut").addClass("status_disabled");
	}else{
		$("#zoomOut").prop("disabled",false);
		$("#zoomOut").removeClass("status_disabled");
	} 
	
	$(".printTableCtrl").each(function(index,element){
		var root = element;
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
	});
	
	// 重新绘制分页线
	createPageBreakLine();
}
function SetZoomFontSize(dom, size) {
	if (dom.nodeType == 1 && dom.tagName != 'OBJECT' && dom.tagName != 'SCRIPT' && dom.tagName != 'STYLE' && dom.tagName != 'HTML') {
		for (var i = 0; i < dom.childNodes.length; i ++) {
			SetZoomFontSize(dom.childNodes[i], size);
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
function ClearDomsWidth(root) {
	for (var i = 0; i < root.childNodes.length; i ++) {
		ClearDomWidth(root.childNodes[i]);
	}
}
function printView() {
	try {
		//PageSetup_temp();
		//PageSetup_Null();
		document.getElementById('WebBrowser').ExecWB(7,1);
	    //PageSetup_Default();
	} catch (e) {
		alert("<bean:message key="button.printPreview.error" bundle="km-imissive"/>");
	}
}
function expandXformTab(){
	var xformArea = $("td[name='_xform_detail']");
	if(xformArea.length>0){
		var tabs = $("td[name='_xform_detail'] table.tb_label");
		if(tabs.length>0){
			for(var i=0; i<tabs.length; i++){
				var id = $(tabs[i]).prop("id");
				if(id==null || id=='') continue;
				$(tabs[i]).toggleClass("tb_normal");
				tabs[i].deleteRow(0);
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
			}
		}
	}
}
Com_AddEventListener(window, "load", function() {
	$("table[name='info_content']").each(function(index,element){
		ClearDomWidth(element);
	});
	expandXformTab();
	//清除链接样式
	$("td[name='_xform_detail'] a").css('text-decoration','none');
	$('a[id^=thirdCtripXformPlane_]').removeAttr('onclick');
	$('a[id^=thirdCtripXformHotel_]').removeAttr('onclick');
	//添加分页符
	doPageBreakLineLayout();
});

function doPageBreakLineLayout(){
	//等工具栏加载完成后再绘制分页线
	var marginTop = $(".lui_print_body").css("margin-top");
	if (marginTop != "0px") {
		setTimeout('createPageBreakLine()',1500); 
		return;
	}
	setTimeout(function() {
		doPageBreakLineLayout();
	}, 20);
}
</script>
<SCRIPT language=javascript>  
var HKEY_Root,HKEY_Path,HKEY_Key;   
HKEY_Root="HKEY_CURRENT_USER";   
HKEY_Path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";   
var head,foot,top,bottom,left,right;  
  
//取得页面打印设置的原参数数据  
function PageSetup_temp() {    
  var Wsh=new ActiveXObject("WScript.Shell");   
  HKEY_Key="header";   
//取得页眉默认值  
  head = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
  HKEY_Key="footer";   
//取得页脚默认值
  foot = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
  HKEY_Key="margin_bottom";   
//取得下页边距  
  bottom = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
  HKEY_Key="margin_left";   
//取得左页边距  
  left = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
  HKEY_Key="margin_right";   
//取得右页边距  
  right = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
  HKEY_Key="margin_top";   
//取得上页边距  
  top = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
  
}  
  
//设置网页打印的页眉页脚和页边距  
function PageSetup_Null()   
{     
  var Wsh=new ActiveXObject("WScript.Shell");   
  HKEY_Key="header";   
//设置页眉（为空）  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"");   
  HKEY_Key="footer";   
//设置页脚（为空）  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"");   
  HKEY_Key="margin_bottom";   
//设置下页边距（0）  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0");   
  HKEY_Key="margin_left";   
//设置左页边距（0）  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0");   
  HKEY_Key="margin_right";   
//设置右页边距（0）  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0");   
  HKEY_Key="margin_top";   
//设置上页边距（8）  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0");   

}   
//设置网页打印的页眉页脚和页边距为默认值   
function  PageSetup_Default()   
{     

  var Wsh=new ActiveXObject("WScript.Shell");   
  HKEY_Key="header";   
  HKEY_Key="header";   
//还原页眉  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,head);   
  HKEY_Key="footer";   
//还原页脚  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,foot);   
  HKEY_Key="margin_bottom";   
//还原下页边距  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,bottom);   
  HKEY_Key="margin_left";   
//还原左页边距  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,left);   
  HKEY_Key="margin_right";   
//还原右页边距  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,right);   
  HKEY_Key="margin_top";   
//还原上页边距  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,top);    
}  
  
function printorder()  
{  
	try {
        //PageSetup_temp();//取得默认值  
        //PageSetup_Null();//设置页面  
        //WebBrowser.execwb(6,6);//打印页面  
        window.print();
        //PageSetup_Default();//还原页面设置  
	} catch (e) {
		alert("<bean:message key="button.printPreview.error" bundle="km-imissive"/>");
	}
        //factory.execwb(6,6);  
       // window.close();  
}  
function switchPrintPage(){
	var href = window.location.href;
	if(href.indexOf('&_ptype=') > -1){
		href = href.replace('&_ptype=old','').replace('&_ptype=new','');
	}
	if(href.indexOf('?') > -1){
		href = href+"&_ptype=new";
	}else{
		href=href+'?_ptype=new';
	}
	window.location.href=href;
}
function changeValue(obj){
	if(obj.checked){
     // $("#"+obj.id+"Div").show();
		$("div[id^="+obj.id+"Div]").show();
		$("div.page_line").remove();
		createPageBreakLine();
	}else{
		$("div[id^="+obj.id+"Div]").hide();
		$("div.page_line").remove();
		createPageBreakLine();
	//$("#"+obj.id+"Div").hide();
	}
}
seajs.use(['lui/jquery'], function($) {
	$(document).ready(function(){
		$("div[id^='attDiv']").hide();
		$("div[id^='wflogDiv']").hide();
		$("div[id^='relationDiv']").hide();
		if($("#circulationDiv_0")){
			  $("div[id^='circulationDiv']").hide();
		}
		if($("#disandrepDiv_0")){
			  $("div[id^='disandrepDiv']").hide();
		}
		//$("#readlogDiv").hide();
		$("div[id^='readlogDiv']").hide();
		if($("#publiclogDiv_0")){
		  $("div[id^='publiclogDiv']").hide();
		}
		//$("#attDiv").hide();
		//$("#wflogDiv").hide();
		//$("#relationDiv").hide();
		/* if($("#circulationDiv")){
		  $("#circulationDiv").hide();
		} */
		
		
		//ZoomFontSize(3);
	});
});
</script>
<style type="text/css">
	#title {
		font-size: 22px;
		color: #000;
	}
	.tr_label_title{
		margin: 28px 0px 10px 0px;
		border-left: 3px solid #46b1fc
	}
	
	.tr_label_title .title{
		font-weight: 900;
		font-size: 16px;
		color: #000;
		text-align:left;
		margin-left: 8px;
	}
	.page_line {
		background-color: red;
		height: 1px;
		border: none;
		width: 100%;
		position: absolute;
		overflow: hidden;
	}
	a:hover{color:#333;text-decoration: none;}
	.printTableCtrl{width:980px;margin-bottom:20px;}
	
	/*--- 打印页面带二维码的标题 ---*/
	.print_title_header{ padding-bottom: 10px;border-bottom: 1px solid #dbdbdb;}
	.print_txttitle,.print_txttitle#title{ font-size: 18px; color:#333; padding:8px 0; text-align: center;}
	.printDate{ text-align: right; color:#808080;}
	
     
@media print {
	.new_page {
		page-break-before : always;
	}
	.page_line {
		display: none;
	}
	
	.printTableCtrl .tb_noborder,
	.printTableCtrl table .tb_noborder,
	.printTableCtrl .tb_noborder td {
		border: none;
	}
	.printTableCtrl .tr_label_title {
		/*font-weight: 900;*/
	}
	.printTableCtrl{width:100%;margin-bottom:0px;}
	
	/*- 打印头部 标题 -*/
	.print_title_header{border-bottom: 1px solid #000}
	.print_txttitle,.print_txttitle#title{ font-size: 20px; font-weight: normal; color:#000;}
	.printDate{color:#000;}
}
</style>

<%-- ie10引起崩溃
	<OBJECT ID='WebBrowser' NAME="WebBrowser" WIDTH=0 HEIGHT=0 CLASSID='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2'></OBJECT>
 --%>
<form name="kmImissiveSignMainFormTemp" method="post" action="<c:url value="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do"/>">
<center>
<div id="toolBarDiv" style="padding-top: 12px;max-width:1000px;">
	 <table class="tb_normal" id="toolBarDiv" width=98%>
		<tr>
			<td>
				<label>
				<input id="wflog" type="checkbox" onclick="changeValue(this);"/>
				 <bean:message bundle="km-imissive" key="kmImissive.print.review"/>
				</label>
			</td>
				<td>
					<label>
					<input id="circulation" type="checkbox" onclick="changeValue(this);"/>
					<bean:message bundle="km-imissive" key="kmImissive.print.circulation"/>
					</label>
				</td>
			<td>
				<label>
				<input id="readlog" type="checkbox" onclick="changeValue(this);"/>
				 <bean:message bundle="km-imissive" key="kmImissive.print.read"/>
				</label>
			</td>
				<td>
					<label>
					<input id="publiclog" type="checkbox" onclick="changeValue(this);"/>
					 <bean:message bundle="km-imissive" key="kmImissive.print.publish"/>
					</label>
				</td>
		</tr>
	</table>
</div>
</center>

<center id="print_content">

<c:forEach items="${kmSignFormList }" var="kmImissiveSignMainFormTemp" varStatus="vstatus">
<kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=view&fdId=${kmImissiveSignMainFormTemp.fdId}" requestMethod="GET">
<c:set var="kmImissiveSignMainForm" value="${kmImissiveSignMainFormTemp }" scope="request" />
<div class="print_title_header">
<p id="title" class="print_txttitle"><bean:write name="kmImissiveSignMainForm" property="docSubject" /></p>
<div class="printDate">
  <bean:message bundle="km-imissive" key="kmImissive.fdPrintDate" />:<% out.print(DateUtil.convertDateToString(new Date(), DateUtil.TYPE_DATE, request.getLocale()));%>
</div>
</div>
<div class="printTableCtrl" style="border: none;">
<div printTr="true" style="border: none;">

<div>
    <div class="tr_label_title">
	    <div class="title" style="font-size: 14px;font-weight: bold">
	       <bean:message bundle="km-imissive" key="kmImissiveDocumentLableName.reviewContent" />
	    </div>
    </div>
	
	<div class="lui_form_content_frame" style="padding-top:10px">
	    <table   width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
					<%-- 表单 --%>
					<c:import url="/sys/xform/include/sysForm_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSignMainForm" />
						<c:param name="fdKey" value="signMainDoc" />
						<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId }"/>
						<c:param name="fdId" value="${kmImissiveSignMainForm.fdId }"/>
						<c:param name="messageKey" value="km-imissive:kmImissiveSendMain.baseinfo"/>
						<c:param name="useTab" value="false"/>
						<c:param name="isPrint" value="true" />
					</c:import>
				</td>
			</tr>
		</table>
		</div>
		<c:if test="${not empty kmImissiveSignMainForm.attachmentForms['attachment'].attachments}">
			<c:set var="existAtt" value="true" scope="request"/>
		</c:if>
		<c:if test="${empty loadAtt and 'true' eq existAtt}">
			<div class="lui_form_content_frame" style="padding-top:10px" id="attDiv_${vstatus.index }">
				<div class="titleDiv"><img src="${KMSS_Parameter_ContextPath}third/pda/resource/images/attachment.png"><bean:message bundle="km-imissive" key="kmImissive.print.attachment.record"/></div>
				<table     width=100% style="margin-top: 20px;">
					<tr>
						<td colspan="4">
							<c:choose>
								<c:when test="${not empty kmImissiveSignMainForm.attachmentForms['attachment'].attachments}">
									<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param
												name="fdKey"
												value="attachment" />
										<c:param
												name="formBeanName"
												value="kmImissiveSignMainForm" />
										<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId }"/>
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
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
		<div class="lui_form_content_frame" style="padding-top:10px" id="wflogDiv_${vstatus.index }">
	    <div class="titleDiv"><bean:message bundle="km-imissive" key="kmImissive.print.review.record"/></div>
	    <table     width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
				   <c:import url="/sys/workflow/include/sysWfProcess_log.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSignMainForm" />
					</c:import>
				</td>
			</tr>
		</table>
		</div>
		<c:if test="${kmImissiveSignMainForm.docStatus eq '30'}">
		<div class="lui_form_content_frame" style="padding-top:10px" id="circulationDiv_${vstatus.index }">
		<div class="titleDiv"><bean:message bundle="km-imissive" key="kmImissive.print.circulation.record"/></div>
	    <table     width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
					 <c:import
						url="/km/imissive/import/sysCirculationMain_viewPrint.jsp"
						charEncoding="UTF-8">
						<c:param
							name="formName"
							value="kmImissiveSignMainForm" />
					</c:import>
				</td>
			</tr>
		</table>
		</div>
		</c:if>
		
		<div class="lui_form_content_frame" style="padding-top:10px" id="readlogDiv_${vstatus.index }">
		 <div class="titleDiv"><bean:message bundle="km-imissive" key="kmImissive.print.read.record"/></div>
	     <table     width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
				  <c:import url="/km/imissive/import/sysReadLog_viewPrint.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSignMainForm" />
					<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId }"/>
			      </c:import>
				</td>
			</tr>
		 </table>
		 </div>
		 <c:if test="${kmImissiveSignMainForm.docStatus eq '30'}">
		 <div class="lui_form_content_frame" style="padding-top:10px" id="publiclogDiv_${vstatus.index }">
		 <div class="titleDiv"><bean:message bundle="km-imissive" key="kmImissive.print.publish.record"/></div>
	     <table     width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
	        	<c:import url="/km/imissive/import/sysNewsPublishMain_viewPrint.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSignMainForm" />
					<c:param name="fdKey" value="signMainDoc" />
			    </c:import>
				</td>
			</tr>
		 </table>
		 </div>
		 </c:if>
</div>

</div></div>
<% 
	//清除自定义表单内容
	request.removeAttribute("com.landray.kmss.web.taglib.FormBean");
	//清除自定义表单标签
	request.removeAttribute("com.landray.kmss.sys.xform.MulitiLang");
	//清除表单信息
	request.removeAttribute("kmImissiveSignMainForm"); 
%> 
</kmss:auth>
</c:forEach>
</center>
</form>
</template:replace>
		
</template:include>

