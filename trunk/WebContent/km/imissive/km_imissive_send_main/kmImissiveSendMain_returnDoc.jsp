<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%> 
<c:set var="kmImissiveSendMainForm" value="${requestScope[param.formName]}" />
   <tr>	  
   <td>
    <div style="margin-top: 15px;">
	     <div style="float:left">
			 <b><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.return"/>
			 </b>
		 </div>
		 <div style="margin-right:10px;text-align:right" id="returnBtn">
			  <kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=report&fdId=${kmImissiveSendMainForm.fdId}" requestMethod="GET">
			  	 <a href="javascript:;" onclick="exportResult('returnDoc');" class="com_btn_link">导出</a>&nbsp;&nbsp;
			  </kmss:auth>
		 </div>
    </div>
 	<div style="height: 15px;"></div>
	   <list:listview id="returnDoc" channel="returnDoc">
			<ui:source type="AjaxJson">
				{"url":"/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&deliver=true&fdMainId=${kmImissiveSendMainForm.fdId}&type=2&fdStatus=4&isReturnDoc=true"}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.listtable" cfg-norecodeLayout="simple">
			    <list:col-checkbox name="returnDoc"></list:col-checkbox>
				<list:col-auto props="kmImissiveRegDetailList.fdReg.fdName;kmImissiveRegDetailList.fdReg.fdDeliverType;fdUnitName;fdReturnTime;fdReturnOrg;fdContent"></list:col-auto>
			</list:colTable>	
			<ui:event topic="list.loaded">
			   if(LUI('report')._data.datas.length==0){
			      $("#returnBtn").css("visibility","hidden");
			   }
			</ui:event>
		</list:listview>
		<div style="height: 15px;"></div>
		<list:paging layout="sys.ui.paging.simple"  channel="returnDoc"></list:paging>
   </td>
</tr>