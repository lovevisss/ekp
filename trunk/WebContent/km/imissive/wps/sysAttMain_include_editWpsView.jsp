<%@page import="com.landray.kmss.sys.tag.model.SysTagAppConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="java.util.List,com.landray.kmss.util.UserUtil"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil,com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.util.regex.Matcher"%>
<%@ page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil" %>
<c:set var="_useWpsLinuxView" value="<%=SysAttWpsCloudUtil.getUseWpsLinuxView()%>"/>
<c:choose>
	<c:when test="${_useWpsLinuxView eq 'true'}">
		<c:import url="/km/imissive/import/xformBookmark_include.jsp"	charEncoding="UTF-8">
			<c:param name="formName" value="${param.formName}" />
			<c:param name="fdTemplateId" value="${param.fdTemplateId}" />
		</c:import>
		<div id="missiveButtonDiv" style="text-align:right;">
		<a href="javascript:void(0);" class="attbook"
			onclick="openBookmarkHelp(Com_Parameter.ContextPath+'km/imissive/km_imissive_${param.modelFlag}_main/bookMarks.jsp');">
			<bean:message key="kmImissive.bookMarks.title"
				bundle="km-imissive" />
		</a>
		<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${param.initAttId}" requestMethod="GET">
			<a href="javascript:void(0);" class="attbook"
			   onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${param.initAttId}&downloadType=manual');">
				<bean:message  bundle="km-imissive" key="button.download"/>
			</a>
		</kmss:auth>
		<a href="javascript:void(0);" class="attswich com_btn_link" onclick="editWpsFile('${param.initAttId}')">
		        编辑正文&nbsp;&nbsp;&nbsp;
			</a>
		</div>
		 <iframe id="pdfFrame" width="100%" height="100%" frameborder="0" scrolling="no"> 
		 </iframe>
		<script type="text/javascript">
		    Com_IncludeFile("wps_utils.js",Com_Parameter.ContextPath + "sys/attachment/sys_att_main/wps/oaassist/js/","js",true);
		    Com_IncludeFile("kmImissiveSendRedhead_script.js",Com_Parameter.ContextPath + "km/imissive/wps/","js",true);
		    function openWpsFile(fdId){
		        var wpsParam = {};
		        wpsParam['wpsExtAppModel'] = "kmImissive";
		        wpsParam['signTrue'] = '${param.signtrue}';
		        openWpsOAAssit(fdId,wpsParam);
		    };
		    function editWpsFile(fdId){
		        var wpsParam = {};
		        var books = addBookMarksByWpsAddIn('${param.bookMarks}');
		        wpsParam['wpsExtAppModel'] = "kmImissive";
		        wpsParam['cleardraft'] = '${param.cleardraft}';
		        wpsParam['redhead'] = '${param.redhead}';
		        wpsParam['signTrue'] = '${param.signtrue}';
		        wpsParam['bookMarks'] = books;
		        wpsParam['nodevalue'] = '${param.nodevalue}';
		        wpsParam['saveRevisions'] = '${param.saveRevisions}';
		        wpsParam['forceRevisions'] = '${param.forceRevisions}';
		        wpsParam['newFlag'] = 'true';
		        editWpsOAAssit(fdId,wpsParam);
		    }       
		    function refreshGwPage(){
		        document.getElementById('pdfFrame').src = ("<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${param.initAttId}&viewer=htmlviewer&toolPosition=top&newOpen=true&inner=yes"/>");
		    }
		    $(document).ready(function(){
		        document.getElementById('pdfFrame').src = ("<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${param.initAttId}&viewer=htmlviewer&toolPosition=top&newOpen=true&inner=yes"/>");
		    });
		</script>
	</c:when>
	<c:otherwise>
		<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="editonline" />
			<c:param name="fdMulti" value="false" />
			<c:param name="fdModelId" value="${param.fdId}" />
			<c:param name="fdModelName" value="${param.fdModelName}" />
			<c:param name="addToPreview" value="false" />
			<c:param name="redhead" value="${param.redhead}" />
			<c:param name="wpsExtAppModel" value="kmImissive" />
			<c:param name="nodevalue" value="${param.nodevalue}" />
			<c:param name="bookMarks" value="${param.bookmarkJson}" />
			<c:param name="newFlag" value="true" />
			<c:param  name="fdViewType"  value="imissive"/>
		</c:import>
	</c:otherwise>
</c:choose>