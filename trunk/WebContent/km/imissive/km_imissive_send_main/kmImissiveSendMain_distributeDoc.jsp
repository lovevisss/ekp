<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%> 
<tr>	  
   <td>
   <div style="margin-top: 15px;">
     <div style="float:left">
		 <b><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.distribute"/>
		 </b>
	 </div>
	 <div style="margin-right:10px;text-align:right" id="distributeBtn">
		 <c:if test="${param.fdRegType eq 'send'}">
		  <kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=distribute&fdId=${param.fdMainId}" requestMethod="GET">
		   	<a href="javascript:;" onclick="exportResult('distribute');" class="com_btn_link">导出</a>&nbsp;
		    <a href="javascript:;" onclick="urgeSign('distribute');" class="com_btn_link"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.btn.urgeSign"/></a>&nbsp;
	        <a href="javascript:;" onclick="distributeDoc();" class="com_btn_link"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.btn.distribute"/></a>&nbsp;
		    <a href="javascript:;" onclick="batchCancelDR('distribute', 'distribute');" class="com_btn_link"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.batch.btn.cancel"/></a>&nbsp;&nbsp;&nbsp;
		  </kmss:auth>
		 </c:if>
		 <c:if test="${param.fdRegType eq 'receive'}">
		 	<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=distribute&fdId=${param.fdMainId}" requestMethod="GET">
			 	<a href="javascript:;" onclick="exportResult('distribute');" class="com_btn_link">导出</a>&nbsp;
			    <a href="javascript:;" onclick="urgeSign('distribute');" class="com_btn_link"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.btn.urgeSign"/></a>&nbsp;
		        <a href="javascript:;" onclick="distributeDoc();" class="com_btn_link"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.btn.distribute"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:;" onclick="batchCancelDR('distribute', 'distribute');" class="com_btn_link"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.batch.btn.cancel"/></a>&nbsp;&nbsp;&nbsp;
			</kmss:auth>
		 </c:if>
		 <input type="checkbox" name="waitSignD"  onclick="changeDistribute('${param.fdMainId}','${param.fdRegType}');"><bean:message  bundle="km-imissive" key="status.waitSign"/>
		 <input type="checkbox" name="signedD"  onclick="changeDistribute('${param.fdMainId}','${param.fdRegType}');"><bean:message  bundle="km-imissive" key="status.signed"/>
    </div>
   </div>
 	<div style="height: 15px;"></div>
	   <list:listview id="distribute" channel="distribute">
			<ui:source type="AjaxJson">
				{"url":"/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&deliver=true&fdMainId=${param.fdMainId}&type=1&fdRegType=${param.fdRegType}"}
			</ui:source>
			<list:colTable  isDefault="true" layout="sys.ui.listview.listtable" cfg-norecodeLayout="simple" id="distributeT">
			    <list:col-checkbox name="distribute"></list:col-checkbox>
				<list:col-auto props="kmImissiveRegDetailList.fdReg.fdName;kmImissiveRegDetailList.fdReg.fdDeliverType;fdUnit.fdName;docCreateTime;fdOrgNames;fdStatus;nodeName;handlerName"></list:col-auto>
	             <c:if test="${param.fdRegType eq 'send'}">
		            <kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=distribute&fdId=${param.fdMainId}" requestMethod="GET">
			          <list:col-html style="width:60px;" title="">
			              if(row['_fdStatus'] =='0' || row['_fdStatus'] =='1'){
				              {$<a href="javascript:;" onclick="cancelDR('{%row.fdId%}','distribute','{%row.fdType%}');" class="com_btn_link cancelFlag_{%row.fdId%}"><bean:message bundle="km-imissive" key="kmImissiveSendMain.tracking.btn.cancel"/></a>$}
			              }
			               if(row['_fdStatus'] =='3' ){
				              {$<a href="javascript:;" onclick="opinionDetail('{%row.fdId%}','4');" class="com_btn_link"><bean:message bundle="km-imissive" key="kmImissiveSendMain.tracking.btn.opinionDetail"/></a>$}
			              }
			              if(row['_fdStatus'] =='4'){
				              {$<a href="javascript:;" onclick="opinionDetail('{%row.fdId%}','5');" class="com_btn_link"><bean:message bundle="km-imissive" key="kmImissiveSendMain.tracking.btn.opinionDetail"/></a>$}
			              }
			          </list:col-html>
			        </kmss:auth>	
		        </c:if>
		        <c:if test="${param.fdRegType eq 'receive'}">
		            <kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=distribute&fdId=${param.fdMainId}" requestMethod="GET">
			          <list:col-html style="width:60px;" title="">
			              if(row['_fdStatus'] =='0' || row['_fdStatus'] =='1'){
				              {$<a href="javascript:;" onclick="cancelDR('{%row.fdId%}','distribute','{%row.fdType%}');" class="com_btn_link cancelFlag_{%row.fdId%}"><bean:message bundle="km-imissive" key="kmImissiveSendMain.tracking.btn.cancel"/></a>$}
			              }
			              if(row['_fdStatus'] =='3' ){
				              {$<a href="javascript:;" onclick="opinionDetail('{%row.fdId%}','4');" class="com_btn_link"><bean:message bundle="km-imissive" key="kmImissiveSendMain.tracking.btn.opinionDetail"/></a>$}
			              }
			              if(row['_fdStatus'] =='4'){
				              {$<a href="javascript:;" onclick="opinionDetail('{%row.fdId%}','5');" class="com_btn_link"><bean:message bundle="km-imissive" key="kmImissiveSendMain.tracking.btn.opinionDetail"/></a>$}
			              }
			          </list:col-html>
			        </kmss:auth>	
		        </c:if>
		        
			</list:colTable>	
			<ui:event topic="list.loaded">
			   var waitSignD = document.getElementsByName("waitSignD")[0];
			   var signedD = document.getElementsByName("signedD")[0];
			   if(LUI('distribute')._data.datas.length==0&&!waitSignD.checked&&!signedD.checked){
			      $("#distributeBtn").css("visibility","hidden");
			   }
			</ui:event>					
		</list:listview>
		<div style="height: 15px;"></div>
		<list:paging layout="sys.ui.paging.simple" channel="distribute"></list:paging>
   </td>
</tr>	