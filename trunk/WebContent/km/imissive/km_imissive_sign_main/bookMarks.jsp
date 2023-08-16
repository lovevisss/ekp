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
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.docSubject"/>
					 
				</td>
				<td width=15%>
					  
						docsubject
					 
				</td>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdDocType"/>
					 
				</td>
				<td width=15%>
					  
						doctype
					 
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdDocNum"/>
					 
				</td>
				<td width=15%>
					  
						docnum
					 
				</td>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdSecretGrade"/>
					 
				</td>
				<td width=15%>
					  
						secretgrade
					 
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdEmergencyGrade"/>
					 
				</td>
				<td width=15%>
					  
						emergency
					 
				</td>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdCheckId"/>
					 
				</td>
				<td width=15%>
					  
						checker
					 
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.docPublishTime"/>（格式yyyy-MM-dd，形如2018-07-30）
					 
				</td>
				<td width=15%>
					  
						signdaten
					 
				</td>
				<td width=35% class="td_normal_title">
		             
		            <bean:message  bundle="km-imissive" key="kmImissiveRedheadset.redhead"/>
		            
		        </td>
		        <td width=15%>
		             
		             redhead
		            
		        </td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdSignatureId"/>
					 
				</td>
				<td width=15%>
					  
						signature
					 
				</td>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.docPublishTime"/>（格式yyyy年MM月dd日，形如2018年7月30日）
					 
				</td>
				<td width=15%>
					  
						signdate
					 
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.docPublishTime.chinese"/>（形如二○一八年七月三十日）
					 
				</td>
				<td width=15%>
					  
						signdatecn
					 
				</td>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdDraftId"/>
					 
				</td>
				<td width=15%>
					  
						drafter
					 
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdDraftDeptId"/>
					 
				</td>
				<td width=15%>
					  
						draftunit
					 
				</td>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdDraftTime"/>
					 
				</td>
				<td width=15%>
					  
						drafttime
					 
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdDeadTime"/>
					 
				</td>
				<td width=15%>
					  
						deadtime
					 
				</td>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdPrintNum"/>
					 
				</td>
				<td width=15%>
					  
						printnum
					 
				</td>
			</tr>
			<tr>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdPrintPageNum"/>
					 
				</td>
				<td width=15%>
					  
						printpagenum
					 
				</td>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdContent"/>
					 
				</td>
				<td width=15%>
					  
						content
					 
				</td>
			</tr>
			<tr>
		        
		        <td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdReserveOne"/>
					 
				</td>
				<td width=15%>
					  
						reserveone
					 
				</td>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdReserveTwo"/>
					 
				</td>
				<td width=15%>
					  
						reservetwo
					 
				</td>
		 </tr>
			<tr>
				
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdReserveThree"/>
					 
				</td>
				<td width=15%>
					  
						reservethree
					 
				</td>
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdReserveFour"/>
					 
				</td>
				<td width=15%>
					  
						reservefour
					 
				</td>
			</tr>
			<tr>
				
				<td width=35% class="td_normal_title">
					  
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdReserveFive"/>
					 
				</td>
				<td width=15%>
					  
						reservefive
					 
				</td>
				<td width=35% class="td_normal_title">
					 
						<bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdDocFlow"/>
					  
				</td>
				<td width=15%>
					 
						docflow
					  
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