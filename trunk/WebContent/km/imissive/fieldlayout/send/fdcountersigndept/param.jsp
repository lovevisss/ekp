<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<%@ include file="/resource/jsp/htmlhead.jsp" %>
<script type="text/javascript">
	Com_IncludeFile("document.js", "style/" + Com_Parameter.Style + "/doc/");
	Com_IncludeFile("jquery.js");
	Com_IncludeFile('json2.js');
	Com_IncludeFile('dialog.js');
	Com_IncludeFile("unitDialog.js", Com_Parameter.ContextPath+ "km/imissive/resource/js/", "js", true);
	Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
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
			<%-- 默认会签 --%>
				<td class="td_normal_title" width=40%> <bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdCounterSignDept"/></td>
				<td>
				    <xform:dialog propertyId="fdCounterSignDeptIds"
				                  propertyName="fdCounterSignDeptNames"
						          style="width:85%" 
						          showStatus="edit"
						          className="inputsgl" 
						          htmlElementProperties="storage=true"
						          subject="${ lfn:message('km-imissive:kmMissiveMainMainto.fdUnitId') }">  
							      Dialog_UnitTreeList(true, 'fdCounterSignDeptIds', 'fdCounterSignDeptNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
		      									  '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive" />',
		      									  'kmImissiveUnitListService&parentId=!{value}');
					</xform:dialog>
		       </td>
		 </tr>
		 <c:import url="/km/imissive/fieldlayout/common/param_width.jsp" charEncoding="UTF-8">
		      <c:param name="defaultWidth" value="95%" />
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