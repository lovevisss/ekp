<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<table class="tb_normal" width="100%" >
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.docSubject"/>
		</td>
		<td colspan="3">
			<xform:xtext property="docSubject" validators="maxLength(100)" required="true" style="width:95%"/>
		</td>
	</tr>
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdTopicCategory"/>
		</td>
		<td  width="35%">
			<html:hidden property="fdTopicCategoryId"/>
			<c:out value="${kmImeetingTopicForm.fdTopicCategoryName}"></c:out>
		</td>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdNo"/>
		</td>
		<td  width="35%">
			<c:if test="${kmImeetingTopicForm.docStatus==10 || kmImeetingTopicForm.docStatus==null || kmImeetingTopicForm.docStatus=='' }">
			   提交后自动生成
			</c:if>
			<c:if test="${(not empty kmImeetingTopicForm.docNumber) && kmImeetingTopicForm.docStatus!=10 }">
             	 	${ kmImeetingTopicForm.docNumber}
          	</c:if>
		</td>
	</tr>
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdReporter"/>
		</td>
		<td  width="35%">
			<xform:address 
				propertyId="fdReporterId" 
				propertyName="fdReporterName" 
				subject="${lfn:message('km-imeeting:kmImeetingTopic.fdReporter')}" 
				required="true"
				style="width:95%"
				orgType="ORG_TYPE_PERSON" />
		</td>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdChargeUnit"/>
		</td>
		<td  width="35%">
			<xform:address
				propertyName="fdChargeUnitName" 
				propertyId="fdChargeUnitId" 
				required="false"
				style="width:95%"
				orgType="ORG_TYPE_ORGORDEPT" />
		</td>
	</tr>
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdMaterialStaff"/>
		</td>
		<td  width="35%">
			<xform:address 
				propertyId="fdMaterialStaffId" 
				propertyName="fdMaterialStaffName" 
				required="false"
				style="width:95%"
				orgType="ORG_TYPE_PERSON" />
		</td>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdSourceSubject"/>
		</td>
		<td  width="35%">
			<xform:text property="fdSourceSubject" showStatus="edit" style="width:95%" />
		</td>
	</tr>
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdAttendUnit"/>
		</td>
		<td  width="85%" colspan="3">
			 <xform:dialog 
					propertyId="fdAttendUnitIds"
					propertyName="fdAttendUnitNames"
				    style="width:95%;" 
				    className="inputsgl"
				    required="true"
				    mulSelect="true"
				    showStatus="edit"
				    subject="${lfn:message('km-imeeting:kmImeetingTopic.fdAttendUnit')}"
				    useNewStyle="true" >
				Dialog_UnitTreeList(true, 'fdAttendUnitIds', 'fdAttendUnitNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
				  	'<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListService&parentId=!{value}&type=allUnit',
					mainCalBackFn,'kmImissiveUnitListService&fdKeyWord=!{keyword}&type=allUnit'
				);
			</xform:dialog>
			<script type="text/javascript">
			    Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
			    Com_IncludeFile('styles.css|jquery.ui.widget.js|jquery.marcopolo.js|jquery.manifest.js','js/jquery-plugin/manifest/');
			    function mainCalBackFn(value){
			    }
			</script>
		</td>
	</tr>
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdListenUnit"/>
		</td>
		<td  width="85%" colspan="3">
			<xform:dialog 
				propertyId="fdListenUnitIds"
				propertyName="fdListenUnitNames"
			    style="width:95%;" 
			    className="inputsgl"
			    mulSelect="true"
			    showStatus="edit"
			    useNewStyle="true"
			    subject="${lfn:message('km-imeeting:kmImeetingTopic.fdListenUnit')}">
				Dialog_UnitTreeList(true, 'fdListenUnitIds', 'fdListenUnitNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
				  	'<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListService&parentId=!{value}',
					mainCalBackFn,'kmImissiveUnitListService&fdKeyWord=!{keyword}'
				);
			</xform:dialog>
			<script type="text/javascript">
			    Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
			    Com_IncludeFile('styles.css|jquery.ui.widget.js|jquery.marcopolo.js|jquery.manifest.js','js/jquery-plugin/manifest/');
			    
			    function mainCalBackFn(value){
			    }
			</script>
		</td>
	</tr>
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.issue.text"/>
		</td>
		<td colspan="3">
			<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="mainonline"/>
				<c:param name="fdMulti" value="false" />
				<c:param name="uploadAfterSelect" value="true" />  
				<c:param name="enabledFileType" value="doc,docx,xls,xlsx,ppt,pptx,xlc,mppx,xlcx,wps,et,vsd,rtf,pdf" />
				<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId }" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
			</c:import>
		</td>
	</tr>
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.issue.material"/>
		</td>
		<td colspan="3">
			<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="attachment" />
				<c:param name="uploadAfterSelect" value="true" />  
				<c:param name="fdRequired" value="true" />
				<c:param name="enabledFileType" value="doc,docx,xls,xlsx,ppt,pptx,xlc,mppx,xlcx,wps,et,vsd,rtf,pdf" />
				<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId }" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
			</c:import>
		</td>
	</tr>	
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdContent"/>
		</td>
		<td  width="85%" colspan="3">
			<xform:textarea property="fdContent" style="width:97.5%;height:80px" validators="senWordsValidator(kmImeetingTopicForm)"/>
		</td>
	</tr>
</table>