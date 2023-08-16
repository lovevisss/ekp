<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<%@ include file="/resource/jsp/htmlhead.jsp" %>
<script type="text/javascript">
	Com_IncludeFile("document.js", "style/" + Com_Parameter.Style + "/doc/");
	Com_IncludeFile("jquery.js");
	Com_IncludeFile('json2.js');
	Com_IncludeFile('dialog.js');
</script>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
</head>
<body>
	<form>
	<table class="tb_normal"  width=95%>
	    <%@ include file="/km/imissive/fieldlayout/common/param_top.jsp"%>
		<tr>
			<td class="td_normal_title" width=40%><bean:message bundle="km-imissive" key="kmImissive.fieldLayout.language" /></td>
			<td>
			     <xform:dialog propertyId="fdMissiveTypesIds"
			                   propertyName="fdMissiveTypesNames"
			                   textarea="true"
					           style="width:95%;" 
					           showStatus="edit"
					           required="true"
					           htmlElementProperties="storage=true"
					           subject="${ lfn:message('km-imissive:kmMissiveTemplateType.fdTypeId') }">  
					           Dialog_Tree(true, 'fdMissiveTypesIds', 'fdMissiveTypesNames', ';', 'kmImissiveTypeTreeService', 
				          						 '<bean:message key="kmMissiveTemplateType.fdTypeId" bundle="km-imissive"/>', null, null, '${JsParam.fdId}', null, null, 
				           					     '<bean:message bundle="km-imissive" key="kmMissiveTemplateType.fdTypeId"/>')
				</xform:dialog>
	       </td>
	    </tr>
	     <c:import url="/km/imissive/fieldlayout/common/param_required.jsp" charEncoding="UTF-8">
		     <c:param name="defaultChecked" value="true" />
		</c:import>
	    <c:import url="/km/imissive/fieldlayout/common/param_width.jsp" charEncoding="UTF-8">
				  <c:param name="defaultWidth" value="45%" />
		</c:import>
		 <tr>
			<td colspan="2">
				<c:import url="/sys/xform/designer/fieldlayout/default_layout/param_style.jsp" charEncoding="UTF-8">
				</c:import>
			</td>
		</tr>
	   	<%@ include file="/km/imissive/fieldlayout/common/param_bottom.jsp"%>
	</table>
	</form>
</body>
</html>
<script>
</script>