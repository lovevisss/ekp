<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<div id="div_condtionSection">
	<table class="tb_simple" width=100%>
		<html:hidden property="fdId"/>
		<tr>
			<%--报表名称--%>
			<td class="td_normal_title" width=15% >
				<bean:message  bundle="km-imissive" key="kmImissiveStat.docSubject"/>
			</td>
			<td  colspan=3>
				<xform:text property="docSubject" style="width:80%;" showStatus="edit" validators="maxLength(200)"></xform:text>
				<html:hidden property="fdAnalyzeType" value="${kmImissiveStatForm.fdAnalyzeType }"/>	
			</td>
		</tr>
		<tr>
			<%--对象类型--%>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="km-imissive" key="kmImissiveStat.fdMainType"/>
			</td>
			<td width=85% colspan="3">
				<xform:radio property="fdMainType" showStatus="edit" value="${kmImissiveStatForm.fdMainType}" onValueChange="changeMainType(this.value);">
					<xform:enumsDataSource enumsType="kmImissiveStat_fdMainType"></xform:enumsDataSource>
				</xform:radio>
			</td>
		</tr>
		<tr>
			<%--对象范围--%>
			<td class="td_normal_title" width="15%" >
				<bean:message  bundle="km-imissive" key="kmImissiveStat.analyzeObj.bound"/>
			</td>
			<td colspan="3">
				<xform:dialog propertyId="fdBoundIds"
			                  propertyName="fdBoundNames"
			                  textarea="true"
			                  required="true"
					          style="width:80%"
					          showStatus="edit"
					          htmlElementProperties="storage=true"
					          subject="${ lfn:message('km-imissive:kmImissiveStat.analyzeObj.bound') }">  
						      Dialog_UnitTreeList(true, 'fdBoundIds', 'fdBoundNames', ';',
						                            'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
						                            '<bean:message key="kmImissiveStat.analyzeObj.bound" bundle="km-imissive"/>',
						                            'kmImissiveUnitListService&parentId=!{value}',null)
				</xform:dialog>
			</td>
		</tr>
		<tr>
  			 	<td class="td_normal_title" width="15%" >
  			 		<bean:message  bundle="km-imissive" key="kmImissiveStat.fdDateQueryType"/>
  			 	</td>
				<td colspan="3">
					<div id="fdMainType_send">
						<xform:checkbox property="fdDateQueryType" showStatus="edit" value="${kmImissiveStatForm.fdDateQueryType}">
						<xform:enumsDataSource enumsType="km_imissive_stat_datequery_type"></xform:enumsDataSource>
					</xform:checkbox>
					</div>
					<div id="fdMainType_receive">
						<xform:checkbox property="fdDateQueryTypeReceive" showStatus="edit" value="${kmImissiveStatForm.fdDateQueryTypeReceive}">
						<xform:enumsDataSource enumsType="km_imissive_stat_datequery_type2"></xform:enumsDataSource>
					</xform:checkbox>
					</div>
 				</td>
		</tr>
		<%--阅读者 --%>
		<tr>
			<td class="td_normal_title"><bean:message bundle="sys-right" key="right.read.authReaders" /></td>
			<td colspan="3">
				<xform:address textarea="false" mulSelect="true" showStatus="edit"
					propertyId="authReaderIds" propertyName="authReaderNames" style="width:80%;">
				</xform:address>
			</td>
		</tr>
		<c:import url="/km/imissive/km_imissive_stat/common/kmImissiveStat_timeArea.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveStatForm"/>
		</c:import>
	</table>
	<input name="rowsize" type="hidden"/>
	<input name="pageno" type="hidden"/>
</div>
<script>
$(document).ready(function(){
	var fdMainType = "${kmImissiveStatForm.fdMainType}"
	changeMainType(fdMainType);
});


function changeMainType(val){
	if(val == '2'){
		$("#fdMainType_send").hide();
		$("#fdMainType_receive").show();
	}else{
		$("#fdMainType_send").show();
		$("#fdMainType_receive").hide();
	}
}
</script>