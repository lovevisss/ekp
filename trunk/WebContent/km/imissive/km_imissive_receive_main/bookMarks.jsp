<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="auto">
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content"> 
		<script>
		Com_IncludeFile("jquery.js");
		</script>
		<script>
		$(document).ready(function(){
			var datas = opener.datas;
			if(datas && datas.length > 0){
				$("#bookmarkTb").show();
				for(var i = 0;i<datas.length;i++){
					var obj = datas[i];
					var html = '<tr><td width=35% class="td_normal_title">'
						html += obj.label;
					    html += '</td><td  width=85% colspan = "3">'
					    html += obj.name;
					    html += '</td><tr>'
					$("#bookmarkTb").append(html);
				}
			}
		});
		</script>
		<p class="txttitle"><bean:message  bundle="km-imissive" key="kmImissive.bookMarks.title"/></p>
		<table class="tb_normal" width=95%>
			<tr>
				<td  width=35%>
					<center>
						<bean:message  bundle="km-imissive" key="kmImissive.bookMarks.name"/>
					</center>
				</td>
				<td  width=15%>
					<center>
						<bean:message  bundle="km-imissive" key="kmImissive.bookMarks.code"/>
					</center>
				</td>
				<td  width=35%>
					<center>
						<bean:message  bundle="km-imissive" key="kmImissive.bookMarks.name"/>
					</center>
				</td>
				<td width=15%>
					<center>
						<bean:message  bundle="km-imissive" key="kmImissive.bookMarks.code"/>
					</center>
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
						<bean:message  bundle="km-imissive" key="kmImissiveSendMain.docSubject"/>
				</td>
				<td width=15%>
						docsubject
				</td>
				<td width=35% class="td_normal_title">
						<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdDocType"/>
				</td>
				<td width=15%>
						doctype
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
					<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdSendtoDept"/>
				</td>
				<td width=15%>
						sendunit
				</td>
				<td width=35% class="td_normal_title">
					<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdReceiveUnit"/>
				</td>
				<td width=15%>
						receiveunit
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
					<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdOtherSendtoUnits"/>
				</td>
				<td width=15%>
					othersendtounits
				</td>
				<td width=35% class="td_normal_title">
					<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdDocFlow"/>
				</td>
				<td width=15%>
					docflow
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
					<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.incomingDocumentNumber"/>
				</td>
				<td width=15%>
						docnum
				</td>
				<td width=35% class="td_normal_title">
						<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.receiptNumber"/>
				</td>
				<td width=15%>
						receivenum
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
						<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdSecretGrade"/>
				</td>
				<td width=15%>
						secretgrade
				</td>
				<td width=35% class="td_normal_title">
					<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdEmergencyGrade"/>
				</td>
				<td width=15%>
						emergency
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
						<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdSignerId"/>
				</td>
				<td width=15%>
						signer
				</td>
				<td width=35% class="td_normal_title">
					<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdSignTime"/>
				</td>
				<td width=15%>
						signtime
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
					<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdDeadTime"/>
				</td>
				<td width=15%>
						fddeadtime
				</td>
				<td width=35% class="td_normal_title">
					<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdRecorderId"/>
				</td>
				<td width=15%>
						recorder
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
					<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdRecordTimeBookMarks"/>
				</td>
				<td width=15%>
						recordtime
				</td>
				<td width=35% class="td_normal_title">
					<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdReceiveTimeBookMarks"/>
				</td>
				<td width=15%>
						receivetime
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
						<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdShareNum"/>
				</td>
				<td width=15%>
						fdShareNum
				</td>
				<td width=35% class="td_normal_title">
						<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdContent"/>
				</td>
				<td width=15%>
						content
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
						<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdReserveOne"/>
				</td>
				<td width=15%>
						reserveone
				</td>
				<td width=35% class="td_normal_title">
						<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdReserveTwo"/>
				</td>
				<td width=15%>
						reservetwo
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
						<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdReserveThree"/>
				</td>
				<td width=15%>
						reservethree
				</td>
				<td width=35% class="td_normal_title">
						<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdReserveFour"/>
				</td>
				<td width=15%>
						reservefour
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
						<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdReserveFive"/>
				</td>
				<td colspan="3">
						reservefive
				</td>
			</tr>
		</table>
		<br>
		<table class="tb_normal" width=95% id="bookmarkTb" style="display:none">
			<tr>
				<td width=15%>
					<center>
						<bean:message  bundle="km-imissive" key="kmImissive.bookMarks.name"/>
					</center>
				</td>
				<td  colspan="3">
					<center>
						<bean:message  bundle="km-imissive" key="kmImissive.bookMarks.code"/>
					</center>
				</td>
			</tr>
			<tr>
				<td colspan="4" >
					<bean:message  bundle="km-imissive" key="kmImissive.bookMarks.xform.tip"/>
				</td>
			</tr>
		</table>
	</template:replace>
</template:include>	