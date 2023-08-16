<%-- 发文单位 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@page import="java.net.URLEncoder" %>
<%@ page import="com.landray.kmss.util.StringUtil"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
  <%
	    String fdMissiveUnitListIds = parse.getParamValue("fdMissiveUnitListIds");
	    String fdMissiveUnitListNames = parse.getParamValue("fdMissiveUnitListNames");
	    if(StringUtil.isNotNull(fdMissiveUnitListNames)){
		       fdMissiveUnitListNames =  URLEncoder.encode(fdMissiveUnitListNames,"UTF-8");
	    }
	    String fdMissiveUnitId = parse.getParamValue("fdMissiveUnitId");
	    String fdMissiveUnitName = parse.getParamValue("fdMissiveUnitName");

	    String defaultValueId = parse.acquireValue("fdMissiveUnitId",fdMissiveUnitId);
	    String defaultValueName = parse.acquireValue("fdMissiveUnitName",fdMissiveUnitName);
	    if(StringUtil.isNull(defaultValueId)){
	    	defaultValueName = "";
	    }
		parse.addStyle("width", "control_width", "45%");
	%>
	
<c:choose>
    <c:when test="${param.mobile eq 'true'}">
    	<c:set var="fdSendtoUnitId" value="<%=defaultValueId%>"></c:set>
    	<c:set var="fdSendtoUnitName" value="<%=defaultValueName%>"></c:set>
    	<c:if test="${kmImissiveSendMainForm.method_GET=='edit' or not empty kmImissiveSendMainForm.fdSendtoUnitId}">
    		<c:set var="fdSendtoUnitId" value="${kmImissiveSendMainForm.fdSendtoUnitId}"></c:set>
    		<c:set var="fdSendtoUnitName" value="${kmImissiveSendMainForm.fdSendtoUnitName}"></c:set>
    	</c:if>
    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
	    	 data-dojo-props='"afterSelect":function(evt){afterSelectSend(evt);},"idField":"fdSendtoUnitId","nameField":"fdSendtoUnitName","curIds":"${fdSendtoUnitId}","curNames":"${fdSendtoUnitName}","subject":"发文单位","title":"发文单位","showStatus":"edit","isMul":false,"validate":"required","required":<%=required%>,
	   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitUseTreeService&ids=<%=fdMissiveUnitListIds%>&names=<%=fdMissiveUnitListNames%>&amp;mobile=true",
	   		 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitUseTreeService&ids=<%=fdMissiveUnitListIds%>&names=<%=fdMissiveUnitListNames%>&amp;fdKeyWord=!{keyword}",
	   		 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
		</div>
		<div id="sendToUnitTip" style="display:none;color:red;"><bean:message key="kmImissiveSendMain.fdSendtoDept.tip" bundle="km-imissive"/></div>
		<xform:checkbox property="fdIsJoint" mobile="true" showStatus="edit" value="${kmImissiveSendMainForm.fdIsJoint}" >
			<xform:simpleDataSource value="2"><bean:message key="kmImissiveSendMain.fdIsJoint" bundle="km-imissive" /></xform:simpleDataSource>
		</xform:checkbox>
		
		<div id="otherSendUnit" <c:if test="${kmImissiveSendMainForm.fdIsJoint != '2'}">style="display:none"</c:if>>
		<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
	    	 data-dojo-props='"afterSelect":function(evt){afterSelectSend(evt);},"idField":"fdOtherSendUnitIds","nameField":"fdOtherSendUnitNames","curIds":"${kmImissiveSendMainForm.fdOtherSendUnitIds}","curNames":"${kmImissiveSendMainForm.fdOtherSendUnitNames}","subject":"其他发文单位","title":"其他发文单位","showStatus":"edit","isMul":true,"validate":"required","required":false,
	   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitUseTreeService&ids=<%=fdMissiveUnitListIds%>&names=<%=fdMissiveUnitListNames%>&amp;mobile=true",
	   		"searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitUseTreeService&ids=<%=fdMissiveUnitListIds%>&names=<%=fdMissiveUnitListNames%>&amp;fdKeyWord=!{keyword}",
	   		 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
		</div>
		</div>
		<script>
		require(['dojo/ready','dijit/registry','dojo/topic','dojo/query','dojo/dom-style','dojo/dom-class',"dojo/_base/lang","mui/dialog/Tip","dojo/request","mui/device/adapter","mui/util"],
				function(ready,registry,topic,query,domStyle,domClass,lang,Tip,req,adapter,util){
			topic.subscribe('/mui/form/valueChanged',function(widget,args){
				if(widget && widget.name=="fdIsJoint"){
					if(args.value.indexOf('2') > -1){
						setTimeout(function(){
							document.getElementsByName("fdIsJoint")[0].value = '2';
							document.getElementById('otherSendUnit').style.display = 'block';
						},100);
						
					}else{
						setTimeout(function(){
							document.getElementsByName("fdIsJoint")[0].value = '1';
						   	 document.getElementById('otherSendUnit').style.display = 'none';
					    	document.getElementsByName("fdOtherSendUnitIds")[0].value = "";
					    	document.getElementsByName("fdOtherSendUnitNames")[0].value = "";
						},100);
					}
				}
			});
		});
			function afterSelectSend(evt){
				console.log(evt);
			}

		$(document).ready(function(){
			var fdCopytoIds = document.getElementsByName("fdCopytoIds")[0];
			var fdMaintoIds = document.getElementsByName("fdMaintoIds")[0];
			var fdReporttoIds = document.getElementsByName("fdReporttoIds")[0];
			if(fdCopytoIds || fdMaintoIds || fdReporttoIds){
				document.getElementById('sendToUnitTip').style.display = 'block';
			}
		});
		</script>
    </c:when>
    <c:otherwise>
    	<div id="_fdSendtoUnit" valField="fdSendtoUnitId" xform_type="dialog">
		<xform:dialog propertyId="fdSendtoUnitId"
					  idValue="<%=defaultValueId%>"
					  nameValue="<%=defaultValueName%>"
			          propertyName="fdSendtoUnitName" 
			          required="<%=required%>"
			          style="<%=parse.getStyle()%>" 
			          className="inputsgl"
			          subject="${ lfn:message('km-imissive:kmImissiveSendMain.fdSendtoDept') }">
				      Dialog_Tree(false, 'fdSendtoUnitId', 'fdSendtoUnitName', ',', 
				                         'kmImissiveUnitUseTreeService&ids=<%=fdMissiveUnitListIds%>&names=<%=fdMissiveUnitListNames%>',
				                         '<bean:message key="kmImissiveSendMain.fdSendtoDept" bundle="km-imissive" />', 
				                         null, changeSendToUnit, '', null, null, '<bean:message bundle="km-imissive" key="kmImissiveSendMain.fdUnitId" />');
		</xform:dialog>
		</div>
		<div id="sendToUnitTip" style="display:none;color:red;"><bean:message key="kmImissiveSendMain.fdSendtoDept.tip" bundle="km-imissive"/></div>
		<html:hidden property="fdIsJoint" value="${kmImissiveSendMainForm.fdIsJoint}"/>
		<input name="isJoint" type="checkbox"   onchange="changeIsJoint(this);" <c:if test="${kmImissiveSendMainForm.fdIsJoint eq '2'}">checked="checked"</c:if>><bean:message key="kmImissiveSendMain.fdIsJoint" bundle="km-imissive" />
		<br>
		<div id="otherSendUnit" style="display:none">
		<div id="_fdOtherSendUnit" valField="fdOtherSendUnitIds" xform_type="dialog">
		<xform:dialog propertyId="fdOtherSendUnitIds"
			          propertyName="fdOtherSendUnitNames" 
			          style="<%=parse.getStyle()%>" 
			          className="inputsgl"
			          subject="${ lfn:message('km-imissive:kmImissiveSendMain.fdOtherSendUnit') }">
			           Dialog_UnitTreeList(true, 'fdOtherSendUnitIds', 'fdOtherSendUnitNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}',
				      '<bean:message key="kmImissiveSendMain.fdOtherSendUnit" bundle="km-imissive" />', 'kmImissiveUnitListService&parentId=!{value}');
		</xform:dialog>
		</div>
		</div>
		<script>
		$(document).ready(function(){
			if("${kmImissiveSendMainForm.fdIsJoint}" == "2"){
				document.getElementById('otherSendUnit').style.display = 'block';
			}
			var fdCopytoIds = document.getElementsByName("fdCopytoIds")[0];
			var fdMaintoIds = document.getElementsByName("fdMaintoIds")[0];
			var fdReporttoIds = document.getElementsByName("fdReporttoIds")[0];
			var fdCounterSignDeptIds = document.getElementsByName("fdCounterSignDeptIds")[0];
			if(fdCopytoIds || fdMaintoIds || fdReporttoIds || fdCounterSignDeptIds){
				document.getElementById('sendToUnitTip').style.display = 'block';
			}
		});

		function changeSendToUnit(rtnVal){

			var fdMissiveTypeVal = '';
			var fdMissiveType = document.getElementsByName("fdMissiveType");
			if(fdMissiveType.length > 0){
				for(var i=0;i<fdMissiveType.length;i++){
					if(fdMissiveType[i].checked){
						fdMissiveTypeVal = fdMissiveType[i].value;
					}
				}
			}

			var fdMaintoIds = document.getElementsByName("fdMaintoIds")[0];
			var fdMaintoNames = document.getElementsByName("fdMaintoNames")[0];

			if(fdMaintoIds && fdMaintoNames){
				var mainIdValue = fdMaintoIds.value;
				if(mainIdValue){
					var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=removeDecUnit&fdUnitIds="+mainIdValue;
					$.ajax({
						type:"post",
						url:url,
						async:true,
						success:function(data){
							var results =  eval("("+data+")");
							if(results['fdUnitIds']&&results['fdUnitNames']){
								fdMaintoIds.value = results['fdUnitIds'];
								fdMaintoNames.value = results['fdUnitNames'];
							}else{
								fdMaintoIds.value = "";
								fdMaintoNames.value = "";
							}
							initEditMain(fdMissiveTypeVal);
						}
					});
				}
			}

			var fdCopytoIds = document.getElementsByName("fdCopytoIds")[0];
			var fdCopytoNames = document.getElementsByName("fdCopytoNames")[0];

			if(fdCopytoIds && fdCopytoNames){
				var copyIdValue = fdCopytoIds.value;
				if(copyIdValue){
					var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=removeDecUnit&fdUnitIds="+copyIdValue;
					$.ajax({
						type:"post",
						url:url,
						async:true,
						success:function(data){
							var results =  eval("("+data+")");
							if(results['fdUnitIds']&&results['fdUnitNames']){
								fdCopytoIds.value = results['fdUnitIds'];
								fdCopytoNames.value = results['fdUnitNames'];
							}else{
								fdCopytoIds.value = "";
								fdCopytoNames.value = "";
							}
							initEditCopy(fdMissiveTypeVal);
						}
					});
				}
			}


			var fdReporttoIds = document.getElementsByName("fdReporttoIds")[0];
			var fdReporttoNames = document.getElementsByName("fdReporttoNames")[0];

			if(fdReporttoIds && fdReporttoNames){
				var reportIdValue = fdReporttoIds.value;
				if(reportIdValue){
					var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=removeDecUnit&fdUnitIds="+reportIdValue;
					$.ajax({
						type:"post",
						url:url,
						async:true,
						success:function(data){
							var results =  eval("("+data+")");
							if(results['fdUnitIds']&&results['fdUnitNames']){
								fdReporttoIds.value = results['fdUnitIds'];
								fdReporttoNames.value = results['fdUnitNames'];
							}else{
								fdReporttoIds.value = "";
								fdReporttoNames.value = "";
							}
							initEditReport(fdMissiveTypeVal);
						}
					});
				}
			}

			var fdCounterSignDeptIds = document.getElementsByName("fdCounterSignDeptIds")[0];
			var fdCounterSignDeptNames = document.getElementsByName("fdCounterSignDeptNames")[0];

			if(fdCounterSignDeptIds && fdCounterSignDeptNames){
				var counterSignIdValue = fdCounterSignDeptIds.value;
				if(counterSignIdValue){
					var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=removeDecUnit&fdUnitIds="+counterSignIdValue;
					$.ajax({
						type:"post",
						url:url,
						async:true,
						success:function(data){
							var results =  eval("("+data+")");
							if(results['fdUnitIds']&&results['fdUnitNames']){
								fdCounterSignDeptIds.value = results['fdUnitIds'];
								fdCounterSignDeptNames.value = results['fdUnitNames'];
							}else{
								fdCounterSignDeptIds.value = "";
								fdCounterSignDeptNames.value = "";
							}
							initEditCounterSign();
						}
					});
				}
			}

		}
		
		function changeIsJoint(obj){
			var fdIsJoint = document.getElementsByName("fdIsJoint")[0];
			if(obj.checked){
				fdIsJoint.value="2";
		    	document.getElementById('otherSendUnit').style.display = 'block';
		    }else{
		    	fdIsJoint.value="1";
		   	 document.getElementById('otherSendUnit').style.display = 'none';
		    	document.getElementsByName("fdOtherSendUnitIds")[0].value = "";
		    	document.getElementsByName("fdOtherSendUnitNames")[0].value = "";
		    }
		}
		
		</script>
</c:otherwise>
</c:choose>
