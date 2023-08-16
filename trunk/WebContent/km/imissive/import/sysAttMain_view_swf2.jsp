<%@page import="com.landray.kmss.sys.tag.model.SysTagAppConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="java.util.List,com.landray.kmss.util.UserUtil"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil,com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsWebOfficeUtil"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.util.regex.Matcher"%>

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
	Pattern pattern = Pattern.compile("[\\s\\\\/:\\*\\?\\\"<>\\|]");
    Matcher matcher = pattern.matcher(fileName);
    fileName= matcher.replaceAll("");
    
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
<table class="contentAttTb">
<c:forEach items="${sysAttMains}" var="sysAttMain"	varStatus="vstatus">
	<c:set var="attachmentId" value="${sysAttMain.fdId}"/>
	<c:if test="${empty _fileName}">
	  <c:set var="fdFileName" value="${sysAttMain.fdFileName}"/>
	</c:if>
	<c:set var="fdAttMainId" value="${sysAttMain.fdId}" scope="request"/>
	<tr class="attachment_list_tr">
		<td class="fileicon">
			<img src="${KMSS_Parameter_ContextPath}resource/style/common/fileIcon/word.png" height="16" width="16" border="0" align="absmiddle" style="margin-right:3px;">
		</td>
		<td style="cursor: pointer;">
			<div class="filename">${sysAttMain.fdFileName}</div>
				<a href="javascript:void(0);" class="attswich com_btn_link" onclick="loadJGAttachment();">
				   <bean:message  bundle="km-imissive" key="kmImissive.expandDocContent"/>
				</a>
			<c:if test="${param.editable eq true }">
				<a href="javascript:void(0);" class="editContent com_btn_link" onclick="Com_OpenWindow('${param.editUrl}','_self');">
				   <bean:message  bundle="km-imissive" key="kmImissive.editDocContent"/>
				</a>
			</c:if>
		</td>
	</tr>
</c:forEach>
</table>
<div id="missiveButtonDiv" ></div>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<script>
function loadJGAttachment() {
	$('.contentArea').show();
	$('.jg_tip_container').show();
	$('.bar-right').css('width','50%');
	$('.content').css('margin-right','51.5%');
	var contentH = "566";
	if($('.content')&&$('.content').height()){
		contentH = $('.content').height()-130;
	}
	if(document.getElementById('IFrame_Content')){
		var  url="";
		if("${param.showAllPage}" == "" || "${param.showAllPage}" == 'true'){
			url = '<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${attachmentId}&viewer=htmlviewer&showAllPage=true&inner=yes"/>';
		}else{
			url = '<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${attachmentId}&viewer=htmlviewer&toolPosition=top&newOpen=true&inner=yes"/>';
		}
		document.getElementById('IFrame_Content').src = url;
		document.getElementById('IFrame_Content').style.height = contentH +'px';
	}else{ 
		var obj = document.getElementById("JGWebOffice_${JsParam.fdKey}");
		if(obj){ 
			setTimeout(function(){
				jg_attachmentObject_${JsParam.fdKey}.load(encodeURIComponent("${fdFileName}"), "");
				jg_attachmentObject_${JsParam.fdKey}.show();
				if(jg_attachmentObject_${JsParam.fdKey}.ocxObj){
					if(!jg_attachmentObject_${JsParam.fdKey}.canCopy){
						jg_attachmentObject_${JsParam.fdKey}.ocxObj.CopyType = "1";
						jg_attachmentObject_${JsParam.fdKey}.ocxObj.EditType = "0,1";
					}else{
						jg_attachmentObject_${JsParam.fdKey}.ocxObj.CopyType = "1";
						jg_attachmentObject_${JsParam.fdKey}.ocxObj.EditType = "4,1";
					}
					if(Com_Parameter.IE)
						jg_attachmentObject_${JsParam.fdKey}.activeObj.setAttribute("OnToolsClick","OnToolsClick(vIndex,vCaption);");
					else
						jg_attachmentObject_${JsParam.fdKey}.activeObj.setAttribute("event_OnToolsClick","OnToolsClick");
				}
			},500);
			
			var obj = document.getElementById("JGWebOffice_${JsParam.fdKey}");
			if(obj){ 
				obj.setAttribute("height", contentH+"px");
			}
		}
	}
} 
</script>
<c:choose>
	<c:when test="${empty param.isShowImg or param.isShowImg}">
	   <%
	   //取fdAttMainId的值判断附件是否已经转换
	   if(JgWebOffice.isExistViewPath(request)){ 
	  %>
	       <c:choose> 
                 <c:when test="${empty param.showAllPage or param.showAllPage}">
                	 <div class="contentArea">
				     <iframe id="IFrame_Content" width="100%" height="100%"
						frameborder="0" scrolling="no"> 
				     </iframe>
				     </div>
			     </c:when>
			 <c:otherwise> 
			 	<div class="contentArea">
			     <iframe id="IFrame_Content" width="100%" height="566px"
					frameborder="0" scrolling="auto"> 
			     </iframe>
			    </div> 
		     </c:otherwise>
			</c:choose>
	 <%}else{
		 boolean showAsJG = !"false".equals(request.getParameter("showAsJG"));
		  if(showAsJG){
		 %>
           <%@ include file="sysAttMain_viewinclude.jsp"%>
         <%}else if(SysAttWpsWebOfficeUtil.isEnable()){ %>
	     	<%@ include file="/sys/attachment/sys_att_main/wps/sysAttMain_viewinclude.jsp"%>
	     <% }%> 
	 <%} %>
	</c:when>
	<c:otherwise>
		<%if(SysAttWpsWebOfficeUtil.isEnable()){ %>
        	<%@ include file="/sys/attachment/sys_att_main/wps/sysAttMain_viewinclude.jsp"%>
        <% }else{%>
        	<%@ include file="sysAttMain_viewinclude.jsp"%>
        <% }%>
    </c:otherwise>
</c:choose>
