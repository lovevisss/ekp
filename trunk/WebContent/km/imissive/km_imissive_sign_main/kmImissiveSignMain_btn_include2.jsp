<%@ page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>

<div id="downloadDiv" style="text-align: right;;padding-bottom:5px">&nbsp;
	<kmss:authShow roles="ROLE_KMIMISSIVE_SIGN_PRINTCONTENT">
		<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=print&fdId=${attId}" requestMethod="GET">
			<a href="javascript:void(0);" class="attprint"
			   onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=print&fdId=${attId }','_blank')">
				<bean:message  bundle="km-imissive" key="button.printText"/>
			</a>&nbsp;
		</kmss:auth>
	</kmss:authShow>
	<kmss:authShow roles="ROLE_KMIMISSIVE_SIGN_DOWNLOADCONTENT">
		<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${attId}" requestMethod="GET">
			<a href="javascript:void(0);" class="attdownloadcontent"
			   onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${attId}&downloadType=manual');">
				<bean:message  bundle="km-imissive" key="button.download"/>
			</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</kmss:auth>
	</kmss:authShow>
</div>
<iframe id="pdfFrame"  width="100%"  style="min-height:565px;height:565px"  frameborder="0"></iframe>
<%if("true".equals(KmImissiveConfigUtil.isShowImg())){ %>
<c:choose>
	<c:when test="${empty showAllPage or showAllPage}">
		<%if("tab".equals(KmImissiveConfigUtil.getDisplayMode()) || "flat".equals(KmImissiveConfigUtil.getDisplayMode())){ %>
		<script type="text/javascript">
			$(document).ready(function(){
				setTimeout(function(){
					document.getElementById('pdfFrame').src='<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${param.attId}&showAllPage=true&newOpen=true&inner=yes&pdfJgSignKey=${param.pdfJgSignKey}"/>';
				},1000);
			});
		</script>
		<%}else{ %>
		<ui:event event="show">
			document.getElementById('pdfFrame').src='<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${param.attId}&showAllPage=true&newOpen=true&inner=yes&pdfJgSignKey=${param.pdfJgSignKey}"/>';
		</ui:event>
		<%} %>
	</c:when>
	<c:otherwise>
		<%if("tab".equals(KmImissiveConfigUtil.getDisplayMode()) || "flat".equals(KmImissiveConfigUtil.getDisplayMode())){ %>
		<script type="text/javascript">i
			$(document).ready(function(){
				setTimeout(function(){
					var srcurl = '<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${param.attId}&toolPosition=top&newOpen=true&inner=yes&pdfJgSignKey=${param.pdfJgSignKey}"/>';
					setUrlWithTabMode(srcurl);
				},1000);
			});
		</script>
		<%}else{ %>
		<script type="text/javascript">i
		$(document).ready(function(){
			document.getElementById('pdfFrame').src = ("<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${param.attId}&toolPosition=top&newOpen=true&inner=yes&pdfJgSignKey=${param.pdfJgSignKey}"/>");
		});
		</script>
		<%} %>
	</c:otherwise>
</c:choose>
<%}else{%>
<c:choose>
	<c:when test="${empty showAllPage or showAllPage}">
		<%if("tab".equals(KmImissiveConfigUtil.getDisplayMode()) || "flat".equals(KmImissiveConfigUtil.getDisplayMode())){ %>
		<script type="text/javascript">
			$(document).ready(function(){
				setTimeout(function(){
					document.getElementById('pdfFrame').src='<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${param.attId}&showAllPage=true&inner=yes&pdfJgSignKey=${param.pdfJgSignKey}"/>';
				},1000);
			});
		</script>
		<%}else{ %>
		<ui:event event="show">
			document.getElementById('pdfFrame').src='<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${param.attId}&showAllPage=true&inner=yes&pdfJgSignKey=${param.pdfJgSignKey}"/>';
		</ui:event>
		<%} %>
	</c:when>
	<c:otherwise>
		<%if("tab".equals(KmImissiveConfigUtil.getDisplayMode()) || "flat".equals(KmImissiveConfigUtil.getDisplayMode())){ %>
		<script type="text/javascript">
			$(document).ready(function(){
				setTimeout(function(){
					var srcurl = '<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${param.attId}&inner=yes&pdfJgSignKey=${param.pdfJgSignKey}"/>';
					setUrlWithTabMode(srcurl);
				},1000);
			});
		</script>
		<%}else{ %>
		<ui:event event="show">
			document.getElementById('pdfFrame').src = ("<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${param.attId}&inner=yes&pdfJgSignKey=${param.pdfJgSignKey}"/>");
		</ui:event>
		<%} %>
	</c:otherwise>
</c:choose>
<%} %>
<script type="text/javascript">
	function setUrlWithTabMode(srcurl){
		var contentH = 520;
		//如果是左右结构，则重新计算高度
		if($('.content')&&$('.content').height()){
			contentH = $('.content').height()-100;
		}
		srcurl += '&attHeight='+contentH;
		document.getElementById('pdfFrame').src = srcurl;
		$('#pdfFrame').css('min-height', (contentH)+'px');
		$('#pdfFrame').css('height', (contentH+20)+'px');
	}
</script>
