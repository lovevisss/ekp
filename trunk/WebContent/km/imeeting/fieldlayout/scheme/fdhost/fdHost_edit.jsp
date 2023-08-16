<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imeeting/fieldlayout/common/param_parser.jsp"%>
<%
	String isMobileC = (String)request.getParameter("mobile");
	if (StringUtil.isNull(isMobileC) || "false".equals(isMobileC)) {
		parse.addStyle("width", "control_width", "90%");
	}
%>
<div id="_fdHost" valField="fdHostId" xform_type="address">
<xform:address 
	isLoadDataDict="false"
    showStatus="edit"
    mobile="${param.mobile eq 'true'? 'true':'false'}"
	required="true"
	style="<%=parse.getStyle()%>"
	subject="${lfn:message('km-imeeting:kmImeetingScheme.fdHost')}"
	propertyId="fdHost" propertyName="fdHostName" onValueChange="addDeptPost"
	orgType='ORG_TYPE_PERSON' className="input" >
</xform:address>
</div>
<c:choose>
	<c:when test="${param.mobile eq 'true'}">
		<script>
			require(['dojo/ready','dijit/registry','dojo/dom','dojo/dom-attr','dojo/query','dojo/topic','dojo/request','dojo/query'],
					function(ready,registry,dom,domAttr,query,topic,request){
				window.addDeptPost = function(val){
					var fdStaffingLevel = query("input[name='fdStaffingLevel']");
					// var fdTransferStaffId = fdHost.get("value");
					var fdTransferStaffId = val;
					if (fdStaffingLevel.length > 0) {
						if(fdTransferStaffId){
							var url = "${LUI_ContextPath}/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=getPersonInfo&id="+fdTransferStaffId;
							var promise = request.post(url);
							promise.response.then(function(data) {
								var d = eval("(" + data.data + ")");
								if(d.level) {
									fdStaffingLevel[0].value = d.level.name;
									query("span#staffingLevelN")[0].innerHTML = d.level.name;
								}
							});
							
						} else {
							fdStaffingLevel[0].value='';
							query("span#staffingLevelN")[0].innerHTML = "";
						}
					}
				}
			});
		</script>
	</c:when>
	<c:otherwise>
		<script>
			seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'],function($, dialog, topic){
				window.addDeptPost = function(){
					var fdStaffingLevel = $('[name="fdStaffingLevel"]')[0];
					var fdTransferStaffId = $('input[name="fdHost"]').val();
					if (fdStaffingLevel) {
						if(fdTransferStaffId){
							$.ajax({
								url : '${LUI_ContextPath}/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=getPersonInfo',
								type: 'POST',
								dataType: 'json',
								data : {
									id : fdTransferStaffId
								},
								success : function(data, textStatus, xhr){
									var d = eval(data);
									if(fdStaffingLevel && d.level)
										fdStaffingLevel.value = d.level.name;
									if (d.level==undefined) {
										fdStaffingLevel.value='';
									}
								}
							});
						}else{
							if(fdStaffingLevel.value)
								fdStaffingLevel.value='';
						}
					}
				};
			});
		</script>
	</c:otherwise>
</c:choose>