<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:set var="kmImissiveSendMainForm" value="${requestScope[param.formName]}" />
 <tr>	  
	 <td>
	  <div style="margin-top: 15px;">
	   	<div style="float:left">
			 <b><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.ModifyRecord"/></b>
	 	 </div>
		 <div style="height:15px;">
		 </div>
	  </div>
	  <div style="height: 15px;"></div>
	  	<list:listview id="modify" channel="modify">
			<ui:source type="AjaxJson">
				{"url":"/km/imissive/km_imissive_modify_record/kmImissiveModifyRecord.do?method=list&fdMainId=${kmImissiveSendMainForm.fdId}"}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.listtable" cfg-norecodeLayout="simple">
				<list:col-auto props=""></list:col-auto>
			</list:colTable>	
		</list:listview>
		<div style="height: 15px;"></div>
		<list:paging layout="sys.ui.paging.simple"  channel="modify"></list:paging>
	 </td>
</tr>