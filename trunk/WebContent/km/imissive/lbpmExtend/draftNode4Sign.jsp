<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="/resource/jsp/jsperror.jsp"%>
<%@ include file="/resource/jsp/common.jsp"%>

<tr LKS_LabelName="<kmss:message key="FlowChartObject.Lang.Label_Variant" bundle="sys-lbpm-engine" />">
	<td>
		<table width="100%" class="tb_normal">
			<tr>
				<td>
					<table width="100%" class="tb_noborder">
					<tr>
					  <td width=50%><label><input type="checkbox" name="ext_modifyDocNum4Draft" value="true"><bean:message  bundle="km-imissive" key="kmImissive.modifyDocNum"/></label></td>
					  <td width=50%><label><input type="checkbox" name="ext_redhead4Draft" value="true"><bean:message  bundle="km-imissive" key="kmImissive.redhead"/></label></td>
					</tr>
					</table>
				</td>
			</tr>
		</table>
	</td>
</tr>
