<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<div id="missiveButtonDiv" >
	<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_DOWNLOADOFDCONTENT">
		<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${param.attId}&fdFileName=${param.fileName}&convertType=${param.convertType}" requestMethod="GET">
			<a href="javascript:void(0);" class="attdownloadcontent"
			   onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${param.attId}&fdFileName=${param.fileName}&convertType=${param.convertType}');">
				<bean:message  bundle="km-imissive" key="button.download"/>
			</a>&nbsp;&nbsp;&nbsp;
		</kmss:auth>
	</kmss:authShow>
</div>