<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.web.taglib.TagUtils,com.landray.kmss.sys.attachment.forms.*,java.util.*"%>
<%@ page import="com.landray.kmss.sys.attachment.service.*"%>
<%@ page import="com.landray.kmss.util.StringUtil"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.util.regex.Matcher"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>
<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<%
	String formBeanName = request.getParameter("formBeanName");
	Object formBean = null;
	if(formBeanName != null && formBeanName.trim().length() != 0){
		formBean = pageContext.getAttribute(formBeanName);
		if(formBean == null){
			formBean = request.getAttribute(formBeanName);
		}
		if(formBean == null){
			formBean = session.getAttribute(formBeanName);
		}
		pageContext.setAttribute("_formBean", formBean);
	}else{
		formBeanName = "com.landray.kmss.web.taglib.FormBean";
	}
	Object originFormBean = pageContext.getAttribute("com.landray.kmss.web.taglib.FormBean");
	pageContext.setAttribute("com.landray.kmss.web.taglib.FormBean", formBean);
	if(formBean == null){
		formBean = com.landray.kmss.web.taglib.TagUtils.getInstance().lookup(pageContext,
				formBeanName, null);
		pageContext.setAttribute("_formBean", formBean);
	}
	
	//格式合同add页面不需要本地初稿按钮
	String fdIssample = null;
	try{
		fdIssample = (String)org.apache.commons.beanutils.PropertyUtils.getProperty(formBean,"fdIssample");
	}catch(Exception e){
		
	}
	if(fdIssample == null) {
		fdIssample = "false";
	}
	pageContext.setAttribute("_fdIssample", fdIssample);

%>
<ui:button id="wpsAddIn" style="" text="启动加载项" order="4" onclick="launchwps();"></ui:button>
<c:set var="fdKey" value="${param.fdKey}" />
<c:set var="fdModelId" value="${param.fdModelId}" />
<c:set var="fdModelName" value="${param.fdModelName}" />
<c:set var="attForms" value="${_formBean.attachmentForms[fdKey]}" />
<c:set var="attachmentId" value=""/>
<c:forEach items="${attForms.attachments}" var="sysAttMain"	varStatus="vstatus">
	<c:set var="attachmentId" value="${sysAttMain.fdId}"/>
</c:forEach>
<script>Com_IncludeFile("jquery.js");</script>
<script>Com_IncludeFile("polyfill.js","${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/wps/js/","js",true);</script>
<script>Com_IncludeFile("web-office-sdk-1.1.1.umd.js","${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/wps/js/","js",true);</script>
<script>Com_IncludeFile("wps_cloud_attachment.js","${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/wps/cloud/js/","js",true);</script>
<script>Com_IncludeFile("kmImissiveSendRedhead_script.js",Com_Parameter.ContextPath + "km/imissive/wps/","js",true);</script>
<c:if test="${wpsoaassist eq 'true'}">
<script type="text/javascript">
Com_IncludeFile("wps_utils.js",Com_Parameter.ContextPath + "sys/attachment/sys_att_main/wps/oaassist/js/","js",true);
function launchwps(){
	var fdAttMainId = "${attachmentId}";
	var flag = false;
	var books = addBookMarksByWps(this.bookMarks);
	if("${attachmentId}" == ""){
	   //请求在线编辑附件的id
	   var url="${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=addWpsOaassistOnlineFile"; 
	   $.ajax({     
	 	     type:"post",     
	 	     url:url,     
	 	     data:{fdTemplateModelId:"${param.fdTemplateModelId}",fdTemplateModelName:"${param.fdTemplateModelName}",fdTemplateKey:"${param.fdTemplateKey}",fdModelName:"${param.fdModelName}",fdKey:"${param.fdKey}",fdTempKey:"${param.fdTempKey}",fdModelId:"${param.fdModelId}",fdFileExt:"${param.fdFileExt}"},    
	 	     async:false,    //用同步方式 
	 	     success:function(data){
	 	    	if (data){
	 	    		var results =  eval("("+data+")");
				    if(results['editOnlineAttId']!=null){
				    	fdAttMainId = results['editOnlineAttId'];
				    	var wpsParam = {};
				    	wpsParam['wpsExtAppModel'] = 'kmImissive';
				    	wpsParam['redhead'] = '${param.redhead}';
				    	wpsParam['bookMarks'] = books;
				    	wpsParam['nodevalue'] = '${param.nodevalue}';
				    	wpsParam['newFlag'] = '${param.newFlag}';
				    	editWpsOAAssit(fdAttMainId,wpsParam);
					}
				}
	 		 }   
	    });	
	}else{
		var wpsParam = {};
    	wpsParam['wpsExtAppModel'] = 'kmImissive';
    	wpsParam['redhead'] = '${param.redhead}';
    	wpsParam['bookMarks'] = books;
    	wpsParam['nodevalue'] = '${param.nodevalue}';
    	wpsParam['newFlag'] = '${param.newFlag}';
		editWpsOAAssit(fdAttMainId,wpsParam);
	}
}
</script>
</c:if>