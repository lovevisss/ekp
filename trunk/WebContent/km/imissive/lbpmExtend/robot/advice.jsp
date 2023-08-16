<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="config.edit" sidebar="no">
	<template:replace name="content" >
	
		<table width="100%" class="tb_normal">
			<tr>
				<td class="td_normal_title" width="15%">签收模板</td>
				<td>
					<xform:dialog propertyName="fdTemplateName" propertyId="fdTemplateId" showStatus="edit" style="width:250px;" dialogJs="selectTemplate();"></xform:dialog>
				</td>
			</tr>
		</table>
		
		<script>
			LUI.ready(function(){
				initDocument();
			});
			
			function initDocument() {
				if(parent.NodeData && parent.NodeData.content){
					var datas = JSON.parse(parent.NodeData.content);
					$("input[name='fdTemplateId']").val(datas.fdTemplateId);
					$("input[name='fdTemplateName']").val(datas.fdTemplateName);
				}
			};
		
			function selectTemplate(){
				Dialog_Template('com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate', 'fdTemplateId::fdTemplateName',false,true);
			}
			
			
			function returnValue(){
				var rs = {};
				rs.fdTemplateId = $("input[name='fdTemplateId']").val();
				rs.fdTemplateName = $("input[name='fdTemplateName']").val();
				
				return JSON.stringify(rs);
			}
		</script>
	</template:replace>
</template:include>