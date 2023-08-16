<%@page language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="org.apache.commons.beanutils.PropertyUtils"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.common.forms.IExtendForm" %>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="default.print">
	<template:replace name="content">
				<link rel="stylesheet" type="text/css" href="${LUI_ContextPath }/sys/print/resource/css/main_define_view.css"/>
				<link rel="stylesheet" type="text/css" href="${LUI_ContextPath }/sys/print/resource/css/previewdesign.css"/>
				<script>
					window.colorChooserHintInfo = {
						cancelText: '取消',
						chooseText: '确定'
					};
				
					// 自定义表单的全局变量
					var Xform_ObjectInfo = {};
					Xform_ObjectInfo.Xform_Controls = [];
				</script>
				
				<%
					if(request.getHeader("User-Agent").toUpperCase().indexOf("MSIE")>-1){
						request.setAttribute("isIE","true");
					}else if(request.getHeader("User-Agent").toUpperCase().indexOf("TRIDENT")>-1){
						request.setAttribute("isIE","true");
					}else{
						request.setAttribute("isIE","false");
					}
				
					String formBeanName = (String)request.getAttribute("formName");
					String mainFormName = null;
					String xformFormName = null;
					int indexOf = formBeanName.indexOf('.');
					if (indexOf > -1) {
						mainFormName = formBeanName.substring(0, indexOf);
						xformFormName = formBeanName.substring(indexOf + 1);
						pageContext.setAttribute("_formName", xformFormName);
					} else {
						mainFormName = formBeanName;
						pageContext.setAttribute("_formName", null);
					}
					IExtendForm mainForm = (IExtendForm)request.getAttribute(mainFormName);
					request.setAttribute("mainModelForm", mainForm);
					Object xform = xformFormName == null ? mainForm : PropertyUtils.getProperty(mainForm, xformFormName);
					
					if(xform instanceof IExtendForm){
						IExtendForm extendForm = (IExtendForm)xform;
						String mainModelName = extendForm.getModelClass().getName();
						request.setAttribute("_mainModelName", mainModelName);
					}
					
					String path = "";
					try{
						path = (String) PropertyUtils.getProperty(xform, "extendDataFormInfo.extendFilePath");
					}catch(Exception e){
					}
					if (StringUtil.isNotNull(path)) {
						request.setAttribute("_xformForm", xform);
						request.setAttribute("_xformMainForm", mainForm);
					}
					//控制权限区域显示
					request.setAttribute("SysForm.isPrint", "true");
				%>
				
				<c:if test="${not empty fdTmpFileName }">
				
					<link rel="stylesheet" type="text/css" href="<c:url value="/${fn:replace(fdTmpFileName,'.jsp','')}.css"/>">
					
					<script>
						Xform_ObjectInfo.mainModelName = "${_mainModelName}";
						Xform_ObjectInfo.mainFormId = "${_xformMainForm.fdId}";
				
						Com_IncludeFile("jquery.js|xform.js|data.js|form.js");
						Com_IncludeFile("previewdesign.js",Com_Parameter.ContextPath+"sys/print/import/","js",true);
						Com_IncludeFile("designer.css",Com_Parameter.ContextPath+"sys/print/designer/style/","css",true);
					</script>
					
					<%
						request.removeAttribute("_xformMainForm");
						if(xform instanceof IExtendForm){
							request.removeAttribute("_mainModelName");
						}
					%>
					
					<c:if test="${not empty param.docSubject }">
						<div id="title" class="txttitle">${HtmlParam.docSubject }</div>
					</c:if>
					
					<form name="sysPrintTemplateForm">
						<div id="sysPrintdesignPanel">
							<c:set var="_fdTmpFileName" value="${fdTmpFileName }" />
							
							<c:if test="${fn:indexOf(fdTmpFileName,'.jsp')<=0 }">
								<c:set var="_fdTmpFileName" value="${fdTmpFileName }.jsp" />
							</c:if>
							<c:import url="/${_fdTmpFileName}" charEncoding="UTF-8">
							</c:import>
							
							<p>&nbsp;</p>
							
							<script>
								//解析表单view页面存值 
								var xform_data_hide={};
								<%
								        Map<String ,Object> map=(java.util.Map)request.getAttribute("view_xform_value");
										if(map !=null){
											for(Map.Entry<String ,Object> entry : map.entrySet()){
												String val=StringUtil.clearScriptTag((String)entry.getValue());
												val=StringUtil.XMLEscape(val);
												out.println("xform_data_hide[\""+entry.getKey()+"\"]=\""+val+"\";");
											}
										}
								%>
								//将特殊字符转义还原
								for(var temp in  xform_data_hide){
									if(xform_data_hide[temp]==null){
										continue;
									}
									xform_data_hide[temp]=xform_data_hide[temp].replace(/&amp;/g, "&").replace(/&quot;/g, "\"").replace(/&lt;/g, "<").replace(/&gt;/g, ">");
								}
							</script>
						</div>
					</form>	
					<script type="text/javascript">
						var dashDom = {};
						var isIE = '${isIE}';
						var previewDesign = null;
						
						function domReady(){
							//调整页面宽度
							var designPanel = $('#sysPrintdesignPanel');
							designPanel.parents('table').css('width','100%');
							
							seajs.use(['sys/print/resource/js/previewdesign', 'lui/dialog'], function(pd, dialog) {
								previewDesign = new pd.PreviewDesign(designPanel);
								
								//使用旧的拖动逻辑
								$("#sysPrintdesignPanel table[fd_type='table']").mousedown(function(event){
										sysPreviewDesign._mousedown(event);
									}).mouseup(function(event){
										sysPreviewDesign._mouseup(event);
									}).mousemove(function(event){
										sysPreviewDesign._mousemove(event);
									});		
								sysPreviewDesign.resetBoxWidth(designPanel.get(0));
								
								//用户提示
								//pd.showTip();
							});
						}
						
						window.windowPrint = function() {
							previewDesign.ready(function(done) {
								window.print();
								done();				
							});
						}
						
						window.outputPDF = function() {
							seajs.use(['lui/export/export'],function(exp) {
								previewDesign.ready(function(done) {
									exp.exportPdf($('.tempTB').get(0));
									done();
								});
							});
						}
						
						window.printView = function() {
							var isIe = "${isIE}";
							try{
								if(isIe=='true' && document.all.WebBrowser){
									previewDesign.ready(function(done) {
										document.all.WebBrowser.ExecWB(7,1);
										done();
									});
								}
							}catch(e){
								alert('<bean:message key="button.printPreview.error" bundle="sys-print"/>');
							}
						}
						
						window.printZoomFontSize = function(size){
							var root = document.getElementById("sysPrintdesignPanel");
							var i = 0;
							for (i = 0; i < root.childNodes.length; i++) {
								SetPrintZoomFontSize(root.childNodes[i], size);
							}
							var tag_fontsize;
							if(root.currentStyle){
							    tag_fontsize = root.currentStyle.fontSize;  
							}  
							else{  
							    tag_fontsize = getComputedStyle(root, null).fontSize;  
							} 
							root.style.fontSize = parseInt(tag_fontsize) + size + 'px';
							
							//取消单元格字体大小设置
							previewDesign.setDialogSetting({
								canSetFontSize: false
							});
						}
						
						window.SetPrintZoomFontSize = function(dom, size) {
							if (dom.nodeType == 1 && dom.tagName != 'OBJECT' && dom.tagName != 'SCRIPT' && dom.tagName != 'STYLE' && dom.tagName != 'HTML' && dom.tagName!='LINK') {
								for (var i = 0; i < dom.childNodes.length; i ++) {
									SetPrintZoomFontSize(dom.childNodes[i], size);
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
						
						Com_AddEventListener(window, 'load', domReady);
					</script>
				</c:if>
	</template:replace>
</template:include>

