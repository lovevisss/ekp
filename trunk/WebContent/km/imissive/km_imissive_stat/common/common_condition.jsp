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
				<xform:radio property="fdMainType" showStatus="edit" value="${kmImissiveStatForm.fdMainType}">
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