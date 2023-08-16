<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script>
  Com_IncludeFile("unitDialog.js", Com_Parameter.ContextPath+ "km/imissive/resource/js/", "js", true);
  Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
</script>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<span id="names" class="xform_fieldlayout" style="<%=parse.getStyle()%>">
	${kmImissiveSendMainForm.fdCounterSignDeptNames}
</span>
<!-- 是否有会签字段标识 -->
<input type="hidden"  name="counterSignDeptFlag"/>

<c:if test="${isSignEnd!=true and param.mobile != 'true'}">
    <!-- 会签管理角色|发文的文书 -->
<kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=counterSign&fdId=${param.fdId}" requestMethod="GET">
	<input type="hidden" id="fdCounterSignDeptIds" name="fdCounterSignDeptIds" value="${kmImissiveSendMainForm.fdCounterSignDeptIds}"/>
	<input type="hidden" id="fdCounterSignDeptNames" name="fdCounterSignDeptNames" value="${kmImissiveSendMainForm.fdCounterSignDeptNames}"/>
	<input type="hidden" id="selectIds" name="selectIds" value="${kmImissiveSendMainForm.fdCounterSignDeptIds}"/>
	<input type="hidden" id="selectNames" name="selectNames" value="${kmImissiveSendMainForm.fdCounterSignDeptNames}"/>
	<ui:button text="${lfn:message('km-imissive:robot.fdCounterSign.operation')}" 
		style="vertical-align:top; ${kmImissiveSendMainForm.method_GET eq 'print' ? 'display: none;' : ''}" id="sign" 
		onclick="Dialog_UnitTreeList(true, 
	                            'selectIds',
	                            'selectNames', ';', 
	                            'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
			                    '${ lfn:message(\'km-imissive:kmImissiveSendMain.fdCounterSignDept\') }',
			                    'kmImissiveUnitListService&parentId=!{value}',updateSendMain);">
    </ui:button>
		<script type="text/javascript">
			seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
				//更新主文档
				window.updateSendMain = function(){
					var oldIds = $("#fdCounterSignDeptIds").val();
					var oldNames = $("#fdCounterSignDeptNames").val();
					
					var newIds = $("#selectIds").val();
					var newNames = $("#selectNames").val();
					//不能为空
					if(newIds == ""){
		                dialog.alert('<bean:message bundle="km-imissive" key="robot.fdCounterSign.operation.notNull" />');
		                $("#selectIds").val(oldIds);
		                $("#selectNames").val(oldNames);
		                return;
					}
					
					if(oldIds == newIds){
						return;
					}
					var addIds = "";
					var deleteIds = "";
					idsArr = newIds.split(";");
					//增加的ids
					for ( var i=0 ; i < idsArr.length ; i++ ) {
						if(oldIds.indexOf(idsArr[i])<0){
							addIds += ";" + idsArr[i];
						}
					};
					//减少的ids
					idsArr = oldIds.split(";");
					for ( var j=0 ; j < idsArr.length ; j++ ) {
						if(newIds.indexOf(idsArr[j])<0){
							deleteIds += ";" + idsArr[j];
						}
					};
					if(addIds.indexOf(";")==0){
						addIds = addIds.substring(1, addIds.length);
					}
					if(deleteIds.indexOf(";")==0){
						deleteIds = deleteIds.substring(1, deleteIds.length);
					}
					var fdId = "${kmImissiveSendMainForm.fdId}";
					var url = "${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=updateSigner";
					var data ={fdId:fdId,addIds:addIds,deleteIds:deleteIds};
					   $.ajax({
								url :url,
								type : 'POST',
								dataType : 'json',
								data : data,
								success : function(data, textStatus, xhr) {
									if (data.result == true) {
										//更新页面
										$("#fdCounterSignDeptIds").val(newIds);
										$("#fdCounterSignDeptNames").val(newNames);
										$("#names").text(newNames);
										if(data.isSignEnd == true){
											$("#sign").hide();
									    }
										dialog.success('<bean:message key="return.optSuccess" />');
									} else {
										dialog.faiture('<bean:message key="return.optFailure" />');
									}
							}
						}); 
			    	};      
			 	 });
		</script>	
</kmss:auth>
</c:if>	 
