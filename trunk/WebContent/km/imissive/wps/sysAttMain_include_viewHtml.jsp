<%@page import="com.landray.kmss.sys.tag.model.SysTagAppConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="java.util.List,com.landray.kmss.util.UserUtil"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil,com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.util.regex.Matcher"%>
<%@ page import="com.landray.kmss.sys.attachment.util.SysAttConfigUtil"%>
<c:set var="readOLConfig" value="<%=SysAttConfigUtil.getReadOLConfig()%>"/>
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
//得到文档状态，用于控制留痕按钮在发布状态中不显示
String docStatus = null;
try{
docStatus = (String)org.apache.commons.beanutils.PropertyUtils.getProperty(formBean,"docStatus");
pageContext.setAttribute("_docStatus", docStatus);
}catch(Exception e){}

//得到文档标题,下载时取文档标题
String fileName= null;
try{
	String docSubject = (String)org.apache.commons.beanutils.PropertyUtils.getProperty(formBean,"docSubject"); 
	if(StringUtil.isNotNull(docSubject)){
		fileName = docSubject;
	}else{
		String fdName = (String)org.apache.commons.beanutils.PropertyUtils.getProperty(formBean,"fdName"); 
		if(StringUtil.isNotNull(fdName)){
			fileName = fdName;
		}
	}
	pageContext.setAttribute("attFileType",fileName.substring(fileName.lastIndexOf(".")).toLowerCase());
	Pattern pattern = Pattern.compile("[\\s\\\\/:\\*\\?\\\"<>\\|]");
    Matcher matcher = pattern.matcher(fileName);
    fileName= matcher.replaceAll("");
    
    if(fileName.length() > 100 ){
    	fileName = fileName.substring(0, 100);
    }
    
	pageContext.setAttribute("_fileName",fileName+".doc");
}catch(Exception e){}

Object originFormBean = pageContext.getAttribute("com.landray.kmss.web.taglib.FormBean");
pageContext.setAttribute("com.landray.kmss.web.taglib.FormBean", formBean);
if(formBean == null){
	formBean = com.landray.kmss.web.taglib.TagUtils.getInstance().lookup(pageContext,
			formBeanName, null);
	pageContext.setAttribute("_formBean", formBean);
}
%>
<c:set var="attForms" value="${_formBean.attachmentForms[param.fdKey]}" />
<c:set var="attachmentId" value=""/>
<c:set var="fdFileName" value="${_fileName}"/>
<c:set var="sysAttMains" value="${attForms.attachments}" />
<%
		//以下代码用于附件不通过form读取的方式
		List sysAttMains = (List)pageContext.getAttribute("sysAttMains");
		if(sysAttMains==null || sysAttMains.isEmpty()){
			try{
				String _modelName = request.getParameter("fdModelName");
				String _modelId = request.getParameter("fdModelId");
				String _key = request.getParameter("fdKey");
				if(StringUtil.isNotNull(_modelName) 
						&& StringUtil.isNotNull(_modelId) 
						&& StringUtil.isNotNull(_key)){
					ISysAttMainCoreInnerService sysAttMainService = (ISysAttMainCoreInnerService)SpringBeanUtil.getBean("sysAttMainService");
					sysAttMains = sysAttMainService.findByModelKey(_modelName,_modelId,_key);
				}
				if(sysAttMains!=null && !sysAttMains.isEmpty()){
					pageContext.setAttribute("sysAttMains",sysAttMains);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
<c:forEach items="${sysAttMains}" var="sysAttMain"	varStatus="vstatus">
	<c:set var="attachmentId" value="${sysAttMain.fdId}"/>
	<c:if test="${empty _fileName}">
	  <c:set var="fdFileName" value="${sysAttMain.fdFileName}"/>
	</c:if>
	<c:set var="fdAttMainId" value="${sysAttMain.fdId}" scope="request"/>
	<c:set var="fdFileName" value="${sysAttMain.fdFileName}" scope="request"/>
</c:forEach>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<c:set var="canDownload" value="false"/>
<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=downloadContent&fdModelName=${param.fdModelName}&fdId=${attachmentId}" requestMethod="GET">
	 <c:set var="canDownload" value="true"/>	
</kmss:auth>
<script>
   	function refreshGwPage(){
		if(${readOLConfig eq '1'}){
			history.go(0);
		}else{
			document.getElementById('pdfFrame').src = ("<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${attachmentId}&viewer=htmlviewer&toolPosition=top&newOpen=true&inner=yes&wpsCloudGwFlag=${wpsCloudGwFlag }"/>");
		}

	}
</script>
<c:set var="_isExistViewPath" value="<%=JgWebOffice.isExistViewPath(request)%>"/>
<c:choose>
	<c:when  test="${param._useWpsLinuxView eq 'true' or _isExistViewPath eq 'true'}">
		<div id="missiveButtonDiv" >
           	<jsp:include page="/km/imissive/wps/kmImissiveSendMain_btn_include.jsp">
		  		<jsp:param name="cleardraft" value="${param.cleardraft}"/>
		  		<jsp:param name="fdModelName" value="${param.fdModelName}"/>
		  		<jsp:param name="redhead" value="${param.redhead}"/>
		  		<jsp:param name="signtrue" value="${param.signtrue}"/>
		  		<jsp:param name="attachmentId" value="${attachmentId}"/>
		  		<jsp:param name="bookMarks" value="${param.bookMarks}"/>
		  		<jsp:param  name="nodevalue"  value="${param.nodevalue}"/>
		  		<jsp:param  name="saveRevisions"  value="${param.saveRevisions}"/>
		  		<jsp:param  name="forceRevisions"  value="${param.forceRevisions}"/>
		  		<jsp:param  name="editDocContent"  value="${param.editDocContent}"/>
		  		<jsp:param  name="editStatus"  value="${param.editStatus}"/>
		  		<jsp:param  name="canEdit"  value="${param.canEdit}"/>
		  		<jsp:param  name="fdFileName"  value="${fdFileName}"/>
				<jsp:param  name="formName" value="${param.formName}" />
				<jsp:param  name="fdTemplateId" value="${param.fdTemplateId}" />
				<jsp:param  name="modelFlag" value="${param.modelFlag}" />
			</jsp:include>
		  </div>
       	<c:choose>
           <c:when test="${empty param.showAllPage or param.showAllPage}">
		     <ui:event event="show">
		  	  	document.getElementById('pdfFrame').src = ("<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${attachmentId}&viewer=htmlviewer&showAllPage=true"/>");
		     </ui:event>
		     <iframe id="pdfFrame" width="100%" height="100%" frameborder="0" scrolling="no"> 
		     </iframe>
	     </c:when>
		 <c:otherwise> 
		     <ui:event event="show">
		  	  document.getElementById('pdfFrame').src = ("<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${attachmentId}&viewer=htmlviewer&toolPosition=top&newOpen=true&inner=yes"/>");
		     </ui:event>
		     <iframe id="pdfFrame" width="100%" height="600px" frameborder="0" scrolling="auto"> 
		     </iframe>
	     </c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		 <div id="missiveButtonDiv" >
			 <c:import url="/km/imissive/import/xformBookmark_include.jsp"	charEncoding="UTF-8">
				 <c:param name="formName" value="${param.formName}" />
				 <c:param name="fdTemplateId" value="${param.fdTemplateId}" />
			 </c:import>
			<a href="javascript:void(0);" class="attbook"
				onclick="openBookmarkHelp(Com_Parameter.ContextPath+'km/imissive/km_imissive_${param.modelFlag}_main/bookMarks.jsp');">
				<bean:message key="kmImissive.bookMarks.title" bundle="km-imissive" />
			</a>
		 </div>
		<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
			<c:param name="formBeanName" value="${param.fdModelName}" />
			<c:param name="fdKey" value="${param.fdKey}" />
			<c:param name="fdModelId" value="${param.fdModelId}" />
			<c:param name="fdModelName" value="${param.fdModelName}" />
			<c:param  name="bookMarks"  value="${param.bookMarks}"/>
			<c:param  name="nodevalue"  value="${param.nodevalue}"/>
			<c:param  name="signtrue"  value="${param.signtrue}"/>
			<c:param name="wpsExtAppModel" value="kmImissive" />
			<c:param name="fdShowMsg" value="false"/>
			<c:param  name="fdViewType"  value="imissive"/>
			<c:param name="cleardraft" value="${param.cleardraft}" />
			<c:param  name="saveRevisions"  value="${param.saveRevisions}"/>
			<c:param  name="forceRevisions"  value="${param.forceRevisions}"/>
			<c:param name="canDownload" value="${canDownload}" />
		</c:import>
	</c:otherwise>
</c:choose>	