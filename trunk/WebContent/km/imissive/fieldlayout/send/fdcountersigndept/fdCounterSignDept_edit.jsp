<%-- 会签 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%
    String fdCounterSignDeptIds = parse.getParamValue("fdCounterSignDeptIds");
    String fdCounterSignDeptNames = parse.getParamValue("fdCounterSignDeptNames");
    
    String defaultFdCounterSignDeptIds = parse.acquireValue("fdCounterSignDeptIds",fdCounterSignDeptIds);
    String defaultFdCounterSignDeptNames = parse.acquireValue("fdCounterSignDeptNames",fdCounterSignDeptNames);
    request.setAttribute("defaultFdCounterSignDeptIds",defaultFdCounterSignDeptIds);
    request.setAttribute("defaultFdCounterSignDeptNames",defaultFdCounterSignDeptNames);
	parse.addStyle("width", "control_width", "95%");
%>
<c:choose>
    <c:when test="${param.mobile eq 'true'}">
    	<c:set var="fdCounterSignDeptIds" value="<%=defaultFdCounterSignDeptIds%>"></c:set>
    	<c:set var="fdCounterSignDeptNames" value="<%=defaultFdCounterSignDeptNames%>"></c:set>
    	<c:if test="${kmImissiveSendMainForm.method_GET=='edit'}">
    		<c:set var="fdCounterSignDeptIds" value="${kmImissiveSendMainForm.fdCounterSignDeptIds}"></c:set>
    		<c:set var="fdCounterSignDeptNames" value="${kmImissiveSendMainForm.fdCounterSignDeptNames}"></c:set>
    	</c:if>
    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_counter_sign"
	    	 data-dojo-props='"afterSelect":function(evt){afterSelectSignDept(evt);},"idField":"fdCounterSignDeptIds","nameField":"fdCounterSignDeptNames","curIds":"${fdCounterSignDeptIds}","curNames":"${fdCounterSignDeptNames}","subject":"会签单位","title":"会签单位","showStatus":"edit","isMul":false,"validate":"required","required":true,
	   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileDataBeanService&parentId=!{parentId}",
	    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileDataBeanService&parentId=searchUnit&amp;fdKeyWord=!{keyword}",
	    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   	 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
		</div>
		<script>
			function afterSelectSignDept(evt){
				console.log(evt);
			}

			require(['dojo/ready','dijit/registry','dojo/topic'],function(ready,registry,topic){

				topic.subscribe('/mui/form/valueChanged',function(widget,args){

					if(widget && widget.nameField=="fdSendtoUnitName"){
						var fdUnitId = widget.curIds;

						var dialog_counter_sign = registry.byId("dialog_counter_sign");

						if(dialog_counter_sign){
							dialog_counter_sign.decDataUrl = '/sys/common/datajson.jsp?s_bean=sysUnitMobileAuthDataWithDecBeanService&parentId=!{parentId}&type=allUnit&fdUnitId='+fdUnitId;
							dialog_counter_sign.fdUnitId = fdUnitId;

							var counter_sign_ids = dialog_counter_sign.curIds;
							if(counter_sign_ids){
								var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=removeDecUnit&fdUnitIds="+counter_sign_ids;
								$.ajax({
									type:"post",
									url:url,
									async:true,
									success:function(data){
										var results =  eval("("+data+")");
										if(results['fdUnitIds']&&results['fdUnitNames']){
											dialog_counter_sign._setCurIdsAttr(results['fdUnitIds']);
											dialog_counter_sign._setCurNamesAttr(results['fdUnitNames']);
										}else{
											dialog_counter_sign._setCurIdsAttr("");
											dialog_counter_sign._setCurNamesAttr("");
										}
									}
								});
							}
						}

					}
				});
			});
		</script>
    </c:when>
    <c:otherwise>
    <div id="_fdCounterSignDept" valField="fdCounterSignDeptIds" xform_type="dialog">
	<xform:dialog  useNewStyle="true"
				  propertyId="fdCounterSignDeptIds" 
	              propertyName="fdCounterSignDeptNames"
	              idValue="<%=defaultFdCounterSignDeptIds%>"
	              nameValue="<%=defaultFdCounterSignDeptNames%>"
		          style="<%=parse.getStyle()%>"
		          className="inputsgl"
		          required="true"
		          subject="${ lfn:message('km-imissive:kmImissiveSendMain.fdCounterSignDept') }">
				counterSignSelectAllUnit();
	</xform:dialog>
	</div>
	<script>
	$(document).ready(function(){
		initNewDialog("fdCounterSignDeptIds","fdCounterSignDeptNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=all",true,"${defaultFdCounterSignDeptIds}","${defaultFdCounterSignDeptNames}",null);
	});

	function initEditCounterSign(){
		var ids = document.getElementsByName("fdCounterSignDeptIds")[0].value;
		var names = document.getElementsByName("fdCounterSignDeptNames")[0].value;
		resetNewDialog("fdCounterSignDeptIds","fdCounterSignDeptNames",";","kmImissiveUnitListService&parentId=!{value}",true,ids,names);
	}

	function counterSignSelectAllUnit(){
		var fdSendtoUnitId = document.getElementsByName("fdSendtoUnitId")[0].value;
		Dialog_UnitTreeList(true,
				'fdCounterSignDeptIds',
				'fdCounterSignDeptNames',
				';',
				'kmImissiveUnitCategoryTreeService&parentId=!{value}',
				'<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive" />',
				'kmImissiveUnitListService&parentId=!{value}&fdUnitId='+fdSendtoUnitId);
	}
	
	</script>
</c:otherwise>
</c:choose>